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
    @State private var globalError: String?

    /// Until the user picks, default to Friends if they have any.
    private var scope: Scope { chosenScope ?? (friends.isEmpty ? .everyone : .friends) }

    private var myWeeklyXP: Int { appState.currentUser?.currentWeeklyXP ?? 0 }

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
        VStack(alignment: .leading, spacing: 10) {
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

    // MARK: - Standings

    private var standings: some View {
        VStack(spacing: 10) {
            VStack(spacing: 0) {
                ForEach(Array(entries.enumerated()), id: \.element.id) { rank, entry in
                    row(rank: rank, entry: entry)
                        .opacity(rowsShown ? 1 : 0)
                        .offset(y: rowsShown ? 0 : 14)
                        .animation(.spring(response: 0.45, dampingFraction: 0.85).delay(Double(rank) * 0.05), value: rowsShown)
                    if rank < entries.count - 1 {
                        Rectangle().fill(AppTheme.hairline).frame(height: 1).padding(.leading, 14)
                    }
                }
            }
            .cardSurface()
            if scope == .friends && friends.isEmpty {
                Text("Add friends below to start your own league.")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 2)
            } else if scope == .everyone && isLoadingGlobal {
                ProgressView().frame(maxWidth: .infinity)
            } else if scope == .everyone, let globalError {
                Text(globalError)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .frame(maxWidth: .infinity)
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
        do {
            globalBoard = try await FirestoreService.shared.fetchWeeklyLeaderboard()
        } catch {
            print("[League] global board failed: \(error.localizedDescription)")
            globalError = "Couldn't load the global league: \(error.localizedDescription)"
            globalBoard = []
        }
        isLoadingGlobal = false
    }

    private func row(rank: Int, entry: Entry) -> some View {
        HStack(spacing: 14) {
            Text("#\(rank + 1)")
                .font(.system(.body, design: .serif).weight(.bold).monospacedDigit())
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
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        // Your own row is marked with a tinted band, like a highlighted line on a statement.
        .background(entry.isMe ? AppTheme.primaryGreen.opacity(0.08) : .clear)
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

/// The weekly-league badge shown in the Friends header.
struct LeagueTierHero: View {
    @EnvironmentObject var appState: AppState

    private var myWeeklyXP: Int { appState.currentUser?.currentWeeklyXP ?? 0 }
    private var tier: LeagueTier { LeagueTier.tier(forWeeklyXP: myWeeklyXP) }

    var body: some View {
        HStack(spacing: 14) {
            Group {
                if let face = tier.faceValue {
                    Text(face)
                        .font(.system(size: face.count > 2 ? 17 : 20, weight: .bold, design: .serif))
                } else {
                    Image(systemName: tier.iconName)
                        .font(.system(size: 22, weight: .semibold))
                }
            }
            .foregroundColor(AppTheme.onInk)
            .frame(width: 52, height: 52)
            .background(AppTheme.onInk.opacity(0.15), in: Circle())
            .overlay(Circle().stroke(AppTheme.onInk.opacity(0.35), lineWidth: 1.5).padding(4))
            .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline) {
                    Text(tier.name)
                        .font(.system(.title3, design: .serif).weight(.bold))
                    Spacer()
                    Text("\(myWeeklyXP) XP this week")
                        .font(.caption.weight(.semibold).monospacedDigit())
                        .opacity(0.8)
                }
                if let next = tier.nextTierXP {
                    HeaderProgressBar(progress: Double(myWeeklyXP - tier.minXP) / Double(max(next - tier.minXP, 1)))
                    Text("\(next - myWeeklyXP) XP to the next league · resets weekly")
                        .font(.caption)
                        .opacity(0.8)
                } else {
                    Text("Top league · resets weekly")
                        .font(.caption)
                        .opacity(0.8)
                }
            }
            .foregroundColor(AppTheme.onInk)
        }
    }
}
