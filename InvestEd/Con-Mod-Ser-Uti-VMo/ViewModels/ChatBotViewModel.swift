import Foundation
import Combine
import SwiftUI

@MainActor
final class ChatBotViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [
        ChatMessage(role: .assistant, text: "Hi, I'm Penny — your InvestEd assistant! Ask me anything about budgeting, investing, or how the app works.")
    ]
    @Published var draft = ""
    @Published var isSending = false

    /// A short description of the screen the user opened the chat from.
    /// It's attached invisibly to their message so Penny can answer
    /// questions about exactly what they're looking at.
    var screenContext: String?

    func send() async {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        messages.append(ChatMessage(role: .user, text: text))
        draft = ""
        isSending = true

        // Outbound copy only — the visible transcript stays clean.
        var outbound = messages
        if let context = screenContext,
           let lastIndex = outbound.indices.last, outbound[lastIndex].role == .user {
            outbound[lastIndex].text = "[App context, not typed by the user: \(context)]\n\n\(outbound[lastIndex].text)"
        }

        do {
            let reply = try await ChatBotService.shared.sendMessage(outbound)
            messages.append(ChatMessage(role: .assistant, text: reply))
        } catch {
            messages.append(ChatMessage(role: .assistant, text: "Sorry, I had trouble responding. Please try again."))
        }
        isSending = false
    }
}
