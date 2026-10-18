import Foundation
import FirebaseFirestore

/// Thin wrapper around Firestore. Everything operates on one document per
/// user (in "users") plus one document per pending friend request (in
/// "friendRequests"). Uses Firestore's native Codable support
/// (.data(as:) / .setData(from:)) — no extra import needed beyond
/// FirebaseFirestore itself on current SDK versions.
final class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
    private init() {}

    // MARK: - User profile

    func saveUser(_ user: AppUser) throws {
        try db.collection("users").document(user.id).setData(from: user, merge: true)
    }

    func fetchUser(id: String) async throws -> AppUser? {
        let snapshot = try await db.collection("users").document(id).getDocument()
        return try snapshot.data(as: AppUser.self)
    }

    /// Permanently deletes a user's profile document (used by account deletion).
    func deleteUser(id: String) async throws {
        try await db.collection("users").document(id).delete()
    }

    /// True if a username is already taken by a DIFFERENT user (used when
    /// changing your display name so two people don't collide).
    func isUsernameTaken(_ username: String, excluding uid: String) async throws -> Bool {
        let snapshot = try await db.collection("users")
            .whereField("username", isEqualTo: username)
            .limit(to: 1)
            .getDocuments()
        guard let doc = snapshot.documents.first else { return false }
        return doc.documentID != uid
    }

    func findUser(byUsername username: String) async throws -> AppUser? {
        let snapshot = try await db.collection("users")
            .whereField("username", isEqualTo: username)
            .limit(to: 1)
            .getDocuments()
        return try snapshot.documents.first?.data(as: AppUser.self)
    }

    // MARK: - Friend requests

    func sendFriendRequest(_ request: FriendRequest) throws {
        try db.collection("friendRequests").document(request.id).setData(from: request)
    }

    func listenForFriendRequests(userID: String, onChange: @escaping ([FriendRequest]) -> Void) -> ListenerRegistration {
        db.collection("friendRequests")
            .whereField("toUserID", isEqualTo: userID)
            .whereField("status", isEqualTo: FriendRequestStatus.pending.rawValue)
            .addSnapshotListener { snapshot, _ in
                let requests = snapshot?.documents.compactMap { try? $0.data(as: FriendRequest.self) } ?? []
                onChange(requests)
            }
    }

    /// Requests *I sent* that the other person has accepted. Security rules
    /// only let each user write their own document, so the accepter can't add
    /// themselves to the sender's friend list. Instead, the sender's app
    /// watches for its accepted requests and completes its half of the
    /// friendship (see FriendsViewModel.completeAcceptedRequests).
    func listenForAcceptedOutgoingRequests(userID: String, onChange: @escaping ([FriendRequest]) -> Void) -> ListenerRegistration {
        db.collection("friendRequests")
            .whereField("fromUserID", isEqualTo: userID)
            .whereField("status", isEqualTo: FriendRequestStatus.accepted.rawValue)
            .addSnapshotListener { snapshot, _ in
                let requests = snapshot?.documents.compactMap { try? $0.data(as: FriendRequest.self) } ?? []
                onChange(requests)
            }
    }

    /// Removes a request once both sides of the friendship are recorded.
    func deleteFriendRequest(id: String) {
        db.collection("friendRequests").document(id).delete()
    }

    func updateFriendRequestStatus(id: String, status: FriendRequestStatus) throws {
        db.collection("friendRequests").document(id).updateData(["status": status.rawValue])
    }

    /// The global weekly league: the top learners on InvestEd this week by
    /// XP. Only public profile fields (username, avatar, XP, streak) are
    /// surfaced. Ordering by a single field uses Firestore's automatic index,
    /// so no manual index setup is needed. `weeklyXP` is only meaningful for
    /// the CURRENT week, so stale entries from last week are filtered out
    /// client-side via `currentWeeklyXP`.
    func fetchWeeklyLeaderboard(limit: Int = 20) async throws -> [FriendProfile] {
        let snapshot = try await db.collection("users")
            .order(by: "weeklyXP", descending: true)
            .limit(to: limit * 3)
            .getDocuments()
        return snapshot.documents
            .compactMap { try? $0.data(as: AppUser.self) }
            .filter { $0.currentWeeklyXP > 0 }
            .prefix(limit)
            .map { FriendProfile(id: $0.id, username: $0.username, avatarEmoji: $0.avatarEmoji, xp: $0.xp, streak: $0.streak, weeklyXP: $0.currentWeeklyXP) }
    }

    /// Fetches lightweight public profiles for a list of friend IDs.
    /// Chunks into groups of 10 to stay safely under Firestore's "in" query limit.
    func fetchFriendProfiles(ids: [String], completion: @escaping ([FriendProfile]) -> Void) {
        guard !ids.isEmpty else { completion([]); return }

        let chunks = stride(from: 0, to: ids.count, by: 10).map { Array(ids[$0..<min($0 + 10, ids.count)]) }
        var allProfiles: [FriendProfile] = []
        let group = DispatchGroup()

        for chunk in chunks {
            group.enter()
            db.collection("users").whereField(FieldPath.documentID(), in: chunk).getDocuments { snapshot, _ in
                let profiles: [FriendProfile] = snapshot?.documents.compactMap { doc in
                    guard let user = try? doc.data(as: AppUser.self) else { return nil }
                    return FriendProfile(id: user.id, username: user.username, avatarEmoji: user.avatarEmoji, xp: user.xp, streak: user.streak, weeklyXP: user.currentWeeklyXP)
                } ?? []
                allProfiles.append(contentsOf: profiles)
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(allProfiles)
        }
    }
}
