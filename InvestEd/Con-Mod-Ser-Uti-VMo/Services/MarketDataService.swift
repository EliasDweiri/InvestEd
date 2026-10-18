import Foundation

/// Anything that can hand the app live market quotes. Kept as a protocol so
/// the view models never depend on a specific data vendor, and so tests or
/// previews can swap in a fake provider.
protocol MarketDataProviding: Sendable {
    func fetchQuote(symbol: String) async throws -> Stock
    func fetchQuotes(symbols: [String]) async throws -> [Stock]
    func searchSymbol(query: String) async throws -> [SymbolMatch]
}

enum MarketDataError: Error {
    case invalidResponse
}

/// Live market data from Finnhub (finnhub.io), fetched THROUGH our own
/// Cloudflare Worker rather than directly.
///
/// Why a proxy?
///   1. Security — the Finnhub API key lives only on the server as a Worker
///      secret. Anything compiled into an iOS app can be extracted from the
///      binary, so the key never ships in the app.
///   2. Rate limits — Finnhub's free tier allows ~60 calls/minute. The Worker
///      caches quotes for a few seconds and company names for a week, so many
///      students opening the app at once share one upstream call.
///   3. Fewer round trips — `/market/stock` returns price, previous close and
///      company name in a single response (Finnhub needs two calls for that).
///
/// If the network or Worker is unavailable, every call degrades to realistic
/// `SampleData` so the simulator still works offline (e.g. during a demo).
final class FinnhubMarketDataService: MarketDataProviding {
    private let baseURL = "\(Constants.workerURL)/market"
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 8
        return URLSession(configuration: config)
    }()

    func fetchQuote(symbol: String) async throws -> Stock {
        do {
            let encoded = symbol.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? symbol
            let url = URL(string: "\(baseURL)/stock?symbol=\(encoded)")!
            let (data, response) = try await session.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw MarketDataError.invalidResponse }
            let quote = try JSONDecoder().decode(WorkerStockQuote.self, from: data)
            // Finnhub returns c = 0 for unknown tickers rather than an error.
            guard quote.c > 0 else { throw MarketDataError.invalidResponse }

            return Stock(
                symbol: symbol,
                companyName: quote.name ?? symbol,
                currentPrice: quote.c,
                previousClose: quote.pc,
                priceHistory: []
            ).withGeneratedHistoryIfNeeded()
        } catch {
            if let sample = (SampleData.stocks + SampleData.indexes).first(where: { $0.symbol == symbol }) {
                return sample
            }
            throw error
        }
    }

    /// Fetches many quotes concurrently (not one after another), then
    /// returns them in the same order the symbols were requested.
    /// Symbols that fail are skipped rather than failing the whole batch.
    func fetchQuotes(symbols: [String]) async throws -> [Stock] {
        guard !symbols.isEmpty else { return [] }
        let fetched = await withTaskGroup(of: (Int, Stock?).self) { group in
            for (index, symbol) in symbols.enumerated() {
                group.addTask { (index, try? await self.fetchQuote(symbol: symbol)) }
            }
            var results: [(Int, Stock)] = []
            for await (index, stock) in group {
                if let stock { results.append((index, stock)) }
            }
            return results
        }
        return fetched.sorted { $0.0 < $1.0 }.map(\.1)
    }

    func searchSymbol(query: String) async throws -> [SymbolMatch] {
        do {
            let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
            let url = URL(string: "\(baseURL)/search?q=\(encoded)")!
            let (data, _) = try await session.data(from: url)
            let result = try JSONDecoder().decode(FinnhubSearchResult.self, from: data)
            // Plain US tickers first — skip crypto pairs and odd instruments
            // so beginners see AAPL before AAPL.SW.
            return result.result
                .filter { !$0.symbol.contains(".") && !$0.symbol.contains(":") }
                .prefix(8)
                .map { SymbolMatch(symbol: $0.symbol, description: $0.description.capitalized) }
        } catch {
            // Offline fallback: search the built-in sample list.
            return SampleData.stocks
                .filter { $0.symbol.localizedCaseInsensitiveContains(query) || $0.companyName.localizedCaseInsensitiveContains(query) }
                .map { SymbolMatch(symbol: $0.symbol, description: $0.companyName) }
        }
    }
}

/// Response from the Worker's `/market/stock` route: Finnhub's quote fields
/// plus the company name merged in server-side.
struct WorkerStockQuote: Codable {
    let c: Double     // current price
    let pc: Double    // previous close
    let name: String? // company name (from Finnhub's profile endpoint, cached)
}

struct FinnhubSearchResult: Codable {
    let result: [FinnhubSearchItem]
}

struct FinnhubSearchItem: Codable {
    let symbol: String
    let description: String
}
