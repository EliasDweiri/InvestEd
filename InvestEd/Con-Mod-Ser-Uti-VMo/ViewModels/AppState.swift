import Foundation
import Combine
import SwiftUI

/// App-wide state shared across every screen: essentially "who's signed in
/// right now." Kept as a simple shared singleton so any ViewModel can
/// read/update it directly without threading dependency injection through
/// every initializer — a deliberate simplicity trade-off for a project
/// this size.
final class AppState: ObservableObject {
    static let shared = AppState()
    private init() {}

    @Published var currentUser: AppUser?
}
