import SwiftUI

// Interactive answer controls for the Learn tab's lesson player. Each view
// owns its working state, reports the learner's current answer up through
// `onResponse` (nil = not ready to check yet), and freezes once `locked`.
// The lesson player recreates each view per question via `.id(question.id)`,
// so their @State always starts clean.

// MARK: - Shared building blocks

/// A small pill used across the interactive types.
private struct QChip: View {
    let title: String
    var selected: Bool
    var tint: Color = AppTheme.secondaryBlue
    var correctness: Correctness = .none
    let action: () -> Void

    enum Correctness { case none, right, wrong }

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(foreground)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Capsule().fill(background))
                .overlay(Capsule().stroke(border, lineWidth: 1.5))
        }
        .buttonStyle(SpringPressStyle())
    }

    private var foreground: Color {
        switch correctness {
        case .right: return AppTheme.primaryGreen
        case .wrong: return AppTheme.dangerRed
        case .none: return selected ? .white : AppTheme.textPrimary
        }
    }
    private var background: Color {
        switch correctness {
        case .right: return AppTheme.primaryGreen.opacity(0.15)
        case .wrong: return AppTheme.dangerRed.opacity(0.15)
        case .none: return selected ? tint : AppTheme.sunkenBackground
        }
    }
    private var border: Color {
        switch correctness {
        case .right: return AppTheme.primaryGreen
        case .wrong: return AppTheme.dangerRed
        case .none: return selected ? tint : AppTheme.hairline
        }
    }
}

/// A flowing, wrapping row of chips (SwiftUI has no native flow layout on all
/// targets, so we lay them out manually).
private struct FlowChips<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let items: Data
    let content: (Data.Element) -> Content

    var body: some View {
        // A simple two-per-row wrap works cleanly for our short chip labels.
        let array = Array(items)
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(stride(from: 0, to: array.count, by: 2)), id: \.self) { start in
                HStack(spacing: 10) {
                    content(array[start])
                    if start + 1 < array.count { content(array[start + 1]) }
                    Spacer(minLength: 0)
                }
            }
        }
    }
}

// MARK: - Multi-select ("choose all that apply")

struct MultiSelectAnswerView: View {
    let question: Question
    let locked: Bool
    let onResponse: (QuestionResponse?) -> Void

    @State private var selected: Set<Int> = []

    var body: some View {
        VStack(spacing: 12) {
            Text("Choose all that apply")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(question.choices) { choice in
                Button {
                    guard !locked else { return }
                    if selected.contains(choice.id) { selected.remove(choice.id) } else { selected.insert(choice.id) }
                    onResponse(selected.isEmpty ? nil : .choiceSet(selected))
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: symbol(for: choice))
                            .foregroundColor(tint(for: choice))
                        Text(choice.text)
                            .font(AppTheme.bodyFont)
                            .foregroundColor(AppTheme.textPrimary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(14)
                    .background(background(for: choice))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(border(for: choice), lineWidth: 2))
                }
                .disabled(locked)
            }
        }
    }

    private func isCorrectChoice(_ choice: AnswerChoice) -> Bool { question.correctChoiceIDs.contains(choice.id) }

    private func symbol(for choice: AnswerChoice) -> String {
        if locked {
            if isCorrectChoice(choice) { return "checkmark.circle.fill" }
            if selected.contains(choice.id) { return "xmark.circle.fill" }
            return "circle"
        }
        return selected.contains(choice.id) ? "checkmark.circle.fill" : "circle"
    }
    private func tint(for choice: AnswerChoice) -> Color {
        if locked { return isCorrectChoice(choice) ? AppTheme.primaryGreen : (selected.contains(choice.id) ? AppTheme.dangerRed : AppTheme.textSecondary) }
        return selected.contains(choice.id) ? AppTheme.primaryGreen : AppTheme.textSecondary
    }
    private func background(for choice: AnswerChoice) -> Color {
        if locked && isCorrectChoice(choice) { return AppTheme.primaryGreen.opacity(0.12) }
        if locked && selected.contains(choice.id) { return AppTheme.dangerRed.opacity(0.12) }
        return AppTheme.cardBackground
    }
    private func border(for choice: AnswerChoice) -> Color {
        if locked && isCorrectChoice(choice) { return AppTheme.primaryGreen }
        if locked && selected.contains(choice.id) { return AppTheme.dangerRed }
        return selected.contains(choice.id) ? AppTheme.primaryGreen : .clear
    }
}

