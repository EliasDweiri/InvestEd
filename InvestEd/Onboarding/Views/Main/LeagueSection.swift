import SwiftUI

/// The weekly league: your tier badge and progress up top, then this
/// week's standings. Two boards, both real data from Firestore:
///   • Friends  — you vs. the people you've added
///   • Everyone — the top learners across all of InvestEd this week
/// New users with no friends land on "Everyone", so the board is never empty
/// and never filled with fake players.
struct LeagueSection: View {
    @EnvironmentObject var appState: AppState
    let friends: [FriendProfile]

    enum Scope: String, CaseIterable, Identifiable {
        case friends = "Friends"
        case everyone = "Everyone"
        var id: String { rawValue }
    }

    @State private var rowsShown = false
    @State private var chosenScope: Scope?
    @State private var globalBoard: [FriendProfile] = []
    @State private var isLoadingGlobal = false

    /// Until the user picks, default to Friends if they have any.
    private var scope: Scope { chosenScope ?? (friends.isEmpty ? .everyone : .friends) }

    private var myWeeklyXP: Int { appState.currentUser?.currentWeeklyXP ?? 0 }
    private var tier: LeagueTier { LeagueTier.tier(forWeeklyXP: myWeeklyXP) }

    private struct Entry: Identifiable {
        let id: String
        let username: String
        let avatarEmoji: String
        let weeklyXP: Int
        let isMe: Bool
    }

    private var entries: [Entry] {
        var list: [Entry] = []
        if let me = appState.currentUser {
            list.append(Entry(id: me.id.isEmpty ? "me" : me.id, username: me.username.isEmpty ? "You" : me.username, avatarEmoji: me.avatarEmoji, weeklyXP: myWeeklyXP, isMe: true))
        }
        let myID = appState.currentUser?.id
        let others = (scope == .friends ? friends : globalBoard).filter { $0.id != myID }
        for friend in others {
            list.append(Entry(id: friend.id, username: friend.username, avatarEmoji: friend.avatarEmoji, weeklyXP: friend.weeklyXP ?? 0, isMe: false))
        }
        return list.sorted { $0.weeklyXP > $1.weeklyXP }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            tierCard
            Picker("League", selection: Binding(get: { scope }, set: { chosenScope = $0 })) {
                ForEach(Scope.allCases) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)
            standings
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.85)) {
                rowsShown = true
            }
        }
        .task { await loadGlobalBoard() }
    }

    // MARK: - Tier card

    private var tierCard: some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color(hex: tier.colorHex).opacity(0.18))
                    .frame(width: 56, height: 56)
                Image(systemName: tier.iconName)
                    .font(.system(size: 26))
                    .foregroundColor(Color(hex: tier.colorHex))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(tier.name)
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                if let next = tier.nextTierXP {
                    ProgressBarView(progress: Double(myWeeklyXP - tier.minXP) / Double(next - tier.minXP))
                        .frame(height: 10)
                    Text("\(next - myWeeklyXP) XP to the next league · resets weekly")
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                } else {
                    Text("Top league — defend it! · resets weekly")
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    // MARK: - Standings

    private var standings: some View {
        VStack(spacing: 10) {
            ForEach(Array(entries.enumerated()), id: \.element.id) { rank, entry in
                row(rank: rank, entry: entry)
                    .opacity(rowsShown ? 1 : 0)
                    .offset(y: rowsShown ? 0 : 14)
                    .animation(.spring(response: 0.45, dampingFraction: 0.85).delay(Double(rank) * 0.05), value: rowsShown)
            }
            if scope == .friends && friends.isEmpty {
                Text("Add friends below to start your own league!")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 2)
            } else if scope == .everyone && isLoadingGlobal {
                ProgressView().frame(maxWidth: .infinity)
            } else if scope == .everyone {
                Text("Top learners on InvestEd this week · resets weekly")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 2)
            }
        }
    }

    private func loadGlobalBoard() async {
        isLoadingGlobal = true
        globalBoard = (try? await FirestoreService.shared.fetchWeeklyLeaderboard()) ?? []
        isLoadingGlobal = false
    }

    private func row(rank: Int, entry: Entry) -> some View {
        HStack(spacing: 14) {
            Text("#\(rank + 1)")
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(rankColor(rank))
                .frame(width: 36)
            MascotBubble(avatarKey: entry.avatarEmoji, size: 32)
            Text(entry.isMe ? "\(entry.username) (you)" : entry.username)
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
            Spacer()
            Text("\(entry.weeklyXP) XP")
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(AppTheme.primaryGreen)
                .contentTransition(.numericText())
        }
        .padding(14)
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                .stroke(entry.isMe ? AppTheme.primaryGreen : .clear, lineWidth: 2)
        )
    }

    private func rankColor(_ rank: Int) -> Color {
        switch rank {
        case 0: return AppTheme.accentGold
        case 1: return Color(hex: "9BA7B4")
        case 2: return Color(hex: "CD7F32")
        default: return AppTheme.textSecondary
        }
    }
}
