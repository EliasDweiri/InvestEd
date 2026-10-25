import SwiftUI
import Charts

/// The Market tab, full trading floor edition:
/// - "Market Powerhouses" strip — S&P 500, NASDAQ 100, Dow, Russell 2000
/// - ticker search for any listed stock
/// - your virtual portfolio (cash + stocks + options)
/// - popular stocks with mini trend graphs
/// - an Options Playground on every stock's detail page
/// - Penny tips in the bottom-right corner, tucked out of the way
struct MarketView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var marketVM = MarketViewModel()
    @StateObject private var portfolioVM = PortfolioViewModel()

    var body: some View {
        NavigationStack {
            TabScreen(tab: .market) {
                PennyCompanion(tab: .market)
            } hero: {
                portfolioHero
            } content: {
                searchSection
                powerhousesSection
                if !(appState.currentUser?.holdings.isEmpty ?? true) {
                    holdingsSection
                }
                if !portfolioVM.optionPositions.isEmpty {
                    optionsSection
                }
                popularSection
            }
            .refreshable { await marketVM.loadWatchlist() }
            .navigationDestination(item: $marketVM.searchedStock) { stock in
                StockDetailView(stock: stock, portfolioVM: portfolioVM)
            }
            .navigationDestination(for: String.self) { symbol in
                if let stock = marketVM.quote(for: symbol) {
                    StockDetailView(stock: stock, portfolioVM: portfolioVM)
                }
            }
            .task {
                await marketVM.loadWatchlist()
                portfolioVM.settleExpiredOptions(stocks: marketVM.allQuotes)
            }
        }
    }

    // MARK: - Market powerhouses (indexes)

    private var powerhousesSection: some View {
        PaperSection(title: "Market indexes") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(marketVM.indexes) { index in
                        NavigationLink(value: index.symbol) {
                            IndexCard(stock: index)
                        }
                        .buttonStyle(SpringPressStyle())
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }

    // MARK: - Ticker search

    private var searchSection: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AppTheme.textSecondary)
                TextField("Search any ticker: AAPL, DIS, F…", text: $marketVM.searchText)
                    .textInputAutocapitalization(.characters)
                    .autocorrectionDisabled()
                    .submitLabel(.search)
                    .onSubmit {
                        Task { await marketVM.runSearch() }
                    }
                if !marketVM.searchText.isEmpty {
                    Button {
                        marketVM.clearSearch()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                if marketVM.isSearching { ProgressView() }
            }
            .padding(14)
            .cardSurface(radius: 14)

            ForEach(marketVM.searchResults) { match in
                Button {
                    Task {
                        if let stock = await marketVM.openSymbol(match.symbol) {
                            marketVM.searchedStock = stock
                            marketVM.clearSearch()
                        }
                    }
                } label: {
                    HStack {
                        Text(match.symbol)
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        Text(match.description)
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.textSecondary)
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    .padding(12)
                    .cardSurface(radius: 12)
                }
                .buttonStyle(SpringPressStyle())
            }
        }
    }

    // MARK: - Portfolio

    /// Portfolio value lives in the header — it's the number that matters most here.
    private var portfolioHero: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("PORTFOLIO VALUE")
                    .font(AppTheme.kickerFont)
                    .tracking(1.2)
                    .foregroundColor(AppTheme.onInk.opacity(0.75))
                Text(portfolioVM.totalPortfolioValue(stocks: marketVM.allQuotes), format: .currency(code: "USD"))
                    .font(.system(size: 38, weight: .bold, design: .serif).monospacedDigit())
                    .foregroundColor(AppTheme.onInk)
                    .contentTransition(.numericText())
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                totalReturnBadge
            }
            HStack(spacing: 8) {
                HeaderStat(icon: "banknote", value: (appState.currentUser?.cashBalance ?? 0).formatted(.currency(code: "USD").precision(.fractionLength(0))), label: "cash")
                HeaderStat(icon: "chart.bar.fill", value: portfolioVM.totalHoldingsValue(stocks: marketVM.allQuotes).formatted(.currency(code: "USD").precision(.fractionLength(0))), label: "stocks")
                if !portfolioVM.optionPositions.isEmpty {
                    HeaderStat(icon: "arrow.up.arrow.down", value: portfolioVM.totalOptionsValue(stocks: marketVM.allQuotes).formatted(.currency(code: "USD").precision(.fractionLength(0))), label: "options")
                }
            }
        }
    }

    /// All-time gain/loss vs the $10,000 starting balance — the most motivating
    /// number in the sim.
    private var totalReturnBadge: some View {
        let total = portfolioVM.totalPortfolioValue(stocks: marketVM.allQuotes)
        let gain = total - Constants.startingCashBalance
        let pct = Constants.startingCashBalance == 0 ? 0 : gain / Constants.startingCashBalance * 100
        return HStack(spacing: 5) {
            Image(systemName: gain >= 0 ? "arrow.up.right" : "arrow.down.right")
                .font(.system(size: 11, weight: .bold))
            Text("\(gain >= 0 ? "+" : "")\(gain, format: .currency(code: "USD")) (\(pct, specifier: "%.2f")%) all-time")
                .font(AppTheme.captionFont.bold())
        }
        .foregroundColor(AppTheme.onInk)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(AppTheme.onInk.opacity(0.15), in: RoundedRectangle(cornerRadius: 6))
    }

    // MARK: - Holdings

    private var holdingsSection: some View {
        PaperSection(title: "Your holdings") {
            ListCard(data: appState.currentUser?.holdings ?? []) { holding in
                NavigationLink(value: holding.symbol) {
                    HoldingRow(holding: holding, currentPrice: marketVM.quote(for: holding.symbol)?.currentPrice)
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Open option positions

    private var optionsSection: some View {
        PaperSection(title: "Your options") {
            ListCard(data: portfolioVM.optionPositions) { position in
                OptionPositionRow(
                    position: position,
                    currentValue: portfolioVM.optionValue(position, stocks: marketVM.allQuotes)
                ) {
                    portfolioVM.closeOption(position, stocks: marketVM.allQuotes)
                }
            }
        }
    }

    // MARK: - Popular stocks

    private var popularSection: some View {
        PaperSection(title: "Popular stocks") {
            if marketVM.isLoading { ProgressView().controlSize(.small) }
        } content: {
            ListCard(data: marketVM.stocks) { stock in
                NavigationLink {
                    StockDetailView(stock: stock, portfolioVM: portfolioVM)
                } label: {
                    StockRow(stock: stock)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

// MARK: - Sparkline (mini trend graph)

/// A tiny axis-free line chart used in rows and index cards.
struct Sparkline: View {
    let history: [PricePoint]
    let rising: Bool
    var height: CGFloat = 30

    var body: some View {
        Chart(history) { point in
            LineMark(x: .value("Date", point.date), y: .value("Price", point.price))
                .foregroundStyle(rising ? AppTheme.primaryGreen : AppTheme.dangerRed)
                .interpolationMethod(.catmullRom)
                .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round))
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartYScale(domain: .automatic(includesZero: false))
        .frame(height: height)
        .allowsHitTesting(false)
    }
}

// MARK: - Index card

private struct IndexCard: View {
    let stock: Stock

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(stock.companyName)
                .font(AppTheme.captionFont.bold())
                .foregroundColor(AppTheme.textSecondary)
                .lineLimit(1)
            Text(stock.currentPrice, format: .currency(code: "USD"))
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(AppTheme.textPrimary)
            Text("\(stock.change >= 0 ? "+" : "")\(stock.changePercent, specifier: "%.2f")%")
                .font(AppTheme.captionFont)
                .foregroundColor(stock.change >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed)
            if !stock.priceHistory.isEmpty {
                Sparkline(history: stock.priceHistory, rising: stock.change >= 0, height: 26)
            }
        }
        .frame(width: 130, alignment: .leading)
        .padding(12)
        .cardSurface(radius: 16)
    }
}

// MARK: - Rows

private struct StockRow: View {
    let stock: Stock

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(stock.symbol)
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text(stock.companyName)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .lineLimit(1)
            }
            Spacer()
            if !stock.priceHistory.isEmpty {
                Sparkline(history: stock.priceHistory, rising: stock.change >= 0)
                    .frame(width: 64)
            }
            VStack(alignment: .trailing, spacing: 3) {
                Text(stock.currentPrice, format: .currency(code: "USD"))
                    .font(AppTheme.bodyFont.bold().monospacedDigit())
                    .foregroundColor(AppTheme.textPrimary)
                Text("\(stock.change >= 0 ? "+" : "")\(stock.changePercent, specifier: "%.2f")%")
                    .font(AppTheme.captionFont)
                    .foregroundColor(stock.change >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }
}

private struct HoldingRow: View {
    let holding: Holding
    let currentPrice: Double?

    private var value: Double { holding.shares * (currentPrice ?? holding.averageCost) }
    private var gain: Double { value - holding.shares * holding.averageCost }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(holding.symbol)
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("\(holding.shares, specifier: "%.2f") shares · avg \(holding.averageCost, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 3) {
                Text(value, format: .currency(code: "USD"))
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("\(gain >= 0 ? "+" : "")\(gain, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(gain >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }
}

private struct OptionPositionRow: View {
    let position: OptionPosition
    let currentValue: Double   // per share
    let onClose: () -> Void

    private var totalValue: Double { currentValue * 100 * Double(position.contracts) }
    private var gain: Double { totalValue - position.totalCost }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(position.displayName)
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("\(position.contracts) contract\(position.contracts == 1 ? "" : "s") · paid \(position.totalCost, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 3) {
                Text(totalValue, format: .currency(code: "USD"))
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("\(gain >= 0 ? "+" : "")\(gain, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(gain >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed)
            }
            Button {
                onClose()
            } label: {
                Text("Close")
                    .font(AppTheme.captionFont.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .background(AppTheme.secondaryBlue)
                    .clipShape(Capsule())
            }
            .buttonStyle(SpringPressStyle())
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
    }
}

// MARK: - Stock detail: chart, trading, options

struct StockDetailView: View {
    let stock: Stock
    @ObservedObject var portfolioVM: PortfolioViewModel
    @EnvironmentObject var appState: AppState

    @State private var sharesText = ""
    @State private var confirmation: String?
    @State private var showOptionsSheet = false

    private var shares: Double { Double(sharesText) ?? 0 }
    private var owned: Holding? { portfolioVM.holding(for: stock.symbol) }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    priceHeader
                    if !stock.priceHistory.isEmpty { chart }
                    tradeCard
                    optionsCard
                }
                .padding()
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(stock.symbol)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showOptionsSheet) {
            OptionsPlaygroundSheet(stock: stock, portfolioVM: portfolioVM)
        }
    }

    private var priceHeader: some View {
        VStack(spacing: 6) {
            Text(stock.companyName)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textSecondary)
            Text(stock.currentPrice, format: .currency(code: "USD"))
                .font(AppTheme.titleFont)
                .foregroundColor(AppTheme.textPrimary)
            Text("\(stock.change >= 0 ? "+" : "")\(stock.change, format: .currency(code: "USD")) (\(stock.changePercent, specifier: "%.2f")%) today")
                .font(AppTheme.captionFont)
                .foregroundColor(stock.change >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed)
        }
    }

    /// Floor of the chart's y-axis: a little under the lowest price, so the
    /// line uses the full height instead of hugging the top above a $0 floor.
    private var chartFloor: Double {
        let prices = stock.priceHistory.map(\.price)
        guard let low = prices.min(), let high = prices.max() else { return 0 }
        return max(low - (high - low) * 0.15 - 0.01, 0)
    }

    private var chart: some View {
        VStack(alignment: .leading, spacing: 6) {
            Chart(stock.priceHistory) { point in
                AreaMark(x: .value("Date", point.date),
                         yStart: .value("Floor", chartFloor),
                         yEnd: .value("Price", point.price))
                    .foregroundStyle((stock.change >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed).opacity(0.10))
                    .interpolationMethod(.catmullRom)
                LineMark(x: .value("Date", point.date), y: .value("Price", point.price))
                    .foregroundStyle(stock.change >= 0 ? AppTheme.primaryGreen : AppTheme.dangerRed)
                    .interpolationMethod(.catmullRom)
                    .lineStyle(StrokeStyle(lineWidth: 2))
            }
            .chartYScale(domain: .automatic(includesZero: false))
            .frame(height: 180)
            Text("30-day trend · simulated preview anchored to the live price")
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding()
        .cardSurface()
    }

    private var tradeCard: some View {
        VStack(spacing: 14) {
            HStack {
                Text("Practice Trade")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.textPrimary)
                Spacer()
                Text("Cash: \(appState.currentUser?.cashBalance ?? 0, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            if let owned {
                Text("You own \(owned.shares, specifier: "%.2f") shares (avg \(owned.averageCost, format: .currency(code: "USD")))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            TextField("Number of shares", text: $sharesText)
                .keyboardType(.decimalPad)
                .padding(14)
                .background(AppTheme.background)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            if shares > 0 {
                Text("Total: \(shares * stock.currentPrice, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            HStack(spacing: 12) {
                PrimaryButton(title: "Buy") {
                    portfolioVM.errorMessage = nil
                    portfolioVM.buy(symbol: stock.symbol, shares: shares, price: stock.currentPrice)
                    finishTrade(verb: "Bought")
                }
                SecondaryButton(title: "Sell") {
                    portfolioVM.errorMessage = nil
                    portfolioVM.sell(symbol: stock.symbol, shares: shares, price: stock.currentPrice)
                    finishTrade(verb: "Sold")
                }
            }
            if let error = portfolioVM.errorMessage {
                Text(error)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.dangerRed)
            } else if let confirmation {
                Text(confirmation)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.primaryGreen)
            }
        }
        .padding()
        .cardSurface()
    }

    private var optionsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "arrow.up.arrow.down.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(AppTheme.secondaryBlue)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Options Playground")
                        .font(AppTheme.headingFont)
                        .foregroundColor(AppTheme.textPrimary)
                    Text("Practice calls and puts on \(stock.symbol) with fake money and realistic pricing.")
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
            SecondaryButton(title: "Trade Options") {
                showOptionsSheet = true
            }
        }
        .padding()
        .cardSurface()
    }

    private func finishTrade(verb: String) {
        if portfolioVM.errorMessage == nil, shares > 0 {
            confirmation = "\(verb) \(sharesText) share(s) of \(stock.symbol)!"
            sharesText = ""
        }
    }
}

// MARK: - Options Playground sheet

/// Build an option step by step: call or put, strike, expiry, contracts.
/// The premium updates live from a Black-Scholes model, and every choice
/// shows its plain-English meaning so it teaches while you trade.
struct OptionsPlaygroundSheet: View {
    let stock: Stock
    @ObservedObject var portfolioVM: PortfolioViewModel
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var kind: OptionKind = .call
    @State private var strikeOffset: Double = 0     // -0.10 ... +0.10 of spot
    @State private var expiryDays: Int = 30
    @State private var contracts = 1
    @State private var feedback: String?
    @State private var success = false

    private static let strikeOffsets: [Double] = [-0.10, -0.05, 0, 0.05, 0.10]
    private static let expiryChoices: [(days: Int, label: String)] = [(7, "1 week"), (30, "1 month"), (90, "3 months")]

    private var strike: Double {
        // Round to a clean number like real strike prices.
        let raw = stock.currentPrice * (1 + strikeOffset)
        return raw >= 100 ? (raw / 5).rounded() * 5 : raw.rounded()
    }

    private var expiry: Date {
        Calendar.current.date(byAdding: .day, value: expiryDays, to: Date()) ?? Date()
    }

    private var premium: Double {
        OptionPricer.value(kind: kind, spot: stock.currentPrice, strike: strike, expiry: expiry)
    }

    private var totalCost: Double { premium * 100 * Double(contracts) }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 18) {
                        header

                        Picker("Type", selection: $kind) {
                            ForEach(OptionKind.allCases, id: \.self) { k in
                                Text(k.label).tag(k)
                            }
                        }
                        .pickerStyle(.segmented)

                        Text(kind.explainer)
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        section("Strike price") {
                            HStack(spacing: 8) {
                                ForEach(Self.strikeOffsets, id: \.self) { offset in
                                    chip(
                                        title: offset == 0 ? "At price" : "\(offset > 0 ? "+" : "")\(Int(offset * 100))%",
                                        selected: strikeOffset == offset
                                    ) { strikeOffset = offset }
                                }
                            }
                            Text("Strike: \(strike, format: .currency(code: "USD")). That's the price your bet is measured against.")
                                .font(AppTheme.captionFont)
                                .foregroundColor(AppTheme.textSecondary)
                        }

                        section("Expiry") {
                            HStack(spacing: 8) {
                                ForEach(Self.expiryChoices, id: \.days) { choice in
                                    chip(title: choice.label, selected: expiryDays == choice.days) {
                                        expiryDays = choice.days
                                    }
                                }
                            }
                            Text("More time costs more, because the stock has longer to move your way.")
                                .font(AppTheme.captionFont)
                                .foregroundColor(AppTheme.textSecondary)
                        }

                        section("Contracts") {
                            Stepper(value: $contracts, in: 1...10) {
                                Text("\(contracts) contract\(contracts == 1 ? "" : "s") = \(contracts * 100) shares")
                                    .font(AppTheme.bodyFont)
                                    .foregroundColor(AppTheme.textPrimary)
                            }
                        }

                        quoteCard

                        PrimaryButton(title: "Buy for \(totalCost.formatted(.currency(code: "USD")))") {
                            portfolioVM.errorMessage = nil
                            portfolioVM.buyOption(symbol: stock.symbol, kind: kind, strike: strike,
                                                  expiry: expiry, contracts: contracts, premium: premium)
                            if portfolioVM.errorMessage == nil {
                                success = true
                                feedback = "Position opened! Watch it under \"Your Options\" on the Market tab."
                            } else {
                                success = false
                                feedback = portfolioVM.errorMessage
                            }
                        }

                        if let feedback {
                            Text(feedback)
                                .font(AppTheme.captionFont)
                                .foregroundColor(success ? AppTheme.primaryGreen : AppTheme.dangerRed)
                                .multilineTextAlignment(.center)
                        }

                        Text("Simulated pricing (Black-Scholes, 30% volatility). Real options quotes vary. This is for learning, not investment advice.")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(AppTheme.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .padding(.bottom, 30)
                }
            }
            .navigationTitle("Options · \(stock.symbol)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }

    private var header: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(stock.companyName)
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("Now \(stock.currentPrice, format: .currency(code: "USD"))")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
            Text("Cash: \((appState.currentUser?.cashBalance ?? 0), format: .currency(code: "USD"))")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding(14)
        .cardSurface(radius: 14)
    }

    private var quoteCard: some View {
        VStack(spacing: 8) {
            row("Premium (per share)", premium.formatted(.currency(code: "USD")))
            row("Total cost", totalCost.formatted(.currency(code: "USD")))
            row("Breakeven at expiry", OptionPricer.breakeven(kind: kind, strike: strike, premium: premium).formatted(.currency(code: "USD")))
            row("Max loss", totalCost.formatted(.currency(code: "USD")))
        }
        .padding()
        .background(AppTheme.secondaryBlue.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private func row(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
            Spacer()
            Text(value)
                .font(AppTheme.captionFont.bold())
                .foregroundColor(AppTheme.textPrimary)
        }
    }

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(AppTheme.textPrimary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .cardSurface(radius: 14)
    }

    private func chip(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(selected ? .white : AppTheme.textSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Capsule().fill(selected ? AppTheme.secondaryBlue : AppTheme.background))
        }
        .buttonStyle(SpringPressStyle())
    }
}
