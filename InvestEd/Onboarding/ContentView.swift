import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var isCheckingSession = true
    @AppStorage("didAcceptDisclaimer") private var didAcceptDisclaimer = false

    var body: some View {
        Group {
            if isCheckingSession {
                SplashView()
            } else if appState.currentUser == nil {
                WelcomeFlowView()
            } else if !(appState.currentUser?.hasCompletedPlacement ?? false) {
                PlacementTestFlowView()
            } else {
                MainTabView()
            }
        }
        .animation(.easeInOut, value: appState.currentUser?.hasCompletedPlacement)
        // One-time educational disclaimer before the app is used (App Store /
        // finance-app framing: the portfolio is simulated, not real advice).
        .fullScreenCover(isPresented: Binding(
            get: { !didAcceptDisclaimer && !isCheckingSession },
            set: { _ in }
        )) {
            DisclaimerView { didAcceptDisclaimer = true }
        }
        .task {
            #if DEBUG
            // Local UI verification: `-previewSeed` boots straight into the app
            // as a sample learner, skipping Firebase entirely.
            if ProcessInfo.processInfo.arguments.contains("-previewOptions") {
                appState.currentUser = AppUser.debugOptionsLearner
                isCheckingSession = false
                return
            }
            if ProcessInfo.processInfo.arguments.contains("-previewSeed") {
                appState.currentUser = AppUser.debugLearner
                isCheckingSession = false
                return
            }
            #endif
            // Firebase persists sessions across launches — if someone's
            // already signed in from a previous run, pick their profile
            // back up instead of showing the Welcome screen again.
            if let uid = AuthService.shared.currentUserID {
                appState.currentUser = try? await FirestoreService.shared.fetchUser(id: uid)
            }
            isCheckingSession = false
        }
    }
}

private struct SplashView: View {
    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            SnoutCoinMark(size: 72, pulsing: true)
        }
    }
}

