import Foundation

/// Offline fallback quotes. Used automatically when the market-data Worker
/// can't be reached, so the simulator keeps working without a connection.
/// (There is no fake *social* data — leagues always show real users.)
enum SampleData {
    static let stocks: [Stock] = [
        Stock(symbol: "AAPL", companyName: "Apple Inc.", currentPrice: 212.34, previousClose: 208.90, priceHistory: priceHistory(base: 208)),
        Stock(symbol: "MSFT", companyName: "Microsoft Corp.", currentPrice: 441.12, previousClose: 438.50, priceHistory: priceHistory(base: 438)),
        Stock(symbol: "GOOGL", companyName: "Alphabet Inc.", currentPrice: 178.02, previousClose: 180.11, priceHistory: priceHistory(base: 180)),
        Stock(symbol: "AMZN", companyName: "Amazon.com Inc.", currentPrice: 198.77, previousClose: 195.30, priceHistory: priceHistory(base: 195)),
        Stock(symbol: "TSLA", companyName: "Tesla Inc.", currentPrice: 256.90, previousClose: 264.10, priceHistory: priceHistory(base: 264)),
        Stock(symbol: "NVDA", companyName: "NVIDIA Corp.", currentPrice: 132.45, previousClose: 128.77, priceHistory: priceHistory(base: 128)),
        Stock(symbol: "META", companyName: "Meta Platforms Inc.", currentPrice: 512.60, previousClose: 508.20, priceHistory: priceHistory(base: 508)),
        Stock(symbol: "NFLX", companyName: "Netflix Inc.", currentPrice: 685.40, previousClose: 690.15, priceHistory: priceHistory(base: 690)),
    ]

    /// Index ETF proxies for the "Market Powerhouses" strip, used until a
    /// Finnhub key is configured (and as a network-failure fallback).
    static let indexes: [Stock] = [
        Stock(symbol: "SPY", companyName: "S&P 500", currentPrice: 662.40, previousClose: 655.10, priceHistory: priceHistory(base: 655)),
        Stock(symbol: "QQQ", companyName: "NASDAQ 100", currentPrice: 598.75, previousClose: 601.20, priceHistory: priceHistory(base: 601)),
        Stock(symbol: "DIA", companyName: "Dow Jones", currentPrice: 471.30, previousClose: 468.90, priceHistory: priceHistory(base: 468)),
        Stock(symbol: "IWM", companyName: "Russell 2000", currentPrice: 243.15, previousClose: 241.60, priceHistory: priceHistory(base: 241)),
    ]

    private static func priceHistory(base: Double) -> [PricePoint] {
        var points: [PricePoint] = []
        var price = base
        for daysAgo in stride(from: 29, through: 0, by: -1) {
            price += Double.random(in: -3...3)
            let date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
            points.append(PricePoint(date: date, price: max(price, 1)))
        }
        return points
    }
}