// MARK: - Ordering ("tap in the right order")

struct OrderingAnswerView: View {
    let question: Question
    let locked: Bool
    let onResponse: (QuestionResponse?) -> Void

    @State private var order: [Int] = []           // original indices, in chosen order
    @State private var shuffled: [Int] = []        // display order of the chips

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Tap the steps in the correct order")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)

            ForEach(shuffled, id: \.self) { idx in
                let placedAt = order.firstIndex(of: idx)
                Button {
                    guard !locked else { return }
                    if let placedAt { order.remove(at: placedAt) } else { order.append(idx) }
                    onResponse(order.count == question.orderingItems.count ? .order(order) : nil)
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle().fill(placedAt != nil ? badgeColor(for: idx) : AppTheme.background)
                                .frame(width: 26, height: 26)
                            if let placedAt {
                                Text("\(placedAt + 1)")
                                    .font(.system(size: 13, weight: .heavy))
                                    .foregroundColor(.white)
                            }
                        }
                        Text(question.orderingItems[idx])
                            .font(AppTheme.bodyFont)
                            .foregroundColor(AppTheme.textPrimary)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(14)
                    .cardSurface(radius: 16)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(placedAt != nil ? badgeColor(for: idx) : Color.clear, lineWidth: 2))
                }
                .disabled(locked)
            }
        }
        .onAppear {
            if shuffled.isEmpty { shuffled = Array(question.orderingItems.indices).shuffled() }
        }
    }

    /// Once locked, a correctly-placed step goes green, a misplaced one red.
    private func badgeColor(for idx: Int) -> Color {
        guard locked, let placedAt = order.firstIndex(of: idx) else { return AppTheme.secondaryBlue }
        return placedAt == idx ? AppTheme.primaryGreen : AppTheme.dangerRed
    }
}

// MARK: - Matching ("connect each term to its match")

struct MatchingAnswerView: View {
    let question: Question
    let locked: Bool
    let onResponse: (QuestionResponse?) -> Void

    @State private var activeLeft: Int?
    @State private var matches: [Int: Int] = [:]      // left pair id -> right pair id
    @State private var rights: [MatchPair] = []        // shuffled right options

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Tap a term, then tap its match")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)

            ForEach(question.matchPairs) { pair in
                let matchedRightID = matches[pair.id]
                Button {
                    guard !locked else { return }
                    activeLeft = (activeLeft == pair.id) ? nil : pair.id
                } label: {
                    HStack {
                        Text(pair.left)
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        Spacer()
                        Text(matchedRightID.flatMap { id in rights.first(where: { $0.id == id })?.right } ?? "tap to match")
                            .font(AppTheme.captionFont)
                            .foregroundColor(matchedRightID == nil ? AppTheme.textSecondary : rowTint(pair))
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(14)
                    .background(activeLeft == pair.id ? AppTheme.secondaryBlue.opacity(0.12) : AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(rowBorder(pair), lineWidth: 2))
                }
                .disabled(locked)
            }

            if !locked {
                Divider().padding(.vertical, 2)
                Text("Matches")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                FlowChips(items: rights) { right in
                    QChip(title: right.right, selected: matches.values.contains(right.id)) {
                        guard let left = activeLeft else { return }
                        // Remove any previous left pointing at this right, then assign.
                        for (k, v) in matches where v == right.id { matches[k] = nil }
                        matches[left] = right.id
                        activeLeft = nil
                        onResponse(matches.count == question.matchPairs.count ? .matches(matches) : nil)
                    }
                }
            }
        }
        .onAppear { if rights.isEmpty { rights = question.matchPairs.shuffled() } }
    }

    private func rowTint(_ pair: MatchPair) -> Color {
        guard locked else { return AppTheme.textPrimary }
        return matches[pair.id] == pair.id ? AppTheme.primaryGreen : AppTheme.dangerRed
    }
    private func rowBorder(_ pair: MatchPair) -> Color {
        if locked { return matches[pair.id] == pair.id ? AppTheme.primaryGreen : AppTheme.dangerRed }
        if activeLeft == pair.id { return AppTheme.secondaryBlue }
        return matches[pair.id] != nil ? AppTheme.secondaryBlue.opacity(0.5) : .clear
    }
}

