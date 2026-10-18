import Foundation

struct Stock: Identifiable, Codable, Equatable, Hashable {
    var id: String { symbol }
    var symbol: String
    var companyName: String
    var currentPrice: Double
    var previousClose: Double
    var priceHistory: [PricePoint]

    var change: Double { currentPrice - previousClose }
    var changePercent: Double { previousClose == 0 ? 0 : (change / previousClose) * 100 }

    /// Finnhub's free tier doesn't include historical candles, so when a
    /// live quote arrives with no history we synthesize a plausible 30-day
    /// trend that ends exactly at the real current price. It's seeded by
    /// the symbol so the shape is stable between refreshes, and it's
    /// labeled as a simulated preview in the UI.
    func withGeneratedHistoryIfNeeded() -> Stock {
        guard priceHistory.isEmpty, currentPrice > 0 else { return self }
        var copy = self

        // Deterministic pseudo-random generator seeded by the symbol.
        var seed: UInt64 = 0xdeadbeef
        for byte in symbol.utf8 { seed = seed &* 31 &+ UInt64(byte) }
        func nextRandom() -> Double {
            seed = seed &* 6364136223846793005 &+ 1442695040888963407
            return Double((seed >> 33) % 10_000) / 10_000 // 0..<1
        }

        // Walk backwards from today's real price.
        var price = currentPrice
        var points: [PricePoint] = [PricePoint(date: Date(), price: price)]
        for daysAgo in 1...29 {
            let drift = (nextRandom() - 0.5) * 0.035 // ±1.75% daily steps
            price = max(price / (1 + drift), 0.01)
            let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
            points.append(PricePoint(date: date, price: price))
        }
        copy.priceHistory = points.reversed()
        return copy
    }
}

struct PricePoint: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var date: Date
    var price: Double
}

/// One row from ticker search: the symbol plus a human-readable name.
struct SymbolMatch: Identifiable, Codable, Equatable {
    var id: String { symbol }
    var symbol: String
    var description: String
}

enum TransactionType: String, Codable {
    case buy, sell
}

struct Transaction: Identifiable, Codable, Equatable {
    var id: String
    var symbol: String
    var type: TransactionType
    var shares: Double
    var pricePerShare: Double
    var date: Date

    var total: Double { shares * pricePerShare }
}

struct Holding: Identifiable, Codable, Equatable {
    var id: String { symbol }
    var symbol: String
    var shares: Double
    var averageCost: Double
}

// MARK: - Options (paper trading, educational)

enum OptionKind: String, Codable, CaseIterable {
    case call, put

    var label: String {
        switch self {
        case .call: return "Call"
        case .put: return "Put"
        }
    }

    /// One-line kid-friendly explanation shown in the Options Playground.
    var explainer: String {
        switch self {
        case .call: return "A call bets the price goes UP. You profit if the stock rises above your strike plus what you paid."
        case .put: return "A put bets the price goes DOWN. You profit if the stock falls below your strike minus what you paid."
        }
    }
}

/// A simulated option position. One contract controls 100 shares —
/// just like the real market. Premiums come from a simplified
/// Black-Scholes model so prices behave realistically without a paid
/// options-data feed.
struct OptionPosition: Identifiable, Codable, Equatable {
    var id: String
    var symbol: String
    var kind: OptionKind
    var strike: Double
    var expiry: Date
    var contracts: Int
    var premiumPaid: Double     // per share, at purchase
    var openDate: Date

    var totalCost: Double { premiumPaid * 100 * Double(contracts) }

    /// e.g. "AAPL $230 Call · Aug 10"
    var displayName: String {
        let date = expiry.formatted(.dateTime.month(.abbreviated).day())
        return "\(symbol) $\(String(format: "%.0f", strike)) \(kind.label) · \(date)"
    }

    var isExpired: Bool { expiry < Date() }
}

/// A small Black-Scholes pricer — enough realism for a simulator, with
/// fixed volatility and rate assumptions so it runs entirely offline.
///
/// Black-Scholes gives the fair price of a European option from five inputs:
///   S = current stock price (live, from Finnhub)   K = strike price
///   t = years until expiry                          r = risk-free rate (4%)
///   sigma = annualized volatility (assumed 30%)
///
///   d1 = [ ln(S/K) + (r + sigma^2 / 2) * t ] / (sigma * sqrt(t))
///   d2 = d1 - sigma * sqrt(t)
///   Call = S * N(d1) - K * e^(-r*t) * N(d2)
///   Put  = K * e^(-r*t) * N(-d2) - S * N(-d1)
///
/// N() is the standard normal CDF, computed from the error function `erf`.
/// Prices are per share; one contract = 100 shares. Verified against
/// put-call parity and known values in `OptionPricerTests`.
enum OptionPricer {
    static let assumedVolatility = 0.30   // 30% annualized — typical large-cap
    static let riskFreeRate = 0.04

    private static func normalCDF(_ x: Double) -> Double {
        0.5 * (1 + erf(x / 2.0.squareRoot()))
    }

    /// Theoretical per-share value of an option.
    static func value(kind: OptionKind, spot: Double, strike: Double, expiry: Date, now: Date = Date()) -> Double {
        let t = max(expiry.timeIntervalSince(now) / (365 * 24 * 3600), 0)
        guard spot > 0, strike > 0 else { return 0 }

        // At/after expiry the option is worth exactly its intrinsic value.
        if t <= 0 {
            return intrinsic(kind: kind, spot: spot, strike: strike)
        }

        let sigma = assumedVolatility
        let r = riskFreeRate
        let d1 = (log(spot / strike) + (r + sigma * sigma / 2) * t) / (sigma * t.squareRoot())
        let d2 = d1 - sigma * t.squareRoot()

        switch kind {
        case .call:
            return spot * normalCDF(d1) - strike * exp(-r * t) * normalCDF(d2)
        case .put:
            return strike * exp(-r * t) * normalCDF(-d2) - spot * normalCDF(-d1)
        }
    }

    static func intrinsic(kind: OptionKind, spot: Double, strike: Double) -> Double {
        switch kind {
        case .call: return max(spot - strike, 0)
        case .put: return max(strike - spot, 0)
        }
    }

    /// Where the stock must be at expiry for the trade to break even.
    static func breakeven(kind: OptionKind, strike: Double, premium: Double) -> Double {
        kind == .call ? strike + premium : strike - premium
    }
}
