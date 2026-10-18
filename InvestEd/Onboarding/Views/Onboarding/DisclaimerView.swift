import SwiftUI

/// A one-time educational disclaimer. Shown once at first launch (gated by an
/// AppStorage flag in ContentView) and re-openable any time from Settings.
/// Required framing for a finance-education app: everything is simulated and
/// nothing here is investment advice.
struct DisclaimerView: View {
    /// nil when opened read-only from Settings (shows a Close button instead of Accept).
    var onAccept: (() -> Void)?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                Image(Mascots.pig.imageName)
                    .resizable().scaledToFit()
                    .frame(width: 96, height: 96)
                Text("Learn by doing — safely")
                    .font(AppTheme.titleFont)
                    .foregroundColor(AppTheme.textPrimary)
                    .multilineTextAlignment(.center)

                Text(Self.disclaimerText)
                    .font(AppTheme.bodyFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 4)

                Spacer()
                if let onAccept {
                    PrimaryButton(title: "I understand") {
                        onAccept()
                    }
                } else {
                    SecondaryButton(title: "Close") { dismiss() }
                }
            }
            .padding(28)
        }
    }

    static let disclaimerText = """
    InvestEd is educational only. Your portfolio here is 100% simulated, built \
    with fake money, and no real trades ever happen. Nothing in the app, \
    including tips from your AI buddy Penny, is financial or investment advice. \
    We're here to help you learn and practice, not to tell you what to do with \
    real money. Before you invest for real, do your own research and talk with \
    a licensed professional. Now go explore, make mistakes, and have fun learning!
    """
}
