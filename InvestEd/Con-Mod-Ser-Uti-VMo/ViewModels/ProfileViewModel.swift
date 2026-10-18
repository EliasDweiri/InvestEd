import Foundation
import Combine
import SwiftUI

@MainActor
final class ProfileViewModel: ObservableObject {
    private var appState: AppState { AppState.shared }

    var user: AppUser? { appState.currentUser }

    func signOut() {
        try? AuthService.shared.signOut()
        appState.currentUser = nil
    }
}
