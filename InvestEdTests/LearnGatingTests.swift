import Testing
@testable import InvestEd

/// The Learn-tab progression engine: unit/lesson unlocking, the Knowledge
/// Check gate, and hearts/fail behavior. These touch the shared AppState
/// singleton, so the suite is serialized.
@MainActor
@Suite(.serialized)
struct LearnGatingTests {

    @Test func freshUserHasOnlyTheFirstStopOpen() {
        AppState.shared.currentUser = AppUser.newUserDefault
        let vm = LearnViewModel()
        #expect(vm.isLessonUnlocked(unitIndex: 0, lessonIndex: 0))
        #expect(!vm.isLessonUnlocked(unitIndex: 0, lessonIndex: 1))
        #expect(vm.isUnitUnlocked(0))
        #expect(!vm.isUnitUnlocked(1))
        #expect(!vm.isFinalTestUnlocked(0), "check is locked until the lessons are done")
    }

    @Test func knowledgeCheckUnlocksWhenAllLessonsComplete() {
        var u = AppUser.newUserDefault
        let units = LessonContentData.units
        u.completedLessonIDs = units[0].lessons.map(\.id)
        u.currentLessonIndex = units[0].lessons.count - 1
        AppState.shared.currentUser = u

        let vm = LearnViewModel()
        #expect(vm.isFinalTestUnlocked(0), "all 5 lessons done -> check unlocks")
        #expect(!vm.isFinalTestPassed(0))
        #expect(!vm.isUnitUnlocked(1), "next unit stays locked until the check is passed")
    }

    @Test func passingTheCheckOpensTheNextUnit() {
        var u = AppUser.newUserDefault
        guard let checkID = LessonContentData.units[0].finalTest?.id else {
            Issue.record("unit 0 has no Knowledge Check")
            return
        }
        u.passedFinalTestIDs = [checkID]
        AppState.shared.currentUser = u

        let vm = LearnViewModel()
        #expect(vm.isFinalTestPassed(0))
        #expect(vm.isUnitUnlocked(1))
    }

    @Test func runningOutOfHeartsFailsTheLesson() {
        AppState.shared.currentUser = AppUser.newUserDefault
        let vm = LearnViewModel()
        let lesson = vm.units[0].lessons[0]
        vm.startLesson(lesson, unitIndex: 0)
        #expect(vm.hearts == Constants.heartsPerLesson)

        for spent in 1...Constants.heartsPerLesson {
            guard let q = vm.currentQuestion else { break }
            _ = vm.submit(wrongResponse(for: q))
            #expect(vm.hearts == Constants.heartsPerLesson - spent)
            if spent < Constants.heartsPerLesson { #expect(!vm.lessonFailed) }
        }
        #expect(vm.lessonFailed, "spending all five hearts fails the lesson")
    }

    @Test func correctAnswerKeepsHeartsAndCountsProgress() {
        AppState.shared.currentUser = AppUser.newUserDefault
        let vm = LearnViewModel()
        let lesson = vm.units[0].lessons[0]
        vm.startLesson(lesson, unitIndex: 0)
        let q = vm.currentQuestion!
        let correct = ContentIntegrityTests.correctResponse(for: q)
        #expect(vm.submit(correct))
        #expect(vm.hearts == Constants.heartsPerLesson, "a right answer costs no heart")
        #expect(vm.correctInLesson == 1)
    }

    private func wrongResponse(for q: Question) -> QuestionResponse {
        switch q.type {
        case .multipleChoice, .trueFalse:
            return .choice(q.choices.first { $0.id != q.correctChoiceID }?.id ?? -1)
        case .multiSelect: return .choiceSet([])
        case .ordering: return .order(Array(q.orderingItems.indices).reversed())
        case .matching: return .matches([:])
        case .numericEntry: return .number((q.numericAnswer ?? 0) + q.numericTolerance + 999)
        case .categorize: return .categorization([:])
        case .interactiveOption:
            return .option(kind: q.optionChallenge?.requiredKind == .call ? .put : .call)
        }
    }
}
