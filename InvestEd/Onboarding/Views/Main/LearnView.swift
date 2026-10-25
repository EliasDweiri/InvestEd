import SwiftUI

/// The Learn tab: each unit is its own "stretch of road" — a winding path
/// of lesson stops that snakes left and right down the screen, ending in a
/// golden final-test trophy that gates the next unit. Completed stops turn
/// into gold coins, your current stop pulses and shows a START pill, and
/// everything ahead waits under a lock. Penny peeks in beside the stop
/// you're on — one cameo on screen, never more.
struct LearnView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = LearnViewModel()

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                TabScreen(tab: .learn) {
                    PennyCompanion(tab: .learn)
                } hero: {
                    learnHero
                } content: {
                    if streakAtRisk {
                        streakBanner
                    }
                    let currentID = currentNodeID
                    ForEach(Array(viewModel.units.enumerated()), id: \.element.id) { unitIndex, unit in
                        UnitPathView(unit: unit, unitIndex: unitIndex, viewModel: viewModel, currentNodeID: currentID)
                    }
                }
                .onAppear {
                    // Land a returning user on their current stop instead of
                    // Unit 1 — but while they're still in Unit 1, keep the
                    // header (streak, XP, progress) in view.
                    guard let id = currentNodeID, (appState.currentUser?.currentUnitIndex ?? 0) > 0 else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.easeInOut) { proxy.scrollTo(id, anchor: .center) }
                    }
                }
            }
            .fullScreenCover(item: $viewModel.activeLesson) { _ in
                LessonPlayerView(viewModel: viewModel)
            }
        }
    }

    // MARK: - Header

    private var totalLessons: Int { viewModel.units.reduce(0) { $0 + $1.lessons.count } }
    private var doneLessons: Int { appState.currentUser?.completedLessonIDs.count ?? 0 }

    /// The unit the learner is working in right now.
    private var currentUnitTitle: String {
        let index = min(appState.currentUser?.currentUnitIndex ?? 0, max(viewModel.units.count - 1, 0))
        return viewModel.units.indices.contains(index) ? viewModel.units[index].title : ""
    }

    private var learnHero: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Text(currentUnitTitle)
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Text("\(doneLessons) of \(totalLessons) lessons")
                        .font(.caption.weight(.semibold).monospacedDigit())
                        .opacity(0.8)
                }
                .foregroundColor(AppTheme.onInk)
                HeaderProgressBar(progress: totalLessons == 0 ? 0 : Double(doneLessons) / Double(totalLessons))
            }
            HStack(spacing: 8) {
                HeaderStat(icon: "flame.fill", value: "\(appState.currentUser?.activeStreak ?? 0)", label: "streak")
                HeaderStat(icon: "star.fill", value: "\(appState.currentUser?.xp ?? 0)", label: "XP")
                HeaderStat(icon: "rosette", value: "\(appState.currentUser?.level ?? 1)", label: "level")
                HeaderStat(icon: "goldcoin", value: "\(appState.currentUser?.goldBalance ?? 0)", label: "Gold")
            }
        }
    }

    /// The single "you are here" stop: the first unlocked, uncompleted lesson
    /// anywhere on the path — or, when a unit's lessons are all done, its final
    /// test. Only this one pulses, shows START, and gets the Penny cameo.
    private var currentNodeID: String? {
        for (u, unit) in viewModel.units.enumerated() {
            for (l, lesson) in unit.lessons.enumerated() {
                if viewModel.isLessonUnlocked(unitIndex: u, lessonIndex: l) && !viewModel.isLessonCompleted(lesson) {
                    return lesson.id
                }
            }
            if viewModel.isFinalTestUnlocked(u), !viewModel.isFinalTestPassed(u), let test = unit.finalTest {
                return test.id
            }
        }
        return nil
    }

    /// True when there's a streak to lose and no lesson done yet today.
    private var streakAtRisk: Bool {
        guard let user = appState.currentUser, user.activeStreak > 0 else { return false }
        guard let last = user.lastLessonDate else { return true }
        return !Calendar.current.isDateInToday(last)
    }

    private var streakBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "flame.fill")
                .font(.system(size: 22))
                .foregroundColor(AppTheme.streakOrange)
            VStack(alignment: .leading, spacing: 2) {
                Text("Your \(appState.currentUser?.activeStreak ?? 0)-day streak is on the line!")
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("One quick lesson today keeps the flame alive.")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
        }
        .padding(14)
        .cardSurface()
        .overlay(alignment: .leading) {
            // A brick-colored rule down the left edge, like a callout box.
            UnevenRoundedRectangle(topLeadingRadius: AppTheme.cornerRadius, bottomLeadingRadius: AppTheme.cornerRadius)
                .fill(AppTheme.streakOrange)
                .frame(width: 5)
        }
    }

}

