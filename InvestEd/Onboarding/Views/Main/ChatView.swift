import SwiftUI

/// Penny, the in-app assistant — opened from the floating Penny in any
/// tab's corner. She receives a short description of whatever screen the
/// user was on, so "what am I looking at?" just works. Uses canned answers
/// until the Cloudflare Worker URL is set in Constants.chatWorkerURL.
struct ChatView: View {
    /// What the user was looking at when they opened the chat (sent to
    /// the model, never shown as a message).
    var screenContext: String? = nil
    /// Short human label for the context chip, e.g. "Market tab".
    var contextLabel: String? = nil

    @StateObject private var viewModel = ChatBotViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var inputFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                FloatingMoneyBackground()
                VStack(spacing: 0) {
                    if let contextLabel {
                        HStack(spacing: 6) {
                            Image(systemName: "eye.fill")
                                .font(.system(size: 10, weight: .bold))
                            Text("Penny can see your \(contextLabel)")
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                        }
                        .foregroundColor(AppTheme.secondaryBlue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(AppTheme.secondaryBlue.opacity(0.12)))
                        .padding(.top, 10)
                    }
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.messages) { message in
                                    ChatBubble(message: message)
                                        .id(message.id)
                                }
                                if viewModel.isSending {
                                    HStack(spacing: 10) {
                                        SnoutCoinMark(size: 26)
                                        ThinkingDots()
                                        Spacer()
                                    }
                                    .padding(.horizontal)
                                    .transition(.opacity)
                                }
                            }
                            .padding()
                            .animation(.spring(response: 0.35, dampingFraction: 0.8), value: viewModel.messages.count)
                        }
                        .onChange(of: viewModel.messages.count) {
                            if let last = viewModel.messages.last {
                                withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                            }
                        }
                    }
                    inputBar
                }
            }
            .navigationTitle("Penny")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .onAppear {
                viewModel.screenContext = screenContext
            }
        }
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            TextField("Ask Penny anything…", text: $viewModel.draft, axis: .vertical)
                .lineLimit(1...4)
                .focused($inputFocused)
                .padding(12)
                .background(AppTheme.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            Button {
                inputFocused = false
                Task { await viewModel.send() }
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 34))
                    .foregroundColor(viewModel.draft.isEmpty ? AppTheme.textSecondary : AppTheme.primaryGreen)
            }
            .disabled(viewModel.draft.isEmpty || viewModel.isSending)
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(AppTheme.background)
    }
}

private struct ChatBubble: View {
    let message: ChatMessage

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 50) }
            Text(message.text)
                .font(AppTheme.bodyFont)
                .foregroundColor(isUser ? .white : AppTheme.textPrimary)
                .padding(14)
                .background(isUser ? AnyShapeStyle(AppTheme.primaryGradient) : AnyShapeStyle(AppTheme.cardBackground))
                .clipShape(RoundedRectangle(cornerRadius: 18))
            if !isUser { Spacer(minLength: 50) }
        }
    }
}
