import SwiftUI

/// The real home of the app once a user is signed in and placed. Uses a
/// custom, colorful tab bar, and Penny floats in the bottom-right corner
/// of every tab with a quick tip for that screen.
struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    @State private var selection: MainTab = .learn

    var body: some View {
        ZStack {
            Group {
                switch selection {
                case .learn: LearnView()
                case .market: MarketView()
                case .shop: ShopView()
                case .friends: FriendsView()
                case .profile: ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // Penny sits above the tab bar (the safe-area inset below keeps
        // this overlay clear of it) and out of content's way.
        .overlay(alignment: .bottomTrailing) {
            PennyCompanion(tab: selection)
            .padding(.trailing, 14)
            .padding(.bottom, 8)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBar(selection: $selection)
                .padding(.bottom, 2)
        }
        .onAppear {
            NotificationService.shared.scheduleDailyStreakReminder()
        }
    }
}
