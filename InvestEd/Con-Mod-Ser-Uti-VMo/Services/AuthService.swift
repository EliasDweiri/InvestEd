import Foundation
import FirebaseAuth

/// Thin wrapper around FirebaseAuth so the rest of the app never talks to
/// Firebase directly — if you ever swap auth providers, this is the only
/// file that needs to change.
final class AuthService {
    static let shared = AuthService()
    private init() {}

    var currentUserID: String? { Auth.auth().currentUser?.uid }

    func signUp(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user.uid
    }

    func signIn(email: String, password: String) async throws -> String {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user.uid
    }

    /// Used by the optional "Sign in with Apple" flow we add in Step 6.
    func signInWithApple(idToken: String, nonce: String, fullName: PersonNameComponents?) async throws -> String {
        let credential = OAuthProvider.appleCredential(withIDToken: idToken, rawNonce: nonce, fullName: fullName)
        let result = try await Auth.auth().signIn(with: credential)
        return result.user.uid
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    var currentUserEmail: String? { Auth.auth().currentUser?.email }

    /// Re-authenticates an email/password user. Firebase requires a recent
    /// login before sensitive actions like deleting the account.
    func reauthenticate(password: String) async throws {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            throw NSError(domain: "InvestEd", code: 401,
                          userInfo: [NSLocalizedDescriptionKey: "You're not signed in."])
        }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await user.reauthenticate(with: credential)
    }

    /// Permanently deletes the signed-in Firebase Auth account. Call
    /// `reauthenticate(password:)` first if Firebase reports it needs a recent
    /// login. Deleting the Firestore user document is handled separately.
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw NSError(domain: "InvestEd", code: 401,
                          userInfo: [NSLocalizedDescriptionKey: "You're not signed in."])
        }
        try await user.delete()
    }

    /// True when the current session signed in with a provider other than
    /// email/password (e.g. Apple) — those don't need a password to re-auth.
    var isPasswordUser: Bool {
        Auth.auth().currentUser?.providerData.contains { $0.providerID == "password" } ?? false
    }
}