struct StatChip: View {
    let icon: String
    let value: String
    let color: Color

    var body: some View {
        HStack(spacing: 6) {
            if icon == "goldcoin" {
                GoldCoinIcon(size: 16)
            } else {
                Image(systemName: icon).foregroundColor(color)
            }
            Text(value)
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textPrimary)
                .contentTransition(.numericText())
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(AppTheme.cardBackground)
        .clipShape(Capsule())
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(accessibilityName): \(value)")
    }

    /// Spoken name for the chip's icon so VoiceOver says "Streak: 5", not "flame".
    private var accessibilityName: String {
        switch icon {
        case "goldcoin": return "Gold"
        case "rosette": return "Level"
        case let i where i.contains("flame"): return "Streak"
        case let i where i.contains("heart"): return "Hearts"
        case let i where i.contains("star") || i.contains("bolt"): return "XP"
        default: return "Stat"
        }
    }
}

// MARK: - Unit path

private struct UnitPathView: View {
    let unit: LearningUnit
    let unitIndex: Int
    @ObservedObject var viewModel: LearnViewModel
    let currentNodeID: String?

    private var unitColor: Color { Color(hex: unit.colorHex) }

    var body: some View {
        VStack(spacing: 0) {
            banner
            VStack(spacing: 30) {
                ForEach(Array(unit.lessons.enumerated()), id: \.element.id) { lessonIndex, lesson in
                    PathNodeView(
                        lesson: lesson,
                        state: nodeState(lessonIndex: lessonIndex, lesson: lesson),
                        xOffset: xOffset(for: lessonIndex),
                        guide: lessonIndex == 1 ? unitGuide : nil,
                        anchorIndex: lessonIndex
                    ) {
                        viewModel.startLesson(lesson, unitIndex: unitIndex)
                    }
                    .id(lesson.id)
                }
                if let test = unit.finalTest {
                    FinalTestNodeView(
                        title: test.title,
                        state: finalTestState(test: test),
                        isCurrent: test.id == currentNodeID,
                        anchorIndex: unit.lessons.count
                    ) {
                        viewModel.startFinalTest(unitIndex: unitIndex)
                    }
                    .id(test.id)
                }
            }
            .padding(.vertical, 26)
            .frame(maxWidth: .infinity)
            // The dotted road that links the stops, drawn through each
            // node's center so it always follows the zigzag exactly.
            .backgroundPreferenceValue(NodeAnchorKey.self) { anchors in
                GeometryReader { geo in
                    let points = anchors.sorted { $0.key < $1.key }.map { geo[$0.value] }
                    Path { path in
                        guard let first = points.first else { return }
                        path.move(to: first)
                        for (from, to) in zip(points, points.dropFirst()) {
                            let midY = (from.y + to.y) / 2
                            path.addCurve(to: to,
                                          control1: CGPoint(x: from.x, y: midY),
                                          control2: CGPoint(x: to.x, y: midY))
                        }
                    }
                    .stroke(unitColor.opacity(0.35),
                            style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [0.5, 9]))
                }
            }
            .background(unitColor.opacity(0.05))
        }
        .cardSurface(radius: 18)
        .opacity(viewModel.isUnitUnlocked(unitIndex) ? 1 : 0.72)
    }

    private var lessonsDone: Int {
        unit.lessons.filter { viewModel.isLessonCompleted($0) }.count
    }

    /// Gentle zigzag: center, left, center, right, repeat.
    private func xOffset(for index: Int) -> CGFloat {
        let pattern: [CGFloat] = [0, -64, 0, 64, 0]
        return pattern[index % pattern.count]
    }

    /// Each unit's animal guide, chosen for its money symbolism.
    private var unitGuide: Mascot {
        Mascots.guide(forUnit: unit.id)
    }

    private func nodeState(lessonIndex: Int, lesson: Lesson) -> PathNodeView.NodeState {
        if viewModel.isLessonCompleted(lesson) { return .completed }
        if lesson.id == currentNodeID { return .current }
        if viewModel.isLessonUnlocked(unitIndex: unitIndex, lessonIndex: lessonIndex) { return .available }
        return .locked
    }

    private func finalTestState(test: Lesson) -> FinalTestNodeView.TestState {
        if viewModel.isFinalTestPassed(unitIndex) { return .passed }
        if viewModel.isFinalTestUnlocked(unitIndex) { return .available }
        return .locked
    }

    private var banner: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text("UNIT \(unitIndex + 1)")
                    .font(AppTheme.kickerFont)
                    .tracking(1.2)
                    .foregroundColor(AppTheme.onInk.opacity(0.75))
                Text(unitTopic)
                    .font(.system(.title3, design: .serif).weight(.bold))
                    .foregroundColor(AppTheme.onInk)
                Text(unit.subtitle)
                    .font(.footnote)
                    .foregroundColor(AppTheme.onInk.opacity(0.82))
                    .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 8) {
                    HeaderProgressBar(progress: unit.lessons.isEmpty ? 0 : Double(lessonsDone) / Double(unit.lessons.count))
                        .frame(width: 90)
                    Text("\(lessonsDone)/\(unit.lessons.count) · with \(unitGuide.name)")
                        .font(.caption2.weight(.semibold).monospacedDigit())
                        .foregroundColor(AppTheme.onInk.opacity(0.8))
                }
                .padding(.top, 4)
            }
            Spacer()
            Image(unitGuide.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 58, height: 58)
                .padding(5)
                .background(AppTheme.onInk.opacity(0.16), in: Circle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            ZStack {
                unitColor
                GuillochePattern(lines: 8).stroke(AppTheme.onInk.opacity(0.10), lineWidth: 0.6)
            }
            .clipped()
        )
    }

    /// "Unit 3: Credit & Debt" -> "Credit & Debt" (the number is shown separately).
    private var unitTopic: String {
        guard let colon = unit.title.firstIndex(of: ":") else { return unit.title }
        return unit.title[unit.title.index(after: colon)...].trimmingCharacters(in: .whitespaces)
    }
}

