import SwiftUI

// MARK: - Hex color support + automatic light/dark variants

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet(charactersIn: "#")))
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }

    /// Builds a Color that automatically swaps between a light-mode hex and
    /// a dark-mode hex depending on the system appearance.
    static func dynamic(light: String, dark: String) -> Color {
        Color(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? UIColor(Color(hex: dark)) : UIColor(Color(hex: light))
        })
    }
}

// MARK: - InvestEd's design system
//
// Palette rationale:
// - Emerald green as the hero color: growth + money, and consistently one
//   of the most positively-received colors across age groups.
// - Indigo-blue for secondary actions: blue is the single most universally
//   liked color and reads as trustworthy/focused — good for a finance app.
// - Gold for XP/rewards: signals achievement and optimism.
// - Coral-orange for streaks: energetic without feeling alarming (unlike red).
// - Backgrounds stay soft and neutral so the accent colors actually pop.

enum AppTheme {
    // Brand colors
    static let primaryGreen = Color(hex: "00C896")
    static let secondaryBlue = Color(hex: "4361EE")
    static let accentGold = Color(hex: "FFC93C")
    static let streakOrange = Color(hex: "FF6B4A")
    static let dangerRed = Color(hex: "EF476F")

    // Adaptive surfaces (automatically flip for light/dark mode)
    static let background = Color.dynamic(light: "F7F9FC", dark: "10141C")
    static let cardBackground = Color.dynamic(light: "FFFFFF", dark: "1C2333")
    static let textPrimary = Color.dynamic(light: "1B1F3B", dark: "F2F4F8")
    static let textSecondary = Color.dynamic(light: "6B7280", dark: "9CA3AF")

    static let primaryGradient = LinearGradient(
        colors: [primaryGreen, secondaryBlue],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    // Layout & type — rounded fonts throughout give the app a friendly,
    // Duolingo-like feel rather than a "serious bank app" feel.
    static let cornerRadius: CGFloat = 20
    static let titleFont = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let headingFont = Font.system(.title2, design: .rounded).weight(.bold)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded).weight(.medium)
}
