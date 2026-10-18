import Foundation
import Combine
import SwiftUI

/// Owns every live quote the Market tab shows: the watchlist, the index
/// "powerhouses" strip, and — critically — every symbol the user actually
/// owns (stock or option underlying), so portfolio value is always priced
/// off a real quote instead of silently falling back to cost basis.
@MainActor
final class MarketViewModel: ObservableObject {
    /// The "powerhouses" strip: the big U.S. indexes, tracked through
    /// their ETF proxies because Finnhub's free tier quotes ETFs but not
    /// raw index symbols. Same numbers everyone watches, free to fetch.
    static let indexProxies: [(symbol: String, name: String)] = [
        ("SPY", "S&P 500"),
        ("QQQ", "NASDAQ 100"),
        ("DIA", "Dow Jones"),
        ("IWM", "Russell 2000")
    ]

    @Published var stocks: [Stock] = SampleData.stocks.map { $0.withGeneratedHistoryIfNeeded() }
    @Published var indexes: [Stock] = SampleData.indexes
    /// Quotes for anything the user holds that isn't already on the
    /// watchlist or index strip (e.g. a ticker they found through search).
    @Published var heldQuotes: [Stock] = []
    @Published var isLoading = false
    @Published var lastUpdated: Date?

    // Ticker search
    @Published var searchText = ""
    @Published var searchResults: [SymbolMatch] = []
    @Published var isSearching = false
    @Published var searchedStock: Stock?

    private let service: MarketDataProviding = FinnhubMarketDataService()

    /// Every quote we have, de-duplicated by symbol. This is the single
    /// price source the portfolio math reads from.
    var allQuotes: [Stock] {
        var seen = Set<String>()
        return (stocks + indexes + heldQuotes).filter { seen.insert($0.symbol).inserted }
    }

    func quote(for symbol: String) -> Stock? {
        allQuotes.first { $0.symbol == symbol }
    }

    /// Symbols the user owns that no other list is already fetching.
    private var unpricedHeldSymbols: [String] {
        guard let user = AppState.shared.currentUser else { return [] }
        let owned = user.holdings.map(\.symbol) + (user.optionPositions ?? []).map(\.symbol)
        let covered = Set(Constants.watchlistSymbols + Self.indexProxies.map(\.symbol))
        return Array(Set(owned).subtracting(covered)).sorted()
    }

    func loadWatchlist() async {
        isLoading = true
        // All three groups load in parallel.
        async let popularTask = try? service.fetchQuotes(symbols: Constants.watchlistSymbols)
        async let indexTask = try? service.fetchQuotes(symbols: Self.indexProxies.map(\.symbol))
        async let heldTask = try? service.fetchQuotes(symbols: unpricedHeldSymbols)

        if let fetched = await popularTask, !fetched.isEmpty {
            stocks = fetched
        }
        if let fetchedIndexes = await indexTask, !fetchedIndexes.isEmpty {
            // Swap ETF names for the index names people actually know.
            indexes = fetchedIndexes.map { stock in
                var copy = stock
                if let proxy = Self.indexProxies.first(where: { $0.symbol == stock.symbol }) {
                    copy.companyName = proxy.name
                }
                return copy
            }
        }
        if let fetchedHeld = await heldTask {
            heldQuotes = fetchedHeld
        }
        lastUpdated = Date()
        isLoading = false
    }

    func runSearch() async {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { searchResults = []; return }
        isSearching = true
        searchResults = (try? await service.searchSymbol(query: query)) ?? []
        isSearching = false
    }

    func clearSearch() {
        searchText = ""
        searchResults = []
    }

    /// Loads a live quote for any symbol (from search) and returns it for
    /// navigation. The quote is remembered so that if the user buys it,
    /// the portfolio is priced immediately. Falls back to an
    /// already-loaded stock if the fetch fails.
    func openSymbol(_ symbol: String) async -> Stock? {
        if let quote = try? await service.fetchQuote(symbol: symbol), quote.currentPrice > 0 {
            heldQuotes.removeAll { $0.symbol == symbol }
            heldQuotes.append(quote)
            return quote
        }
        return quote(for: symbol)
    }
}