/// Collects the center of every stop on a unit's path, in order, so the
/// connecting road can be drawn through them.
private struct NodeAnchorKey: PreferenceKey {
    static let defaultValue: [Int: Anchor<CGPoint>] = [:]
    static func reduce(value: inout [Int: Anchor<CGPoint>], nextValue: () -> [Int: Anchor<CGPoint>]) {
        value.merge(nextValue()) { $1 }
    }
}

// MARK: - Path node

private struct PathNodeView: View {
    enum NodeState { case completed, current, available, locked }

    let lesson: Lesson
    let state: NodeState
    let xOffset: CGFloat
    var guide: Mascot? = nil
    var anchorIndex: Int = 0
    let action: () -> Void

    @State private var pulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    /// What VoiceOver reads for this node, e.g. "Compound Interest, current lesson, 20 XP".
    private var accessibilityStateLabel: String {
        switch state {
        case .completed: return "completed"
        case .current: return "current lesson, \(lesson.xpReward) XP"
        case .available: return "available"
        case .locked: return "locked"
        }
    }

    var body: some View {
        VStack(spacing: 8) {
            if state == .current {
                startPill
            }
            Button(action: action) {
                node
            }
            .buttonStyle(SpringPressStyle())
            .disabled(state == .locked)
            .accessibilityLabel("\(lesson.title), \(accessibilityStateLabel)")
            .accessibilityHint(state == .locked ? "Finish earlier lessons to unlock" : "Starts the lesson")
            .anchorPreference(key: NodeAnchorKey.self, value: .center) { [anchorIndex: $0] }

            Text(lesson.title)
                .font(AppTheme.captionFont)
                .foregroundColor(state == .locked ? AppTheme.textSecondary.opacity(0.6) : AppTheme.textSecondary)
                .lineLimit(1)
                .frame(maxWidth: 150)
        }
        .overlay(alignment: xOffset > 0 ? .leading : .trailing) {
            if state != .current, let guide {
                VStack(spacing: 3) {
                    Image(guide.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .shadow(color: .black.opacity(0.12), radius: 3, y: 2)
                    Text(guide.name)
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(AppTheme.textSecondary)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(AppTheme.cardBackground))
                }
                .offset(x: xOffset > 0 ? -70 : 70, y: 2)
            }
        }
        .offset(x: xOffset)
        .onAppear {
            // Respect the system "Reduce Motion" setting: no endless pulse.
            guard state == .current, !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) {
                pulsing = true
            }
        }
    }

    private var node: some View {
        ZStack {
            if state == .current {
                Circle()
                    .stroke(AppTheme.primaryGreen.opacity(0.35), lineWidth: 5)
                    .frame(width: 84, height: 84)
                    .scaleEffect(pulsing ? 1.08 : 0.96)
            }
            Circle()
                .fill(fillColor)
                .frame(width: 68, height: 68)
                .overlay(
                    Circle()
                        .stroke(ringColor, lineWidth: state == .completed ? 4 : 0)
                        .padding(7)
                )
            Image(systemName: iconName)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(iconColor)
        }
        .frame(width: 88, height: 88)
    }

    private var fillColor: Color {
        switch state {
        case .completed: return AppTheme.accentGold
        case .current: return AppTheme.primaryGreen
        case .available: return AppTheme.secondaryBlue
        case .locked: return AppTheme.textSecondary.opacity(0.22)
        }
    }

    private var ringColor: Color {
        state == .completed ? Color(hex: "E0A82E") : .clear
    }

    private var iconName: String {
        switch state {
        case .completed: return "checkmark"
        case .current, .available: return lesson.iconName
        case .locked: return "lock.fill"
        }
    }

    private var iconColor: Color {
        switch state {
        case .completed: return Color(hex: "8A6410")
        case .current, .available: return .white
        case .locked: return AppTheme.textSecondary
        }
    }

    private var startPill: some View {
        Text("START +\(lesson.xpReward) XP")
            .font(AppTheme.captionFont)
            .foregroundColor(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 7)
            .background(AppTheme.primaryGreen)
            .clipShape(Capsule())
    }
}

