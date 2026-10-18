import SwiftUI

/// The app's five main destinations. (Penny is no longer a tab — she
/// floats in the corner of every screen instead. See PennyCompanion.)
enum MainTab: Int, CaseIterable {
    case learn, market, shop, friends, profile

    var title: String {
        switch self {
        case .learn: return "Learn"
        case .market: return "Market"
        case .shop: return "Shop"
        case .friends: return "Friends"
        case .profile: return "Profile"
        }
    }

    var icon: String {
        switch self {
        case .learn: return "book.fill"
        case .market: return "chart.line.uptrend.xyaxis"
        case .shop: return "bag.fill"
        case .friends: return "person.2.fill"
        case .profile: return "person.crop.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .learn: return AppTheme.primaryGreen
        case .market: return AppTheme.secondaryBlue
        case .shop: return Color(hex: "E0A82E")
        case .friends: return AppTheme.streakOrange
        case .profile: return Color(hex: "9B5DE5")
        }
    }
}

/// A lively replacement for the stock tab bar: each tab gets its own
/// color, the selected icon sits in a floating colored bubble, and
/// switching tabs bounces the bubble with a spring.
struct CustomTabBar: View {
    @Binding var selection: MainTab

    var body: some View {
        HStack {
            ForEach(MainTab.allCases, id: \.rawValue) { tab in
                TabBarButton(tab: tab, isSelected: selection == tab) {
                    guard selection != tab else { return }
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                        selection = tab
                    }
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.top, 8)
        .padding(.bottom, 6)
        .background(
            AppTheme.cardBackground
                .clipShape(RoundedRectangle(cornerRadius: 26))
                .shadow(color: .black.opacity(0.10), radius: 12, y: 4)
        )
        .padding(.horizontal, 14)
    }
}

private struct TabBarButton: View {
    let tab: MainTab
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [tab.color, tab.color.opacity(0.72)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 44, height: 44)
                            .shadow(color: tab.color.opacity(0.45), radius: 6, y: 3)
                            .transition(.scale.combined(with: .opacity))
                    }
                    Image(systemName: tab.icon)
                        .font(.system(size: 19, weight: .bold))
                        .foregroundColor(isSelected ? .white : AppTheme.textSecondary)
                        .scaleEffect(isSelected ? 1.0 : 0.92)
                }
                .frame(width: 46, height: 46)
                .offset(y: isSelected ? -6 : 0)

                Text(tab.title)
                    .font(.system(size: 10.5, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? tab.color : AppTheme.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(SpringPressStyle())
    }
}
