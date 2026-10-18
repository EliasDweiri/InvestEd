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
        ZStack {
            AppTheme.background.ignoresSafeArea()
            VStack(spacing: 24) {
                Spacer()
                Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .foregroundStyle(AppTheme.primaryGradient)
                    .scaleEffect(heroShown ? 1 : 0.7)
                    .opacity(heroShown ? 1 : 0)
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.65)) {
                            heroShown = true
                        }
                    }

                Text("InvestEd")
                    .font(.system(size: 44, weight: .heavy, design: .rounded))
                    .foregroundColor(AppTheme.textPrimary)

                Text("Learn money. Practice investing. Have fun doing it.")
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Spacer()

                VStack(spacing: 14) {
                    FeatureRow(icon: "flame.fill", text: "Bite-sized daily lessons, quick and engaging")
                    FeatureRow(icon: "chart.bar.fill", text: "Practice with a real, live market simulator")
                    FeatureRow(icon: "person.2.fill", text: "Learn alongside friends")
                }
                .padding(.horizontal, 32)

                Spacer()

                PrimaryButton(title: "Get Started", action: onGetStarted)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 40)
            }
        }
    }
}

private struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.primaryGreen)
                .frame(width: 28)
            Text(text)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textPrimary)
            Spacer()
        }
    }
}
