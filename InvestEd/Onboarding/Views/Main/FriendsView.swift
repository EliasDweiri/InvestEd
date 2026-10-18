import SwiftUI

/// The Friends tab: incoming requests up top, then your friends ranked by
/// XP (a mini leaderboard), plus username search to add new friends.
struct FriendsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = FriendsViewModel()

    /// Friend streaks: the days you and a friend have BOTH kept your
    /// streaks alive — the shared flame only burns as long as the weaker
    /// of the two.
    private func sharedStreakLabel(with friend: FriendProfile) -> String {
        let shared = min(appState.currentUser?.streak ?? 0, friend.streak)
        return shared > 0 ? " · \(shared) shared" : ""
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                FloatingMoneyBackground()
                ScrollView {
                    VStack(spacing: 20) {
                        LeagueSection(friends: viewModel.friends)
                        searchCard
                        if !viewModel.incomingRequests.isEmpty {
                            requestsSection
                        }
                        friendsSection
                    }
                    .padding()
                    // Extra room so the last friend row clears the tab bar.
                    .padding(.bottom, 110)
                }
            }
            .navigationTitle("Friends")
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
                    Button("Add") { viewModel.sendFriendRequest(to: found) }
                        .font(AppTheme.captionFont)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(AppTheme.secondaryBlue)
                        .clipShape(Capsule())
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
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private var requestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Friend Requests")
                .font(AppTheme.headingFont)
                .foregroundColor(AppTheme.textPrimary)
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
                .background(AppTheme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            }
        }
    }

    private var friendsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Your Friends")
                .font(AppTheme.headingFont)
                .foregroundColor(AppTheme.textPrimary)
            if viewModel.friends.isEmpty {
                VStack(spacing: 8) {
                    Image(Mascots.panda.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 64, height: 64)
                    Text("No friends yet — search a username above to add your first!")
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(AppTheme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
            } else {
                ForEach(Array(viewModel.friends.sorted { $0.xp > $1.xp }.enumerated()), id: \.element.id) { rank, friend in
                    HStack(spacing: 14) {
                        Text("#\(rank + 1)")
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(rank == 0 ? AppTheme.accentGold : AppTheme.textSecondary)
                            .frame(width: 36)
                        MascotBubble(avatarKey: friend.avatarEmoji, size: 34)
                        VStack(alignment: .leading, spacing: 2) {
                            Text(friend.username)
                                .font(AppTheme.bodyFont.bold())
                                .foregroundColor(AppTheme.textPrimary)
                            Text("Level \(friend.level) · \(friend.streak)-day streak\(sharedStreakLabel(with: friend))")
                                .font(AppTheme.captionFont)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        Spacer()
                        Text("\(friend.xp) XP")
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(AppTheme.primaryGreen)
                    }
                    .padding(14)
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
                }
            }
        }
    }
}