// MARK: - Final-test node (the unit "boss")

private struct FinalTestNodeView: View {
    enum TestState { case locked, available, passed }

    let title: String
    let state: TestState
    let isCurrent: Bool
    var anchorIndex: Int = 0
    let action: () -> Void

    @State private var pulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: 8) {
            if isCurrent {
                Text("KNOWLEDGE CHECK")
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background(AppTheme.accentGold)
                    .clipShape(Capsule())
            }
            Button(action: action) {
                ZStack {
                    if isCurrent {
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(AppTheme.accentGold.opacity(0.4), lineWidth: 5)
                            .frame(width: 96, height: 96)
                            .scaleEffect(pulsing ? 1.06 : 0.96)
                    }
                    RoundedRectangle(cornerRadius: 22)
                        .fill(fillColor)
                        .frame(width: 78, height: 78)
                    Image(systemName: state == .locked ? "lock.fill" : "trophy.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(iconColor)
                }
                .frame(width: 100, height: 100)
            }
            .buttonStyle(SpringPressStyle())
            .disabled(state == .locked)
            .accessibilityLabel("\(title), knowledge check, \(state == .passed ? "passed" : state == .locked ? "locked" : "available")")
            .anchorPreference(key: NodeAnchorKey.self, value: .center) { [anchorIndex: $0] }

            Text(title)
                .font(AppTheme.captionFont.bold())
                .foregroundColor(state == .locked ? AppTheme.textSecondary.opacity(0.6) : AppTheme.textPrimary)
                .lineLimit(1)
                .frame(maxWidth: 180)
        }
        .onAppear {
            guard isCurrent, !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 1.1).repeatForever(autoreverses: true)) { pulsing = true }
        }
    }

    private var fillColor: Color {
        switch state {
        case .passed: return AppTheme.accentGold
        case .available: return AppTheme.streakOrange
        case .locked: return AppTheme.textSecondary.opacity(0.22)
        }
    }

    private var iconColor: Color {
        switch state {
        case .passed: return Color(hex: "8A6410")
        case .available: return .white
        case .locked: return AppTheme.textSecondary
        }
    }
}

