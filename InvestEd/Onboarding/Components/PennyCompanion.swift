import SwiftUI

/// Penny lives in the top-right corner of every tab's header. She offers a
/// short tip about the screen you just landed on (the bubble auto-hides
/// after a few seconds); tap her for another. Tips are hand-written.
struct PennyCompanion: View {
    let tab: MainTab

    @State private var tipText: String?
    @State private var tipTask: Task<Void, Never>?

    var body: some View {
        Button {
            showNextTip()
        } label: {
            Image(Mascots.pig.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 34)
                .frame(width: 40, height: 40)
                .background(AppTheme.onInk.opacity(0.15), in: Circle())
        }
        .buttonStyle(SpringPressStyle())
        .accessibilityLabel("Penny")
        .accessibilityHint("Shows a tip about this screen")
        // The tip drops down from Penny, over the content, without moving
        // anything else on screen.
        .overlay(alignment: .topTrailing) {
            if let tipText {
                tipBubble(tipText)
                    .offset(y: 50)
                    .transition(.scale(scale: 0.9, anchor: .topTrailing).combined(with: .opacity))
            }
        }
        .onAppear { scheduleTip(for: tab) }
        .onChange(of: tab) { scheduleTip(for: tab) }
        .onDisappear { tipTask?.cancel() }
    }

    private func tipBubble(_ text: String) -> some View {
        Button {
            dismissTip()
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("PENNY'S TIP")
                        .font(AppTheme.kickerFont)
                        .tracking(1)
                        .foregroundColor(AppTheme.primaryGreen)
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(AppTheme.textSecondary)
                }
                Text(text)
                    .font(.footnote)
                    .foregroundColor(AppTheme.textPrimary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(12)
            .frame(width: 250, alignment: .leading)
            .cardSurface(radius: 12)
            .shadow(color: .black.opacity(0.12), radius: 10, y: 4)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Tip scheduling

    /// Tabs Penny has already greeted this launch — she offers one tip per
    /// tab automatically, then only when tapped, so she never keeps
    /// covering the header.
    private static var greetedTabs: Set<MainTab> = []

    private func scheduleTip(for tab: MainTab) {
        tipTask?.cancel()
        guard !Self.greetedTabs.contains(tab) else { return }
        Self.greetedTabs.insert(tab)
        tipTask = Task {
            try? await Task.sleep(nanoseconds: 900_000_000) // let the tab settle
            guard !Task.isCancelled else { return }
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                tipText = Self.tips(for: tab).randomElement()
            }
            try? await Task.sleep(nanoseconds: 9_000_000_000) // auto-hide
            guard !Task.isCancelled else { return }
            withAnimation(.easeOut(duration: 0.25)) { tipText = nil }
        }
    }

    /// Tap Penny: show a different tip right away, then auto-hide.
    private func showNextTip() {
        tipTask?.cancel()
        let options = Self.tips(for: tab).filter { $0 != tipText }
        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
            tipText = options.randomElement() ?? Self.tips(for: tab).first
        }
        tipTask = Task {
            try? await Task.sleep(nanoseconds: 9_000_000_000)
            guard !Task.isCancelled else { return }
            withAnimation(.easeOut(duration: 0.25)) { tipText = nil }
        }
    }

    private func dismissTip() {
        tipTask?.cancel()
        withAnimation(.easeOut(duration: 0.2)) { tipText = nil }
    }

    // MARK: - Tips per tab

    static func tips(for tab: MainTab) -> [String] {
        switch tab {
        case .learn:
            return [
                "A lesson a day keeps your streak alive — and streaks earn the most Gold over time.",
                "Stuck on a question? Wrong answers cost a heart, but the explanation teaches you either way.",
                "Each unit's animal guide hints at the theme — the bear teaches you not to panic in downturns.",
                "Perfect lessons pay bonus XP and Gold. Slow down and read every choice.",
                "The Quant Corner at the bottom of the path is where the math nerds hang out. Worth the climb."
            ]
        case .market:
            return [
                "The powerhouses up top are indexes — baskets of hundreds of stocks in one number.",
                "Time in the market beats timing the market — steady investing wins.",
                "Red days are normal. The S&P 500 has survived every crash in history so far.",
                "Options are powerful but risky — with a bought option you can lose the whole premium.",
                "Dollar-cost averaging: invest a fixed amount on a schedule and dips work FOR you.",
                "Try the ticker search — you can practice-trade almost any listed stock.",
                "Your practice portfolio uses real market prices — experiment without real risk."
            ]
        case .shop:
            return [
                "Streak Freezes are the best Gold you'll ever spend — they save your streak automatically.",
                "Gold comes from lessons: 10 per lesson, 15 if it's perfect.",
                "Avatar gear you unlock here gets equipped in the Avatar Studio."
            ]
        case .friends:
            return [
                "The weekly league resets every week — XP earned this week decides your rank.",
                "Shared streaks only count days when BOTH of you kept the flame alive.",
                "Add friends with a code from their Profile tab — tap the QR icon."
            ]
        case .profile:
            return [
                "Tap your avatar to restyle it — new characters unlock in the Shop.",
                "Every 100 XP is a level. Perfect lessons are the fastest climb.",
                "Your monthly badge just needs one lesson this month. Easy win."
            ]
        }
    }
}
