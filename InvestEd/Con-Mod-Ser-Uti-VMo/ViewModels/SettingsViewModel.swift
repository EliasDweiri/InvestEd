import Foundation
import Combine
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var usernameDraft = ""
    @Published var message: String?
    @Published var isWorking = false

    private var appState: AppState { AppState.shared }

    var email: String { appState.currentUser?.email ?? AuthService.shared.currentUserEmail ?? "—" }
    var needsPasswordToDelete: Bool { AuthService.shared.isPasswordUser }

    func loadDraft() {
        usernameDraft = appState.currentUser?.username ?? ""
    }

    func saveUsername() async {
        guard var user = appState.currentUser else { return }
        let name = usernameDraft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard name.count >= 2 else { message = "Pick a username with at least 2 characters."; return }
        guard name != user.username else { message = "That's already your username."; return }
        isWorking = true; message = nil
        do {
            if try await FirestoreService.shared.isUsernameTaken(name, excluding: user.id) {
                message = "That username is taken. Try another."
            } else {
                user.username = name
                appState.currentUser = user
                try FirestoreService.shared.saveUser(user)
                message = "Username updated."
            }
        } catch {
            message = "Couldn't update username: \(error.localizedDescription)"
        }
        isWorking = false
    }

    func signOut() {
        try? AuthService.shared.signOut()
        appState.currentUser = nil
    }

    /// Deletes the Firestore profile AND the Firebase Auth account. Requires a
    /// recent login, so email/password users re-authenticate with `password`.
    /// Returns true on success (the caller can dismiss).
    @discardableResult
    func deleteAccount(password: String) async -> Bool {
        guard let user = appState.currentUser else { return false }
        isWorking = true; message = nil
        defer { isWorking = false }
        do {
            if AuthService.shared.isPasswordUser {
                guard !password.isEmpty else { message = "Enter your password to confirm."; return false }
                try await AuthService.shared.reauthenticate(password: password)
            }
            try await FirestoreService.shared.deleteUser(id: user.id)
            try await AuthService.shared.deleteAccount()
            appState.currentUser = nil        // routes back to the Welcome flow
            return true
        } catch {
            message = "Couldn't delete account: \(error.localizedDescription)"
            return false
        }
    }
}
