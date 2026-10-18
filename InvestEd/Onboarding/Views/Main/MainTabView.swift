import SwiftUI

/// The real home of the app once a user is signed in and placed. Uses a
/// custom tab bar. Each tab draws its own header (see TabScreen), where
/// Penny sits with a quick tip for that screen.
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
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBar(selection: $selection)
                .padding(.bottom, 2)
        }
        .onAppear {
            NotificationService.shared.scheduleDailyStreakReminder()
        }
    }
}
