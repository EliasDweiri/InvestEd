import SwiftUI

/// The Gold coin, drawn natively so it stays crisp at any size. Used for the
/// in-app currency and the launch screen.
struct SnoutCoinMark: View {
    var size: CGFloat = 64
    var pulsing: Bool = false

    @State private var scaled = false

    private var gold: Color { Color(hex: "E2AA30") }
    private var goldDark: Color { Color(hex: "BE8A1E") }

    var body: some View {
        ZStack {
            Circle().fill(gold)
            Circle()
                .stroke(goldDark, lineWidth: size * 0.062)
                .frame(width: size * 0.75, height: size * 0.75)
            // An embossed "G" for Gold. (Two vertical slots read as a
            // pause button at small sizes.)
            Text("G")
                .font(.system(size: size * 0.46, weight: .heavy, design: .serif))
                .foregroundColor(goldDark)
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
