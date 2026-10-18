import Foundation

enum ChatRole: String, Codable {
    case user, assistant
}

struct ChatMessage: Identifiable, Codable, Equatable {
    var id = UUID()
    var role: ChatRole
    var text: String
    var timestamp: Date = Date()
}