// MARK: - Numeric entry (keypad or slider)

struct NumericAnswerView: View {
    let question: Question
    let locked: Bool
    let onResponse: (QuestionResponse?) -> Void

    @State private var text = ""
    @State private var sliderValue: Double = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if question.useSlider {
                HStack {
                    Text(formatted(sliderValue))
                        .font(AppTheme.titleFont)
                        .foregroundColor(AppTheme.textPrimary)
                        .contentTransition(.numericText())
                    Spacer()
                }
                Slider(value: $sliderValue, in: question.numericMin...question.numericMax, step: question.numericStep) { _ in
                    onResponse(.number(sliderValue))
                }
                .disabled(locked)
                .tint(AppTheme.primaryGreen)
                HStack {
                    Text(formatted(question.numericMin)).font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
                    Spacer()
                    Text(formatted(question.numericMax)).font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
                }
            } else {
                HStack(spacing: 8) {
                    if let prefix = question.numericPrefix {
                        Text(prefix).font(AppTheme.headingFont).foregroundColor(AppTheme.textSecondary)
                    }
                    TextField("Your answer", text: $text)
                        .keyboardType(.decimalPad)
                        .font(AppTheme.headingFont)
                        .foregroundColor(AppTheme.textPrimary)
                        .disabled(locked)
                        .onChange(of: text) { _, newValue in
                            if let v = Double(newValue.trimmingCharacters(in: .whitespaces)) {
                                onResponse(.number(v))
                            } else {
                                onResponse(nil)
                            }
                        }
                    if let suffix = question.numericSuffix {
                        Text(suffix).font(AppTheme.headingFont).foregroundColor(AppTheme.textSecondary)
                    }
                }
                .padding(16)
                .cardSurface(radius: 16)
            }

            if locked, let answer = question.numericAnswer {
                Text("Correct answer: \(formatted(answer))")
                    .font(AppTheme.captionFont.bold())
                    .foregroundColor(AppTheme.primaryGreen)
            }
        }
        .onAppear {
            if question.useSlider {
                sliderValue = ((question.numericMin + question.numericMax) / 2 / question.numericStep).rounded() * question.numericStep
                onResponse(.number(sliderValue))
            }
        }
    }

    private func formatted(_ value: Double) -> String {
        let number = value == value.rounded() ? String(Int(value)) : String(format: "%.2f", value)
        return "\(question.numericPrefix ?? "")\(number)\(question.numericSuffix ?? "")"
    }
}

// MARK: - Categorize (sort items into buckets)

struct CategorizeAnswerView: View {
    let question: Question
    let locked: Bool
    let onResponse: (QuestionResponse?) -> Void

    @State private var assignment: [Int: String] = [:]

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Put each item in the right group")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)

            ForEach(question.categoryItems) { item in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 8) {
                        Text(item.text)
                            .font(AppTheme.bodyFont.bold())
                            .foregroundColor(AppTheme.textPrimary)
                        if locked {
                            Image(systemName: assignment[item.id] == item.correctCategory ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(assignment[item.id] == item.correctCategory ? AppTheme.primaryGreen : AppTheme.dangerRed)
                        }
                    }
                    HStack(spacing: 8) {
                        ForEach(question.categories, id: \.self) { category in
                            QChip(
                                title: category,
                                selected: assignment[item.id] == category,
                                correctness: correctness(item: item, category: category)
                            ) {
                                guard !locked else { return }
                                assignment[item.id] = category
                                onResponse(assignment.count == question.categoryItems.count ? .categorization(assignment) : nil)
                            }
                        }
                        Spacer(minLength: 0)
                    }
                }
                .padding(12)
                .cardSurface(radius: 16)
            }
        }
    }

    private func correctness(item: CategoryItem, category: String) -> QChip.Correctness {
        guard locked, assignment[item.id] == category else { return .none }
        return category == item.correctCategory ? .right : .wrong
    }
}