// MARK: - Lesson player (question flow)

struct LessonPlayerView: View {
    @ObservedObject var viewModel: LearnViewModel

    @State private var answered = false
    @State private var wasCorrect = false
    @State private var celebrationShown = false

    // Per-question working state
    @State private var shuffledChoices: [AnswerChoice] = []   // MC / TF
    @State private var selectedChoiceID: Int?                  // MC / TF
    @State private var pendingResponse: QuestionResponse?      // interactive types

    // Edge-glow feedback flash
    @State private var edgeGlowColor: Color = .clear
    @State private var edgeGlowOpacity: Double = 0

    private var question: Question? { viewModel.currentQuestion }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            if viewModel.showLessonComplete {
                completionView
            } else if viewModel.lessonFailed && !answered {
                failView
            } else if let question {
                questionView(question)
            }
            // A green/red frame flashes around the screen on each answer.
            Rectangle()
                .strokeBorder(edgeGlowColor, lineWidth: 7)
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .opacity(edgeGlowOpacity)
        }
    }

    /// Quick edge-vignette flash — green for a correct answer, red for a miss.
    private func flashEdge(correct: Bool) {
        edgeGlowColor = correct ? AppTheme.primaryGreen : AppTheme.dangerRed
        withAnimation(.easeOut(duration: 0.18)) { edgeGlowOpacity = 0.7 }
        withAnimation(.easeIn(duration: 0.7).delay(0.18)) { edgeGlowOpacity = 0 }
    }

    // MARK: Question screen

    private func questionView(_ question: Question) -> some View {
        VStack(spacing: 18) {
            header
            ProgressBarView(progress: progress)
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(question.prompt)
                        .font(AppTheme.headingFont)
                        .foregroundColor(AppTheme.textPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 4)

                    answerArea(for: question)

                    if answered {
                        feedbackCard(question: question)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            Spacer(minLength: 0)
            bottomBar(for: question)
        }
        .padding()
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: answered)
        .onAppear { prepareForCurrent() }
        .onChange(of: viewModel.currentQuestionIndex) { _, _ in prepareForCurrent() }
    }

    /// Dispatches to the right control set for the question type.
    @ViewBuilder
    private func answerArea(for question: Question) -> some View {
        switch question.type {
        case .multipleChoice, .trueFalse:
            VStack(spacing: 12) {
                ForEach(shuffledChoices) { choice in
                    AnswerOptionButton(text: choice.text, state: optionState(for: choice, question: question)) {
                        guard !answered else { return }
                        grade(.choice(choice.id), selected: choice.id)
                    }
                    .disabled(answered)
                }
            }
        case .multiSelect:
            MultiSelectAnswerView(question: question, locked: answered) { pendingResponse = $0 }
                .id(question.id)
        case .ordering:
            OrderingAnswerView(question: question, locked: answered) { pendingResponse = $0 }
                .id(question.id)
        case .matching:
            MatchingAnswerView(question: question, locked: answered) { pendingResponse = $0 }
                .id(question.id)
        case .numericEntry:
            NumericAnswerView(question: question, locked: answered) { pendingResponse = $0 }
                .id(question.id)
        case .categorize:
            CategorizeAnswerView(question: question, locked: answered) { pendingResponse = $0 }
                .id(question.id)
        case .interactiveOption:
            InteractiveOptionAnswerView(question: question, locked: answered) { pendingResponse = $0 }
                .id(question.id)
        }
    }

    /// The Check/Continue button that anchors the bottom of the screen.
    @ViewBuilder
    private func bottomBar(for question: Question) -> some View {
        if answered {
            PrimaryButton(title: viewModel.lessonFailed ? "See Results" : "Continue") {
                answered = false
                selectedChoiceID = nil
                pendingResponse = nil
                if !viewModel.lessonFailed { viewModel.advance() }
            }
        } else if requiresCheckButton(question) {
            PrimaryButton(title: "Check") {
                guard let response = pendingResponse else { return }
                grade(response, selected: nil)
            }
            .opacity(pendingResponse == nil ? 0.5 : 1)
            .disabled(pendingResponse == nil)
        }
    }

    private func requiresCheckButton(_ question: Question) -> Bool {
        switch question.type {
        case .multipleChoice, .trueFalse: return false   // graded on tap
        default: return true
        }
    }

    private func grade(_ response: QuestionResponse, selected: Int?) {
        selectedChoiceID = selected
        wasCorrect = viewModel.submit(response)
        answered = true
        flashEdge(correct: wasCorrect)
        UINotificationFeedbackGenerator().notificationOccurred(wasCorrect ? .success : .error)
    }

    private func prepareForCurrent() {
        answered = false
        selectedChoiceID = nil
        pendingResponse = nil
        shuffledChoices = (viewModel.currentQuestion?.choices ?? []).shuffled()
    }

    private var progress: Double {
        guard let lesson = viewModel.activeLesson, !lesson.questions.isEmpty else { return 0 }
        return Double(viewModel.currentQuestionIndex) / Double(lesson.questions.count)
    }

    private var header: some View {
        HStack {
            Button {
                viewModel.activeLesson = nil
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
            if viewModel.activeIsFinalTest {
                Text("KNOWLEDGE CHECK")
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(AppTheme.accentGold)
            }
            Spacer()
            HStack(spacing: 4) {
                ForEach(0..<Constants.heartsPerLesson, id: \.self) { i in
                    Image(systemName: i < viewModel.hearts ? "heart.fill" : "heart")
                        .foregroundColor(AppTheme.dangerRed)
                        .font(.system(size: 15))
                }
            }
            .animation(.default, value: viewModel.hearts)
        }
    }

    private func optionState(for choice: AnswerChoice, question: Question) -> AnswerOptionButton.OptionState {
        guard answered else { return .normal }
        if choice.id == question.correctChoiceID { return .correct }
        if choice.id == selectedChoiceID { return .incorrect }
        return .disabled
    }

    private func feedbackCard(question: Question) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: wasCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                Text(wasCorrect ? "Nice!" : "Not quite")
            }
            .font(AppTheme.bodyFont.bold())
            .foregroundColor(wasCorrect ? AppTheme.primaryGreen : AppTheme.dangerRed)
            Text(question.explanation)
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .cardSurface(radius: 16)
    }

    // MARK: Out-of-hearts screen

    private var failView: some View {
        VStack(spacing: 18) {
            Spacer()
            Image(systemName: "heart.slash.fill")
                .font(.system(size: 64))
                .foregroundColor(AppTheme.dangerRed)
            Text("Out of hearts!")
                .font(AppTheme.titleFont)
                .foregroundColor(AppTheme.textPrimary)
            Text(viewModel.activeIsFinalTest
                 ? "The Knowledge Check needs all 5 lives. Review the unit and give it another shot."
                 : "You used all 5 lives. Review the explanations and try the lesson again.")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Text("You got \(viewModel.correctInLesson) correct before running out.")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
            Spacer()
            if viewModel.canAffordHeartRefill {
                PrimaryButton(title: "Refill 5 hearts · \(viewModel.heartRefillCost) Gold") {
                    if viewModel.refillHearts() { answered = false }
                }
                Button("Start Over") {
                    answered = false
                    viewModel.retry()
                }
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(AppTheme.textSecondary)
            } else {
                PrimaryButton(title: "Try Again") {
                    answered = false
                    viewModel.retry()
                }
                Text("Earn \(viewModel.heartRefillCost) Gold to refill hearts and keep your place.")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                    .multilineTextAlignment(.center)
            }
            Button("Back to Path") { viewModel.activeLesson = nil }
                .font(AppTheme.captionFont.bold())
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding()
    }

    // MARK: Completion screen

    private var completionView: some View {
        let lesson = viewModel.activeLesson
        let total = lesson?.questions.count ?? 0
        let perfect = viewModel.correctInLesson == total && total > 0
        let isFinal = viewModel.activeIsFinalTest
        let guide = Mascots.guide(forUnit: viewModel.units[viewModel.activeUnitIndex].id)
        let unlockedNext = isFinal && viewModel.activeUnitIndex < viewModel.units.count - 1

        return VStack(spacing: 18) {
            Spacer()
            if isFinal {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 88))
                    .foregroundColor(AppTheme.accentGold)
                    .scaleEffect(celebrationShown ? 1 : 0.3)
                    .animation(.spring(response: 0.45, dampingFraction: 0.55), value: celebrationShown)
            } else {
                Image(guide.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .scaleEffect(celebrationShown ? 1 : 0.3)
                    .animation(.spring(response: 0.45, dampingFraction: 0.55), value: celebrationShown)
            }
            Text(isFinal
                 ? "Unit cleared!"
                 : (perfect ? "Perfect! \(guide.name) approves." : "Lesson complete!"))
                .font(AppTheme.titleFont)
                .foregroundColor(AppTheme.textPrimary)
                .multilineTextAlignment(.center)

            HStack(spacing: 10) {
                HStack(spacing: 6) {
                    Image(systemName: "star.fill").foregroundColor(Color(hex: "8A6410"))
                    Text("+\(viewModel.lastEarnedXP) XP")
                        .font(AppTheme.bodyFont.bold())
                        .foregroundColor(Color(hex: "8A6410"))
                }
                .padding(.horizontal, 18).padding(.vertical, 10)
                .background(AppTheme.accentGold)
                .clipShape(Capsule())

                HStack(spacing: 6) {
                    GoldCoinIcon(size: 16)
                    Text("+\(viewModel.lastEarnedGold) Gold")
                        .font(AppTheme.bodyFont.bold())
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 18).padding(.vertical, 10)
                .background(AppTheme.primaryGreen)
                .clipShape(Capsule())
            }
            .scaleEffect(celebrationShown ? 1 : 0.5)
            .opacity(celebrationShown ? 1 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.15), value: celebrationShown)

            if unlockedNext {
                HStack(spacing: 5) {
                    Image(systemName: "lock.open.fill")
                    Text("Next unit unlocked!")
                }
                .font(AppTheme.bodyFont.bold())
                .foregroundColor(AppTheme.primaryGreen)
            }

            if viewModel.streakFreezeUsed {
                HStack(spacing: 5) {
                    Image(systemName: "snowflake")
                    Text("A Streak Freeze saved your streak!")
                }
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.secondaryBlue)
            }
            Text("You got \(viewModel.correctInLesson) of \(total) correct.")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textSecondary)
            Spacer()
            PrimaryButton(title: "Keep Going") {
                viewModel.showLessonComplete = false
                viewModel.activeLesson = nil
            }
        }
        .padding()
        .onAppear { celebrationShown = true }
        .onDisappear { celebrationShown = false }
    }
}
