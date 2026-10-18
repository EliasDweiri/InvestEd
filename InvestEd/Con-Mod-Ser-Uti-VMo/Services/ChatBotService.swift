import Foundation

/// Talks to Penny, the in-app AI assistant. This calls YOUR Cloudflare
/// Worker (see backend/worker.js), which in turn calls Gemini — your
/// Gemini key never lives in the app itself, only on the Worker.
///
/// Until you deploy the Worker and paste its URL into Constants.chatWorkerURL,
/// this falls back to a small set of canned, still-genuinely-useful answers
/// so the chat screen is fully testable from day one.
final class ChatBotService {
    static let shared = ChatBotService()
    private init() {}

    func sendMessage(_ history: [ChatMessage]) async throws -> String {
        guard Constants.chatWorkerURL != Constants.placeholder,
              let url = URL(string: Constants.chatWorkerURL) else {
            return ChatBotService.demoResponse(for: history.last?.text ?? "")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let payload: [String: Any] = [
            "messages": history.map { ["role": $0.role.rawValue, "content": $0.text] }
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoded = try JSONDecoder().decode(ChatProxyResponse.self, from: data)
        return decoded.reply
    }

    static func demoResponse(for question: String) -> String {
        let lower = question.lowercased()
        if lower.contains("diversif") {
            return "Diversification means spreading your investments across different assets so one bad performer doesn't sink your whole portfolio — like not putting all your eggs in one basket!"
        } else if lower.contains("stock") {
            return "A stock represents a small ownership stake in a company. When the company does well, your shares can become more valuable!"
        } else if lower.contains("budget") {
            return "A budget is simply a plan for your money — how much comes in, and where it goes. A popular starting point is the 50/30/20 rule: 50% needs, 30% wants, 20% savings."
        }
        return "Great question! Once your Cloudflare Worker is deployed, I'll be able to give you detailed, personalized answers about anything in InvestEd. For now, try exploring the Learn tab for lessons on this topic!"
    }
}

struct ChatProxyResponse: Codable {
    let reply: String
}