// MARK: - Interactive options challenge
//
// This is a teaching screen first and a builder second: every control carries
// a plain-English caption, the quote rows explain what each number means, and a
// live "what happens" line spells out the payoff so a beginner learns the
// vocabulary (strike, premium, breakeven, expiry) while they build the trade.

struct InteractiveOptionAnswerView: View {
    let question: Question
    let locked: Bool
    let onResponse: (QuestionResponse?) -> Void

    @State private var kind: OptionKind?
    @State private var strikeOffset: Double = 0
    @State private var expiryDays: Int = 30
    @State private var contracts: Int = 1

    private static let strikeOffsets: [Double] = [-0.10, -0.05, 0, 0.05, 0.10]
    private static let expiryChoices: [(days: Int, label: String)] = [(7, "1 wk"), (30, "1 mo"), (90, "3 mo")]

    private var challenge: OptionChallenge? { question.optionChallenge }

    private var strike: Double {
        guard let challenge else { return 0 }
        let raw = challenge.spot * (1 + strikeOffset)
        return raw >= 100 ? (raw / 5).rounded() * 5 : raw.rounded()
    }
    private var expiry: Date { Calendar.current.date(byAdding: .day, value: expiryDays, to: Date()) ?? Date() }
    private var premium: Double {
        guard let challenge, let kind else { return 0 }
        return OptionPricer.value(kind: kind, spot: challenge.spot, strike: strike, expiry: expiry)
    }
    private var totalCost: Double { premium * 100 * Double(contracts) }
    private var breakeven: Double { OptionPricer.breakeven(kind: kind ?? .call, strike: strike, premium: premium) }

    var body: some View {
        guard let challenge else { return AnyView(EmptyView()) }
        return AnyView(
            VStack(alignment: .leading, spacing: 14) {
                scenarioCard(challenge)
                primerCard

                // Call vs put
                Text("1. Pick your instrument")
                    .font(AppTheme.captionFont.bold()).foregroundColor(AppTheme.textPrimary)
                Text("A call = the right to BUY at your strike (bet the price goes up). A put = the right to SELL at your strike (bet it goes down).")
                    .font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
                HStack(spacing: 10) {
                    ForEach(OptionKind.allCases, id: \.self) { k in
                        QChip(title: k.label, selected: kind == k, correctness: kindCorrectness(k)) {
                            guard !locked else { return }
                            kind = k
                            onResponse(.option(kind: k))
                        }
                    }
                    Spacer(minLength: 0)
                }
                if let kind {
                    Text(kind.explainer)
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                }

                if kind != nil {
                    builderControls(challenge)
                    quoteCard(challenge)
                    payoffCard(challenge)
                }

                if locked {
                    Text(kind == challenge.requiredKind ? challenge.successNote
                         : "For a scenario like this, a \(challenge.requiredKind.label.lowercased()) is the fit: it profits in the direction the story is betting on.")
                        .font(AppTheme.captionFont.bold())
                        .foregroundColor(kind == challenge.requiredKind ? AppTheme.primaryGreen : AppTheme.dangerRed)
                }

                Text("Simulated Black-Scholes pricing, for learning only. Not investment advice.")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(AppTheme.textSecondary)
            }
        )
    }

    // MARK: Pieces

