import SwiftUI

/// Toggles between the marketing hero screen and the sign up/login form.
struct WelcomeFlowView: View {
    @State private var showAuth = false

    var body: some View {
        if showAuth {
            AuthView()
        } else {
            WelcomeHeroView(onGetStarted: { showAuth = true })
        }
    }
}

struct WelcomeHeroView: View {
    var onGetStarted: () -> Void
    @State private var heroShown = false

    var body: some View {
        VStack(spacing: 0) {
            // Ink block with the banknote guilloche — the same header used
            // across the app, so the first screen already looks like InvestEd.
            VStack(spacing: 14) {
                Spacer()
                Image(Mascots.pig.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 112, height: 112)
                    .padding(10)
                    .background(AppTheme.onInk.opacity(0.14), in: Circle())
                    .scaleEffect(heroShown ? 1 : 0.8)
                    .opacity(heroShown ? 1 : 0)
                Text("InvestEd")
                    .font(.system(size: 46, weight: .bold, design: .serif))
                    .foregroundColor(AppTheme.onInk)
                Text("Learn money. Practice investing.\nFree, and built for teens.")
                    .font(.body.weight(.medium))
                    .foregroundColor(AppTheme.onInk.opacity(0.85))
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)
            .background(InkHeaderBackground(color: MainTab.learn.color).ignoresSafeArea(edges: .top))

            VStack(spacing: 18) {
                VStack(spacing: 0) {
                    FeatureRow(icon: "book.fill", title: "12 units, 60 short lessons", text: "Budgets, paychecks, credit, investing")
                    divider
                    FeatureRow(icon: "chart.line.uptrend.xyaxis", title: "A real-price market simulator", text: "$10,000 of practice money, zero risk")
                    divider
                    FeatureRow(icon: "person.2.fill", title: "Learn with friends", text: "Streaks and a weekly league")
                }
                .cardSurface()
                .padding(.top, -34)

                PrimaryButton(title: "Get Started", action: onGetStarted)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) { heroShown = true }
        }
    }

    private var divider: some View {
        Rectangle().fill(AppTheme.hairline).frame(height: 1).padding(.leading, 56)
    }
}

private struct FeatureRow: View {
    let icon: String
    let title: String
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(AppTheme.primaryGreen)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(AppTheme.textPrimary)
                Text(text)
                    .font(.footnote)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 13)
    }
}
