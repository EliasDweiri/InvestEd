import SwiftUI

/// Penny's snout-as-a-coin — the app icon mark, drawn natively so it can be
/// dropped in as a subtle brand hint. Used sparingly (splash screen, chat
/// thinking indicator) — a wink, not a billboard.
struct SnoutCoinMark: View {
    var size: CGFloat = 64
    var pulsing: Bool = false

    @State private var scaled = false

    private var gold: Color { Color(hex: "FFC93C") }
    private var goldDark: Color { Color(hex: "E0A82E") }
    private var slot: Color { Color(hex: "1B1F3B") }

    var body: some View {
        ZStack {
            Circle().fill(gold)
            Circle()
                .stroke(goldDark, lineWidth: size * 0.062)
                .frame(width: size * 0.75, height: size * 0.75)
            HStack(spacing: size * 0.083) {
                Capsule().fill(slot)
                Capsule().fill(slot)
            }
            .frame(width: size * 0.3, height: size * 0.35)
        }
        .frame(width: size, height: size)
        .scaleEffect(pulsing && scaled ? 1.08 : 1.0)
        .onAppear {
            guard pulsing else { return }
            withAnimation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                scaled = true
            }
        }
    }
}

/// Three softly bouncing dots — shown while Penny is thinking in chat.
struct ThinkingDots: View {
    @State private var animating = false

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(AppTheme.textSecondary)
                    .frame(width: 7, height: 7)
                    .offset(y: animating ? -4 : 2)
                    .animation(
                        .easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.15),
                        value: animating
                    )
            }
        }
        .onAppear { animating = true }
    }
}

/// A gentle press-down spring shared by all tappable cards and buttons.
struct SpringPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.965 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