    private func scenarioCard(_ challenge: OptionChallenge) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(challenge.symbol) · \(challenge.companyName)")
                .font(AppTheme.captionFont.bold())
                .foregroundColor(AppTheme.textSecondary)
            Text(challenge.scenario)
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textPrimary)
            Text("Trading now at \(challenge.spot, format: .currency(code: "USD")) · the story expects it near \(challenge.targetPrice, format: .currency(code: "USD"))")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.secondaryBlue.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var primerCard: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(AppTheme.accentGold)
                .font(.system(size: 15))
            Text("An **option** is a contract, not the stock itself. You pay a **premium** up front for the right to buy (call) or sell (put) 100 shares at a set **strike** price until it **expires**. The premium is the most you can lose.")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.accentGold.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    @ViewBuilder
    private func builderControls(_ challenge: OptionChallenge) -> some View {
        // Strike
        Text("2. Choose a strike price")
            .font(AppTheme.captionFont.bold()).foregroundColor(AppTheme.textPrimary)
        Text("The price your bet is measured against. \"At\" is today's price; a higher call strike costs less but needs a bigger move to pay off.")
            .font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
        HStack(spacing: 8) {
            ForEach(Self.strikeOffsets, id: \.self) { offset in
                QChip(title: offset == 0 ? "At" : "\(offset > 0 ? "+" : "")\(Int(offset * 100))%",
                      selected: strikeOffset == offset) {
                    guard !locked else { return }
                    strikeOffset = offset
                }
            }
        }
        Text("Your strike: \(strike, format: .currency(code: "USD")) · \(strikeDescriptor)")
            .font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)

        // Expiry
        Text("3. Choose an expiry")
            .font(AppTheme.captionFont.bold()).foregroundColor(AppTheme.textPrimary)
        Text("How long your bet has to play out. More time costs more premium, because the stock gets more chances to move your way.")
            .font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
        HStack(spacing: 8) {
            ForEach(Self.expiryChoices, id: \.days) { choice in
                QChip(title: choice.label, selected: expiryDays == choice.days) {
                    guard !locked else { return }
                    expiryDays = choice.days
                }
            }
            Spacer(minLength: 0)
        }

        // Contracts
        Text("4. How many contracts?")
            .font(AppTheme.captionFont.bold()).foregroundColor(AppTheme.textPrimary)
        Text("Each contract controls 100 shares, so the premium is multiplied by 100 for every contract you buy.")
            .font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
        Stepper(value: $contracts, in: 1...5) {
            Text("\(contracts) contract\(contracts == 1 ? "" : "s") = \(contracts * 100) shares")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textPrimary)
        }
        .disabled(locked)
    }

    private func quoteCard(_ challenge: OptionChallenge) -> some View {
        VStack(spacing: 10) {
            teachRow("Strike", strike.formatted(.currency(code: "USD")),
                     "the price you're betting around")
            teachRow("Premium / share", premium.formatted(.currency(code: "USD")),
                     "what one share of the option costs")
            teachRow("Total cost", totalCost.formatted(.currency(code: "USD")),
                     "premium × 100 × contracts, which is also your max loss")
            teachRow("Breakeven", breakeven.formatted(.currency(code: "USD")),
                     kind == .put
                        ? "\(challenge.symbol) must fall below this to profit"
                        : "\(challenge.symbol) must rise above this to profit")
        }
        .padding(12)
        .cardSurface(radius: 14)
    }

    private func payoffCard(_ challenge: OptionChallenge) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: kind == .put ? "chart.line.downtrend.xyaxis" : "chart.line.uptrend.xyaxis")
                .foregroundColor(AppTheme.primaryGreen)
                .font(.system(size: 14))
            Text(payoffText(challenge))
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textPrimary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.primaryGreen.opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    // MARK: Helpers

    private var strikeDescriptor: String {
        if strikeOffset == 0 { return "right at today's price" }
        let pct = abs(Int(strikeOffset * 100))
        return strikeOffset > 0 ? "\(pct)% above today's price" : "\(pct)% below today's price"
    }

    private func payoffText(_ challenge: OptionChallenge) -> String {
        let be = breakeven.formatted(.currency(code: "USD"))
        let strk = strike.formatted(.currency(code: "USD"))
        let cost = totalCost.formatted(.currency(code: "USD"))
        if kind == .put {
            return "You profit if \(challenge.symbol) falls below \(be) by expiry. If it stays above your \(strk) strike, the put expires worthless and you lose the \(cost) you paid."
        }
        return "You profit if \(challenge.symbol) climbs above \(be) by expiry. If it stays below your \(strk) strike, the call expires worthless and you lose the \(cost) you paid."
    }

    private func kindCorrectness(_ k: OptionKind) -> QChip.Correctness {
        guard locked, let challenge else { return .none }
        if k == challenge.requiredKind { return .right }
        if kind == k { return .wrong }
        return .none
    }

    private func teachRow(_ label: String, _ value: String, _ note: String) -> some View {
        VStack(spacing: 2) {
            HStack {
                Text(label).font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
                Spacer()
                Text(value).font(AppTheme.bodyFont.bold()).foregroundColor(AppTheme.textPrimary)
            }
            Text(note)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(AppTheme.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
