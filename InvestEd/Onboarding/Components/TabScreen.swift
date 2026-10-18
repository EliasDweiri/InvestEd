import SwiftUI

// MARK: - Main-tab screen layout
//
// Every main tab uses the same frame: a solid ink-colored header block that
// holds the screen's title and its most important numbers, printed with a
// faint banknote guilloche, and the content cards sitting on warm paper
// below it, overlapping the header's bottom edge. One layout, five colors —
// so no screen is a blank white page and the app reads as one system.

extension MainTab {
    /// One-line description under each tab's title.
    var tagline: String {
        switch self {
        case .learn: return "Money skills, one lesson at a time"
        case .market: return "$10,000 of practice money, real prices"
        case .shop: return "Spend the Gold you earn"
        case .friends: return "Learn together, compete weekly"
        case .profile: return "Your progress so far"
        }
    }
}

struct TabScreen<Accessory: View, Hero: View, Content: View>: View {
    let tab: MainTab
    var title: String? = nil
    /// How far the first content card tucks up into the header.
    var overlap: CGFloat = 26
    @ViewBuilder var accessory: () -> Accessory
    @ViewBuilder var hero: () -> Hero
    @ViewBuilder var content: () -> Content

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                header
                VStack(spacing: 18) {
                    content()
                }
                .padding(.horizontal, 16)
                .padding(.top, -overlap)
                .padding(.bottom, 28)
            }
        }
        .scrollIndicators(.hidden)
        .background(AppTheme.background.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(title ?? tab.title)
                        .font(.system(size: 34, weight: .bold, design: .serif))
                        .foregroundColor(AppTheme.onInk)
                    Text(tab.tagline)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(AppTheme.onInk.opacity(0.78))
                }
                Spacer(minLength: 8)
                accessory()
            }
            hero()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
        .padding(.bottom, overlap + 22)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(alignment: .bottom) {
            InkHeaderBackground(color: tab.color)
                // Extend upward behind the status bar and pull-to-refresh bounce.
                .padding(.top, -600)
        }
    }
}

/// Solid ink block + guilloche line-work, like the border of a banknote.
struct InkHeaderBackground: View {
    let color: Color

    var body: some View {
        ZStack {
            color
            GuillochePattern()
                .stroke(AppTheme.onInk.opacity(0.10), lineWidth: 0.7)
        }
        .clipped()
    }
}

/// Interlaced sine waves drawn edge to edge — the security-print pattern
/// found on currency. Drawn in code so it stays crisp at any size.
struct GuillochePattern: Shape {
    var lines = 16
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let step: CGFloat = 3
        // Anchor the pattern to the bottom of the header (where it's visible).
        let band = min(rect.height, 260)
        let top = rect.maxY - band
        for i in 0..<lines {
            let t = CGFloat(i) / CGFloat(lines)
            let baseY = top + band * (0.12 + 0.76 * t)
            let phase = CGFloat(i) * 0.42
            var x: CGFloat = rect.minX
            path.move(to: CGPoint(x: x, y: baseY + wave(x, rect.width, phase)))
            while x <= rect.maxX {
                x += step
                path.addLine(to: CGPoint(x: x, y: baseY + wave(x, rect.width, phase)))
            }
        }
        return path
    }

    private func wave(_ x: CGFloat, _ width: CGFloat, _ phase: CGFloat) -> CGFloat {
        let u = x / max(width, 1) * .pi * 2
        return 14 * sin(u * 1.5 + phase) + 6 * sin(u * 4 - phase * 1.7)
    }
}

/// A compact stat shown inside a header: icon + value on a faint tint.
struct HeaderStat: View {
    let icon: String
    let value: String
    var label: String? = nil

    var body: some View {
        HStack(spacing: 6) {
            if icon == "goldcoin" {
                GoldCoinIcon(size: 15)
            } else {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
            }
            VStack(alignment: .leading, spacing: 0) {
                Text(value)
                    .font(.system(.subheadline).weight(.bold).monospacedDigit())
                    .contentTransition(.numericText())
                if let label {
                    Text(label)
                        .font(.system(size: 10, weight: .medium))
                        .opacity(0.75)
                }
            }
        }
        .foregroundColor(AppTheme.onInk)
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.onInk.opacity(0.13), in: RoundedRectangle(cornerRadius: AppTheme.smallRadius, style: .continuous))
        .accessibilityElement(children: .combine)
    }
}

/// A round icon button for header actions (settings, QR code, ...).
struct HeaderIconButton: View {
    let systemName: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(AppTheme.onInk)
                .frame(width: 40, height: 40)
                .background(AppTheme.onInk.opacity(0.15), in: Circle())
        }
        .buttonStyle(SpringPressStyle())
        .accessibilityLabel(label)
    }
}

/// Thin progress bar for use on a colored header.
struct HeaderProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(AppTheme.onInk.opacity(0.18))
                Capsule().fill(AppTheme.onInk)
                    .frame(width: geo.size.width * min(max(progress, 0), 1))
            }
        }
        .frame(height: 6)
    }
}

/// Rows grouped into one card with hairline dividers — like a statement or
/// a markets table — instead of a stack of separate floating cards.
struct ListCard<Data: RandomAccessCollection, Row: View>: View where Data.Element: Identifiable {
    let data: Data
    @ViewBuilder let row: (Data.Element) -> Row

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(data.enumerated()), id: \.element.id) { index, element in
                row(element)
                    .contentShape(Rectangle())
                if index < data.count - 1 {
                    Rectangle()
                        .fill(AppTheme.hairline)
                        .frame(height: 1)
                        .padding(.leading, 14)
                }
            }
        }
        .cardSurface()
    }
}

/// Section label + content, with consistent spacing.
struct PaperSection<Content: View, Trailing: View>: View {
    let title: String
    @ViewBuilder var trailing: () -> Trailing
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                SectionKicker(text: title)
                trailing()
            }
            .padding(.horizontal, 4)
            content()
        }
    }
}

extension PaperSection where Trailing == EmptyView {
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.trailing = { EmptyView() }
        self.content = content
    }
}
