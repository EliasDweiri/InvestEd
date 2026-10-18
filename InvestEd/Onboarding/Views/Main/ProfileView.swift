import SwiftUI

/// The Profile tab: your custom avatar (tap to restyle), stats, the
/// monthly badge, achievements, your personal QR friend code, recent
/// trades, and sign out.
struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ProfileViewModel()

    @State private var showAvatarBuilder = false
    @State private var showQRCode = false
    @State private var showSettings = false

    private var avatarConfig: AvatarConfig {
        appState.currentUser?.avatar ?? AvatarConfig(baseEmoji: appState.currentUser?.avatarEmoji ?? "pig")
    }

    var body: some View {
        NavigationStack {
            TabScreen(tab: .profile) {
                HStack(spacing: 8) {
                    HeaderIconButton(systemName: "qrcode", label: "My friend code") { showQRCode = true }
                    HeaderIconButton(systemName: "gearshape.fill", label: "Settings") { showSettings = true }
                    PennyCompanion(tab: .profile)
                }
            } hero: {
                profileHero
            } content: {
                statsGrid
                monthlyBadge
                achievementsSection
                if !(appState.currentUser?.transactions.isEmpty ?? true) {
                    transactionsSection
                }
                SecondaryButton(title: "Sign Out") {
                    viewModel.signOut()
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showAvatarBuilder) {
                AvatarBuilderView()
            }
            .sheet(isPresented: $showQRCode) {
                friendCodeSheet
                    .presentationDetents([.medium])
            }
        }
    }

    // MARK: - Header

    private var profileHero: some View {
        HStack(spacing: 16) {
            Button {
                showAvatarBuilder = true
            } label: {
                ZStack(alignment: .bottomTrailing) {
                    AvatarView(config: avatarConfig, size: 84)
                        .overlay(Circle().stroke(AppTheme.onInk.opacity(0.5), lineWidth: 2))
                    Image(systemName: "paintbrush.fill")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.white)
                        .padding(6)
                        .background(Circle().fill(AppTheme.primaryGreen))
                        .overlay(Circle().stroke(AppTheme.onInk, lineWidth: 2))
                }
            }
            .buttonStyle(SpringPressStyle())
            .accessibilityLabel("Edit avatar")

            VStack(alignment: .leading, spacing: 4) {
                Text(appState.currentUser?.username ?? "Investor")
                    .font(.system(.title2, design: .serif).weight(.bold))
                    .lineLimit(1)
                if let joined = appState.currentUser?.joinDate {
                    Text("Investing since \(joined.formatted(date: .abbreviated, time: .omitted))")
                        .font(.footnote)
                        .opacity(0.8)
                }
                Text("Level \(appState.currentUser?.level ?? 1) · \(appState.currentUser?.xp ?? 0) XP")
                    .font(.caption.weight(.semibold).monospacedDigit())
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(AppTheme.onInk.opacity(0.15), in: RoundedRectangle(cornerRadius: 6))
            }
            .foregroundColor(AppTheme.onInk)
            Spacer()
        }
    }

    // MARK: - Stats

    private var statsGrid: some View {
        // One "statement" card with six figures, instead of six big tiles.
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 0) {
            ProfileStat(icon: "star.fill", title: "Total XP", value: "\(appState.currentUser?.xp ?? 0)", color: AppTheme.accentGold)
            ProfileStat(icon: "rosette", title: "Level", value: "\(appState.currentUser?.level ?? 1)", color: AppTheme.secondaryBlue)
            ProfileStat(icon: "flame.fill", title: "Day Streak", value: "\(appState.currentUser?.activeStreak ?? 0)", color: AppTheme.streakOrange)
            ProfileStat(icon: "checkmark.seal.fill", title: "Lessons Done", value: "\(appState.currentUser?.completedLessonIDs.count ?? 0)", color: AppTheme.primaryGreen)
            ProfileStat(icon: "goldcoin", title: "Gold", value: "\(appState.currentUser?.goldBalance ?? 0)", color: AppTheme.accentGold)
            ProfileStat(icon: "snowflake", title: "Streak Freezes", value: "\(appState.currentUser?.streakFreezes ?? 0)", color: AppTheme.secondaryBlue)
        }
        .padding(.vertical, 6)
        .cardSurface()
    }

    // MARK: - Monthly badge

    private var monthlyBadge: some View {
        let earned = appState.currentUser.map(Achievement.monthlyBadgeEarned) ?? false
        return HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(earned ? AppTheme.accentGold.opacity(0.2) : AppTheme.textSecondary.opacity(0.12))
                    .frame(width: 54, height: 54)
                Image(systemName: earned ? "seal.fill" : "seal")
                    .font(.system(size: 26))
                    .foregroundColor(earned ? AppTheme.accentGold : AppTheme.textSecondary)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("\(Achievement.currentMonthName) Badge")
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text(earned ? "Earned — you learned this month!" : "Complete a lesson this month to earn it")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
        }
        .padding()
        .cardSurface()
    }

    // MARK: - Achievements

    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionKicker(text: "Achievements")
                .padding(.horizontal, 4)
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(Achievement.all) { achievement in
                    AchievementCell(
                        achievement: achievement,
                        unlocked: appState.currentUser.map(achievement.isUnlocked) ?? false
                    )
                }
            }
        }
    }

    // MARK: - Friend code sheet

    private var friendCodeSheet: some View {
        VStack(spacing: 16) {
            Text("Your Friend Code")
                .font(AppTheme.headingFont)
                .foregroundColor(AppTheme.textPrimary)
                .padding(.top, 24)
            Text("Friends can scan this, or paste your code in their Friends tab.")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            QRCodeView(text: "invested:add:\(appState.currentUser?.id ?? "")", size: 190)

            Button {
                UIPasteboard.general.string = appState.currentUser?.id
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "doc.on.doc.fill")
                    Text("Copy code")
                }
                .font(AppTheme.captionFont)
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(AppTheme.secondaryBlue)
                .clipShape(Capsule())
            }
            .buttonStyle(SpringPressStyle())
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(AppTheme.background)
    }

    // MARK: - Transactions

    private var transactionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionKicker(text: "Recent trades")
                .padding(.horizontal, 4)
            ForEach((appState.currentUser?.transactions ?? []).prefix(10)) { tx in
                HStack {
                    Image(systemName: tx.type == .buy ? "arrow.down.circle.fill" : "arrow.up.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(tx.type == .buy ? AppTheme.primaryGreen : AppTheme.secondaryBlue)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(tx.type == .buy ? "Bought" : "Sold") \(tx.symbol)")
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        Text(tx.date.formatted(date: .abbreviated, time: .shortened))
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(tx.total, format: .currency(code: "USD"))
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        Text("\(tx.shares, specifier: "%.2f") @ \(tx.pricePerShare, format: .currency(code: "USD"))")
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.textSecondary)
                    }
                }
                .padding(14)
                .cardSurface()
            }
        }
    }
}

