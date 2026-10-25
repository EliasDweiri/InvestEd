import SwiftUI

/// The Friends tab: your league tier in the header, then search, incoming
/// requests, this week's league, and your friends ranked by XP.
struct FriendsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = FriendsViewModel()

    /// Friend streaks: the days you and a friend have BOTH kept your
    /// streaks alive — the shared flame only burns as long as the weaker
    /// of the two.
    private func sharedStreakLabel(with friend: FriendProfile) -> String {
        let shared = min(appState.currentUser?.activeStreak ?? 0, friend.streak)
        return shared > 0 ? " · \(shared) shared" : ""
    }

    var body: some View {
        NavigationStack {
            TabScreen(tab: .friends) {
                PennyCompanion(tab: .friends)
            } hero: {
                LeagueTierHero()
            } content: {
                searchCard
                if !viewModel.incomingRequests.isEmpty {
                    requestsSection
                }
                PaperSection(title: "This week's league") {
                    LeagueSection(friends: viewModel.friends)
                }
                friendsSection
            }
            .onAppear {
                viewModel.loadFriends()
                viewModel.startListening()
            }
            .onDisappear { viewModel.stopListening() }
        }
    }

    private var searchCard: some View {
        VStack(spacing: 12) {
            HStack {
                TextField("Find a friend by username", text: $viewModel.searchUsername)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(14)
                    .background(AppTheme.background)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                Button {
                    Task { await viewModel.searchForUser() }
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(14)
                        .background(AppTheme.primaryGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            if let found = viewModel.searchResult {
                HStack {
                    MascotBubble(avatarKey: found.avatarEmoji, size: 30)
                    Text(found.username)
                        .font(AppTheme.bodyFont.bold())
                        .foregroundColor(AppTheme.textPrimary)
                    Spacer()
                    // Show the relationship instead of a misleading "Add".
                    if appState.currentUser?.friendIDs.contains(found.id) == true {
                        Label("Friends", systemImage: "checkmark")
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.primaryGreen)
                    } else if viewModel.requestedIDs.contains(found.id) {
                        Text("Requested")
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.textSecondary)
                    } else {
                        Button("Add") { viewModel.sendFriendRequest(to: found) }
                            .font(AppTheme.captionFont)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(AppTheme.secondaryBlue)
                            .clipShape(Capsule())
                    }
                }
            }
            Button {
                if let pasted = UIPasteboard.general.string {
                    Task { await viewModel.addFriend(byCode: pasted) }
                } else {
                    viewModel.statusMessage = "Copy a friend code first, then tap this."
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Add with a pasted friend code")
                }
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.secondaryBlue)
            }
            .buttonStyle(SpringPressStyle())

            if let status = viewModel.statusMessage {
                Text(status)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
        .padding()
        .cardSurface()
    }

    private var requestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionKicker(text: "Friend requests")
                .padding(.horizontal, 4)
            ForEach(viewModel.incomingRequests) { request in
                HStack {
                    Text(request.fromUsername)
                        .font(AppTheme.bodyFont.bold())
                        .foregroundColor(AppTheme.textPrimary)
                    Spacer()
                    Button {
                        viewModel.respond(to: request, accept: true)
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(AppTheme.primaryGreen)
                    }
                    Button {
                        viewModel.respond(to: request, accept: false)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(AppTheme.dangerRed)
                    }
                }
                .padding(14)
                .cardSurface()
            }
        }
    }

    private var friendsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionKicker(text: "Your friends")
                .padding(.horizontal, 4)
            if viewModel.friends.isEmpty {
                VStack(spacing: 8) {
                    Image(Mascots.panda.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                    Text("No friends yet. Search a username above to add your first.")
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .cardSurface()
            } else {
                let sorted = viewModel.friends.sorted { $0.xp > $1.xp }
                VStack(spacing: 0) {
                ForEach(Array(sorted.enumerated()), id: \.element.id) { rank, friend in
                    HStack(spacing: 14) {
                        MascotBubble(avatarKey: friend.avatarEmoji, size: 34)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(friend.username)
                                .font(AppTheme.bodyFont.bold())
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Level \(friend.level)" + (friend.streak > 0 ? " · \(friend.streak)-day streak" : "") + sharedStreakLabel(with: friend))
                                .font(AppTheme.captionFont)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        Spacer()
                        Text("\(friend.xp) XP")
                            .font(AppTheme.bodyFont.bold().monospacedDigit())
                            .foregroundColor(AppTheme.primaryGreen)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 11)
                    if rank < sorted.count - 1 {
                        Rectangle().fill(AppTheme.hairline).frame(height: 1).padding(.leading, 14)
                    }
                }
                }
                .cardSurface()
            }
        }
    }
}
