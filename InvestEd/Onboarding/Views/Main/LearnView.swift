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
            ZStack {
                AppTheme.background.ignoresSafeArea()
                FloatingMoneyBackground()
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 36) {
                            statsHeader
                            if streakAtRisk {
                                streakBanner
                            }
                            let currentID = currentNodeID
                            ForEach(Array(viewModel.units.enumerated()), id: \.element.id) { unitIndex, unit in
                                UnitPathView(unit: unit, unitIndex: unitIndex, viewModel: viewModel, currentNodeID: currentID)
                            }
                        }
                        .padding()
                        // Generous bottom room so the last path stop scrolls
                        // well above the floating tab bar and stays tappable.
                        .padding(.bottom, 120)
                    }
                    .onAppear {
                        // Land the returning user on their current stop, not Unit 1.
                        guard let id = currentNodeID else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.easeInOut) { proxy.scrollTo(id, anchor: .center) }
                        }
                    }
                }
            }
            .navigationTitle("Learn")
            .fullScreenCover(item: $viewModel.activeLesson) { _ in
                LessonPlayerView(viewModel: viewModel)
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
        guard let user = appState.currentUser, user.streak > 0 else { return false }
        guard let last = user.lastLessonDate else { return true }
        return !Calendar.current.isDateInToday(last)
    }

    private var streakBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "flame.fill")
                .font(.system(size: 22))
                .foregroundColor(AppTheme.streakOrange)
            VStack(alignment: .leading, spacing: 2) {
                Text("Your \(appState.currentUser?.streak ?? 0)-day streak is on the line!")
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text("One quick lesson today keeps the flame alive.")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
        }
        .padding(14)
        .background(AppTheme.streakOrange.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                .stroke(AppTheme.streakOrange.opacity(0.4), lineWidth: 1.5)
        )
    }

    private var statsHeader: some View {
        HStack(spacing: 10) {
            StatChip(icon: "flame.fill", value: "\(appState.currentUser?.streak ?? 0)", color: AppTheme.streakOrange)
            StatChip(icon: "star.fill", value: "\(appState.currentUser?.xp ?? 0)", color: AppTheme.accentGold)
            StatChip(icon: "rosette", value: "Lv \((appState.currentUser?.level ?? 1))", color: AppTheme.secondaryBlue)
            StatChip(icon: "goldcoin", value: "\(appState.currentUser?.goldBalance ?? 0)", color: AppTheme.accentGold)
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

    var body: some View {
        VStack(spacing: 30) {
            banner
            VStack(spacing: 34) {
                ForEach(Array(unit.lessons.enumerated()), id: \.element.id) { lessonIndex, lesson in
                    PathNodeView(
                        lesson: lesson,
                        state: nodeState(lessonIndex: lessonIndex, lesson: lesson),
                        xOffset: xOffset(for: lessonIndex),
                        guide: lessonIndex == 1 ? unitGuide : nil
                    ) {
                        viewModel.startLesson(lesson, unitIndex: unitIndex)
                    }
                    .id(lesson.id)
                }
                if let test = unit.finalTest {
                    FinalTestNodeView(
                        title: test.title,
                        state: finalTestState(test: test),
                        isCurrent: test.id == currentNodeID
                    ) {
                        viewModel.startFinalTest(unitIndex: unitIndex)
                    }
                    .id(test.id)
                }
            }
        }
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
                Text(unit.title)
                    .font(AppTheme.headingFont)
                    .foregroundColor(.white)
                Text(unit.subtitle)
                    .font(AppTheme.captionFont)
                    .foregroundColor(.white.opacity(0.85))
                Text("with \(unitGuide.name)")
                    .font(.system(size: 10.5, weight: .semibold, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
            }
            Spacer()
            Image(unitGuide.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 62, height: 62)
                .shadow(color: .black.opacity(0.15), radius: 4, y: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(hex: unit.colorHex))
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }
}

// MARK: - Path node

private struct PathNodeView: View {
    enum NodeState { case completed, current, available, locked }

    let lesson: Lesson
    let state: NodeState
    let xOffset: CGFloat
    var guide: Mascot? = nil
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

            Text(lesson.title)
                .font(AppTheme.captionFont)
                .foregroundColor(state == .locked ? AppTheme.textSecondary.opacity(0.6) : AppTheme.textSecondary)
                .lineLimit(1)
                .frame(maxWidth: 150)
        }
        .overlay(alignment: xOffset > 0 ? .leading : .trailing) {
            if state == .current {
                SnoutCoinMark(size: 30)
                    .offset(x: xOffset > 0 ? -58 : 58, y: 10)
                    .transition(.scale.combined(with: .opacity))
            } else if let guide {
                VStack(spacing: 3) {
                    Image(guide.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)
                        .shadow(color: .black.opacity(0.12), radius: 3, y: 2)
                    Text(guide.name)
                        .font(.system(size: 9, weight: .semibold, design: .rounded))
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
    let action: () -> Void

    @State private var pulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: 8) {
            if isCurrent {
                Text("KNOWLEDGE CHECK")
                    .font(.system(size: 11, weight: .heavy, design: .rounded))
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
            // A soft green/red hue pulses in from the screen edges on each answer.
            Rectangle()
                .fill(RadialGradient(
                    gradient: Gradient(colors: [.clear, .clear, edgeGlowColor.opacity(0.85)]),
                    center: .center, startRadius: 170, endRadius: 540))
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
                    .font(.system(size: 11, weight: .heavy, design: .rounded))
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
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
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
                 ? "The Knowledge Check needs all 5 lives. Review the unit and give it another shot!"
                 : "You used all 5 lives. Give this lesson another try — you've got this!")
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
