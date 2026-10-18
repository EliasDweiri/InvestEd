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

// MARK: - InvestEd's design system: "Banknote"
//
// The look is borrowed from real money and financial print, not from
// app templates:
// - Ink colors you'd find on currency and in a newspaper's markets page —
//   forest green, petrol blue, brick, ochre — all flat, never gradients.
// - A warm paper canvas instead of stark white, with hairline rules and
//   borders instead of soft drop shadows.
// - Serif headlines (Apple's New York) for an editorial, finance-page voice,
//   SF for everything you read quickly, and tabular digits for money.
// - The one custom ornament is a guilloche pattern — the fine wavy line-work
//   printed on banknotes — used on screen headers.

enum AppTheme {
    // Ink colors
    static let primaryGreen = Color(hex: "1E7350")   // forest: brand, success, "up"
    static let secondaryBlue = Color(hex: "1F5F7A")  // petrol: info, secondary actions
    static let accentGold = Color(hex: "D49A1E")     // gold: XP, rewards, Gold currency
    static let streakOrange = Color(hex: "D2572B")   // brick-orange: streaks
    static let dangerRed = Color(hex: "BF3B2B")      // brick red: wrong, "down", loss

    // Paper surfaces (flip for dark mode)
    static let background = Color.dynamic(light: "F3EEE4", dark: "121110")
    static let cardBackground = Color.dynamic(light: "FFFCF5", dark: "1D1B17")
    static let sunkenBackground = Color.dynamic(light: "EAE3D6", dark: "26231E")
    static let hairline = Color.dynamic(light: "E2D9C8", dark: "302C25")
    static let textPrimary = Color.dynamic(light: "1F1C17", dark: "F3EEE4")
    static let textSecondary = Color.dynamic(light: "6E665A", dark: "A69E90")

    /// Text and icons placed on a colored header block.
    static let onInk = Color(hex: "FFF8EA")

    // Layout — a small radius hierarchy instead of one big pill radius.
    static let cornerRadius: CGFloat = 14
    static let smallRadius: CGFloat = 10

    // Type — serif display + SF text.
    static let titleFont = Font.system(.largeTitle, design: .serif).weight(.bold)
    static let headingFont = Font.system(.title3, design: .serif).weight(.semibold)
    static let bodyFont = Font.system(.body)
    static let captionFont = Font.system(.caption).weight(.medium)
    /// Small all-caps label used above sections, like a newspaper kicker.
    static let kickerFont = Font.system(size: 11, weight: .bold).width(.expanded)
}

// MARK: - Surfaces

extension View {
    /// The standard card: warm paper, hairline border, no drop shadow.
    func cardSurface(radius: CGFloat = AppTheme.cornerRadius) -> some View {
        self
            .background(AppTheme.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .stroke(AppTheme.hairline, lineWidth: 1)
            )
    }
}

/// A section label in small expanded caps — e.g. "YOUR HOLDINGS".
struct SectionKicker: View {
    let text: String
    var color: Color = AppTheme.textSecondary

    var body: some View {
        Text(text.uppercased())
            .font(AppTheme.kickerFont)
            .tracking(1.2)
            .foregroundColor(color)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
