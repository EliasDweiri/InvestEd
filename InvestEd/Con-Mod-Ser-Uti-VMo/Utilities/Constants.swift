import Foundation

enum Constants {
    // MARK: - Replace these with your own values as we reach each step
    static let placeholder = "REPLACE_ME"

    /// The deployed Cloudflare Worker that proxies live market data
    /// (GET /market/...), so the Finnhub key never lives inside the app
    /// binary — it's a Worker secret. See backend/worker.js.
    static let workerURL = "https://invested-chat.elias-dweiri.workers.dev"

    // MARK: - Gameplay tuning
    static let startingCashBalance: Double = 10_000
    static let heartsPerLesson = 5
    static let xpPerLesson = 20
    static let xpPerPerfectLessonBonus = 10

    // MARK: - Market watchlist shown on the Market tab (the default starter set;
    // users can now add/remove their own on the Market tab).
    static let watchlistSymbols = ["AAPL", "MSFT", "GOOGL", "AMZN", "TSLA", "NVDA", "META", "NFLX"]

    // MARK: - Legal / support (host these before App Store submission)
    static let privacyPolicyURL = "https://invested.app/privacy"
    static let termsOfServiceURL = "https://invested.app/terms"
    static let supportEmail = "support@invested.app"

    static var appVersion: String {
        let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let b = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "v\(v) (\(b))"
    }
}
