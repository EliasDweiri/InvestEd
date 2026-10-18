import SwiftUI

/// Penny, everywhere: a small floating face in the bottom-right corner of
/// every tab. She quietly offers a tip when you land on a tab (the bubble
/// auto-hides after a few seconds), and tapping her — or the bubble —
/// opens the full chat, pre-loaded with what's currently on screen so you
/// can ask about exactly what you're looking at. Collapsed, she's a 48pt
/// circle that never blocks content or the tab bar.
struct PennyCompanion: View {
    let tab: MainTab
    let onOpenChat: () -> Void

    @State private var tipText: String?
    @State private var tipTask: Task<Void, Never>?

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            if let tipText {
                Button {
                    dismissTip()
                    onOpenChat()
                } label: {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("Penny")
                                .font(AppTheme.captionFont.bold())
                                .foregroundColor(AppTheme.primaryGreen)
                            Spacer()
                            Button {
                                dismissTip()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 11, weight: .bold))
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                        }
                        Text(tipText)
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.textPrimary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Tap to ask me about this screen")
                            .font(.system(size: 10, weight: .semibold, design: .rounded))
                            .foregroundColor(AppTheme.secondaryBlue)
                    }
                    .padding(12)
                    .frame(maxWidth: 240, alignment: .leading)
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.15), radius: 10, y: 4)
                }
                .buttonStyle(SpringPressStyle())
                .transition(.scale(scale: 0.85, anchor: .bottomTrailing).combined(with: .opacity))
            }

            Button {
                dismissTip()
                onOpenChat()
            } label: {
                ZStack(alignment: .topTrailing) {
                    Image(Mascots.pig.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .shadow(color: .black.opacity(0.18), radius: 6, y: 3)
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Circle().fill(AppTheme.primaryGreen))
                        .offset(x: 3, y: -3)
                }
            }
            .buttonStyle(SpringPressStyle())
            .accessibilityLabel("Ask Penny")
        }
        .onAppear { scheduleTip(for: tab) }
        .onChange(of: tab) { scheduleTip(for: tab) }
        .onDisappear { tipTask?.cancel() }
    }

    // MARK: - Tip scheduling

    private func scheduleTip(for tab: MainTab) {
        tipTask?.cancel()
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
                "The weekly league resets every Monday — XP earned this week decides your rank.",
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

/// Builds a short description of what the user is currently looking at,
/// sent along with their chat message so Penny can answer questions about
/// the exact screen they're on.
enum PennyScreenContext {
    static func describe(tab: MainTab, user: AppUser?) -> String {
        var parts: [String] = ["The user is on the \(tab.title) tab of InvestEd."]

        guard let user else { return parts.joined(separator: " ") }

        switch tab {
        case .learn:
            let units = LessonContentData.units
            if user.currentUnitIndex < units.count {
                parts.append("They're currently working through \"\(units[user.currentUnitIndex].title)\".")
            }
            parts.append("Streak: \(user.streak) days. XP: \(user.xp) (level \(user.level)). Gold: \(user.goldBalance). Lessons completed: \(user.completedLessonIDs.count).")
        case .market:
            parts.append("Virtual cash: \(user.cashBalance.formatted(.currency(code: "USD"))).")
            if user.holdings.isEmpty {
                parts.append("They don't own any practice stocks yet.")
            } else {
                let holdings = user.holdings.map { "\($0.shares.formatted(.number.precision(.fractionLength(0...2)))) \($0.symbol)" }.joined(separator: ", ")
                parts.append("Practice holdings: \(holdings).")
            }
            if let options = user.optionPositions, !options.isEmpty {
                parts.append("Open practice option positions: \(options.map(\.displayName).joined(separator: "; ")).")
            }
            parts.append("The Market tab shows index powerhouses (S&P 500, NASDAQ 100, Dow, Russell 2000), a ticker search, popular stocks, and an Options Playground.")
        case .shop:
            parts.append("Gold balance: \(user.goldBalance). Streak Freezes owned: \(user.streakFreezes ?? 0) of 3 max. The shop sells power-ups and avatar gear for Gold; the InvestEd Plus subscription is shown but not purchasable yet.")
        case .friends:
            parts.append("They have \(user.friendIDs.count) friend\(user.friendIDs.count == 1 ? "" : "s"). This week's league XP: \(user.currentWeeklyXP).")
        case .profile:
            parts.append("Streak: \(user.streak) days. XP: \(user.xp) (level \(user.level)). Gold: \(user.goldBalance). Lessons completed: \(user.completedLessonIDs.count). Joined \(user.joinDate.formatted(date: .abbreviated, time: .omitted)).")
        }
        return parts.joined(separator: " ")
    }
}
