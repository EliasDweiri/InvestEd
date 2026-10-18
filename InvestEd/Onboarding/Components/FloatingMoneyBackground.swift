import SwiftUI

/// A quiet ambient layer of money symbols that FALL like slow snow: each one
/// drifts from above the top edge all the way past the bottom, sways gently
/// side to side, then wraps around and falls again — forever. Low opacity
/// keeps it subtle, but it's always moving somewhere on screen.
struct FloatingMoneyBackground: View {
    private struct Particle {
        let symbol: String
        let x: CGFloat        // 0...1 across the width
        let size: CGFloat
        let fallDuration: Double   // seconds for one full top-to-bottom trip
        let phase: Double          // staggers particles along their journey
        let swayAmplitude: CGFloat
        let swaySpeed: Double
        let opacity: Double
    }

    private static let particles: [Particle] = [
        Particle(symbol: "dollarsign", x: 0.10, size: 24, fallDuration: 22, phase: 0.00, swayAmplitude: 16, swaySpeed: 0.45, opacity: 0.11),
        Particle(symbol: "banknote", x: 0.26, size: 22, fallDuration: 30, phase: 0.42, swayAmplitude: 12, swaySpeed: 0.32, opacity: 0.09),
        Particle(symbol: "centsign", x: 0.40, size: 18, fallDuration: 26, phase: 0.15, swayAmplitude: 18, swaySpeed: 0.50, opacity: 0.10),
        Particle(symbol: "chart.line.uptrend.xyaxis", x: 0.55, size: 21, fallDuration: 34, phase: 0.68, swayAmplitude: 10, swaySpeed: 0.28, opacity: 0.09),
        Particle(symbol: "dollarsign.circle", x: 0.68, size: 26, fallDuration: 24, phase: 0.30, swayAmplitude: 14, swaySpeed: 0.40, opacity: 0.12),
        Particle(symbol: "dollarsign", x: 0.82, size: 17, fallDuration: 28, phase: 0.80, swayAmplitude: 20, swaySpeed: 0.55, opacity: 0.10),
        Particle(symbol: "centsign", x: 0.93, size: 22, fallDuration: 32, phase: 0.55, swayAmplitude: 12, swaySpeed: 0.35, opacity: 0.11),
        Particle(symbol: "banknote", x: 0.06, size: 19, fallDuration: 27, phase: 0.62, swayAmplitude: 15, swaySpeed: 0.42, opacity: 0.09),
        Particle(symbol: "chart.line.uptrend.xyaxis", x: 0.33, size: 18, fallDuration: 36, phase: 0.90, swayAmplitude: 11, swaySpeed: 0.30, opacity: 0.08),
        Particle(symbol: "dollarsign.circle", x: 0.48, size: 20, fallDuration: 29, phase: 0.05, swayAmplitude: 17, swaySpeed: 0.48, opacity: 0.10)
    ]

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0)) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate
                let margin: CGFloat = 60

                for particle in Self.particles {
                    // 0 → 1 progress through one full fall, offset by phase,
                    // wrapping back to the top forever.
                    let cycle = (now / particle.fallDuration + particle.phase)
                        .truncatingRemainder(dividingBy: 1)
                    let y = -margin + CGFloat(cycle) * (size.height + margin * 2)

                    // Gentle side-to-side sway while falling.
                    let sway = sin(now * particle.swaySpeed + Double(particle.phase) * 10)
                    let x = particle.x * size.width + CGFloat(sway) * particle.swayAmplitude

                    let text = Text(Image(systemName: particle.symbol))
                        .font(.system(size: particle.size, weight: .bold))
                        .foregroundColor(AppTheme.primaryGreen.opacity(particle.opacity))
                    context.draw(text, at: CGPoint(x: x, y: y))
                }
            }
        }
        .allowsHitTesting(false)
        .ignoresSafeArea()
    }
}
