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
        case .learn: return Color(hex: "1E6B4F")    // forest
        case .market: return Color(hex: "1F5F7A")   // petrol
        case .shop: return Color(hex: "A86F14")     // ochre
        case .friends: return Color(hex: "B04530")  // brick
        case .profile: return Color(hex: "33403F")  // slate
        }
    }
}

/// A floating tab bar: each tab has its own ink color, and the selected
/// icon sits in a solid disc of that color.
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
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(AppTheme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(AppTheme.hairline, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
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
                            .fill(tab.color)
                            .frame(width: 44, height: 44)
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
                    .font(.system(size: 10.5, weight: .semibold))
                    .foregroundColor(isSelected ? tab.color : AppTheme.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(SpringPressStyle())
    }
}