// MARK: - Cells

private struct AchievementCell: View {
    let achievement: Achievement
    let unlocked: Bool

    var body: some View {
        VStack(spacing: 7) {
            ZStack {
                Circle()
                    .fill(unlocked ? Color(hex: achievement.colorHex).opacity(0.18) : AppTheme.textSecondary.opacity(0.1))
                    .frame(width: 48, height: 48)
                Image(systemName: unlocked ? achievement.icon : "lock.fill")
                    .font(.system(size: 19, weight: .bold))
                    .foregroundColor(unlocked ? Color(hex: achievement.colorHex) : AppTheme.textSecondary.opacity(0.6))
            }
            Text(achievement.title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(unlocked ? AppTheme.textPrimary : AppTheme.textSecondary)
                .lineLimit(1)
            Text(achievement.caption)
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .cardSurface(radius: 16)
        .opacity(unlocked ? 1 : 0.75)
    }
}

private struct ProfileStat: View {
    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 5) {
                if icon == "goldcoin" {
                    GoldCoinIcon(size: 15)
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(color)
                }
                Text(value)
                    .font(.system(.title3, design: .serif).weight(.bold).monospacedDigit())
                    .foregroundColor(AppTheme.textPrimary)
                    .contentTransition(.numericText())
            }
            Text(title)
                .font(.caption2.weight(.medium))
                .foregroundColor(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}
