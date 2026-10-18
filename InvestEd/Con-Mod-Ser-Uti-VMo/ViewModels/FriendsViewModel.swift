import Foundation
import Combine
import SwiftUI
import FirebaseFirestore

@MainActor
final class FriendsViewModel: ObservableObject {
    @Published var friends: [FriendProfile] = []
    @Published var incomingRequests: [FriendRequest] = []
    @Published var searchUsername = ""
    @Published var searchResult: AppUser?
    @Published var statusMessage: String?
    /// People I've sent a request to this session, so the search result
    /// shows "Requested" instead of letting me send duplicates.
    @Published var requestedIDs: Set<String> = []

    private var listener: ListenerRegistration?
    private var acceptedListener: ListenerRegistration?
    private var appState: AppState { AppState.shared }
    private var seenRequestIDs: Set<String> = []
    private var hasLoadedOnce = false

    func startListening() {
        guard let userID = appState.currentUser?.id else { return }
        listener = FirestoreService.shared.listenForFriendRequests(userID: userID) { [weak self] requests in
            guard let self else { return }
            // Notify for genuinely new requests (not the initial load).
            if self.hasLoadedOnce {
                for request in requests where !self.seenRequestIDs.contains(request.id) {
                    NotificationService.shared.notifyFriendRequest(from: request.fromUsername)
                }
            }
            self.seenRequestIDs.formUnion(requests.map(\.id))
            self.hasLoadedOnce = true
            self.incomingRequests = requests
        }
        acceptedListener = FirestoreService.shared.listenForAcceptedOutgoingRequests(userID: userID) { [weak self] accepted in
            self?.completeAcceptedRequests(accepted)
        }
    }

    func stopListening() {
        listener?.remove()
        listener = nil
        acceptedListener?.remove()
        acceptedListener = nil
    }

    /// Two-way friendships: when someone accepts MY request, add them to MY
    /// friend list (they've already added me to theirs), then delete the
    /// request so it's only processed once. This also repairs any
    /// friendships accepted before this fix existed.
    private func completeAcceptedRequests(_ accepted: [FriendRequest]) {
        guard !accepted.isEmpty, var me = appState.currentUser else { return }
        var changed = false
        for request in accepted where !me.friendIDs.contains(request.toUserID) {
            me.friendIDs.append(request.toUserID)
            changed = true
        }
        if changed {
            appState.currentUser = me
            try? FirestoreService.shared.saveUser(me)
            loadFriends()
        }
        for request in accepted {
            FirestoreService.shared.deleteFriendRequest(id: request.id)
        }
    }

    func loadFriends() {
        guard let ids = appState.currentUser?.friendIDs, !ids.isEmpty else {
            friends = []
            return
        }
        FirestoreService.shared.fetchFriendProfiles(ids: ids) { [weak self] profiles in
            self?.friends = profiles
        }
    }

    func searchForUser() async {
        statusMessage = nil
        searchResult = try? await FirestoreService.shared.findUser(byUsername: searchUsername)
        if searchResult == nil {
            statusMessage = "No user found with that username."
        }
    }

    /// Adds a friend from a pasted or scanned friend code (the raw user ID,
    /// or the full "invested:add:<id>" QR payload).
    func addFriend(byCode code: String) async {
        statusMessage = nil
        let cleaned = code
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "invested:add:", with: "")
        guard !cleaned.isEmpty else { return }
        guard cleaned != appState.currentUser?.id else {
            statusMessage = "That's your own code! Share it with a friend instead."
            return
        }
        if let user = try? await FirestoreService.shared.fetchUser(id: cleaned) {
            sendFriendRequest(to: user)
        } else {
            statusMessage = "No user found for that code — double-check it."
        }
    }

    func sendFriendRequest(to user: AppUser) {
        guard let me = appState.currentUser else { return }
        guard !me.friendIDs.contains(user.id) else {
            statusMessage = "You and \(user.username) are already friends!"
            return
        }
        guard user.id != me.id else {
            statusMessage = "That's you! Share your code with a friend instead."
            return
        }
        let request = FriendRequest(id: UUID().uuidString, fromUserID: me.id, fromUsername: me.username, toUserID: user.id, status: .pending, dateSent: Date())
        try? FirestoreService.shared.sendFriendRequest(request)
        requestedIDs.insert(user.id)
        statusMessage = "Friend request sent to \(user.username)!"
    }

    func respond(to request: FriendRequest, accept: Bool) {
        try? FirestoreService.shared.updateFriendRequestStatus(id: request.id, status: accept ? .accepted : .declined)
        if accept, var me = appState.currentUser, !me.friendIDs.contains(request.fromUserID) {
            me.friendIDs.append(request.fromUserID)
            appState.currentUser = me
            try? FirestoreService.shared.saveUser(me)
            loadFriends()
        }
        incomingRequests.removeAll { $0.id == request.id }
    }
}
