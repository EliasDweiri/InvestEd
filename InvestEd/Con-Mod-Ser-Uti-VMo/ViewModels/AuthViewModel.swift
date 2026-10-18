import Foundation
import Combine
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var isLoading = false

    func signUp(email: String, password: String, username: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let uid = try await AuthService.shared.signUp(email: email, password: password)
            var newUser = AppUser.newUserDefault
            newUser.id = uid
            newUser.email = email
            newUser.username = username.isEmpty ? "Investor\(Int.random(in: 1000...9999))" : username
            try FirestoreService.shared.saveUser(newUser)
            AppState.shared.currentUser = newUser
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = nil
        do {
            let uid = try await AuthService.shared.signIn(email: email, password: password)
            AppState.shared.currentUser = try await FirestoreService.shared.fetchUser(id: uid)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    /// Called after a successful Sign in with Apple flow (wired up in Step 6).
    func signInWithAppleCredential(idToken: String, nonce: String, email: String?, fullName: PersonNameComponents?) async {
        isLoading = true
        errorMessage = nil
        do {
            let uid = try await AuthService.shared.signInWithApple(idToken: idToken, nonce: nonce, fullName: fullName)
            if let existing = try await FirestoreService.shared.fetchUser(id: uid) {
                AppState.shared.currentUser = existing
            } else {
                var newUser = AppUser.newUserDefault
                newUser.id = uid
                newUser.email = email ?? ""
                let formattedName = fullName.flatMap { PersonNameComponentsFormatter().string(from: $0) }
                newUser.username = (formattedName?.isEmpty == false ? formattedName! : "Investor\(Int.random(in: 1000...9999))")
                try FirestoreService.shared.saveUser(newUser)
                AppState.shared.currentUser = newUser
            }
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
