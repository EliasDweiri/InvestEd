import Foundation
import Combine
import SwiftUI

enum PlacementStage {
    case intro, test, result
}

/// The adaptive placement test that decides where a new learner starts.
///
/// How it adapts (a simple computerized-adaptive-testing loop):
///   1. Start at intermediate difficulty.
///   2. Correct answer -> score += that question's difficulty (1-3 points)
///      and the next question is one level harder.
///      Wrong answer or "I'm not sure" -> next question is one level easier.
///   3. After 10 questions, the total score maps to a starting unit.
/// Because harder questions are worth more AND are only reached by answering
/// correctly, the score reflects the level a learner can sustain, not just how
/// many they got right. The score is never shown — only where they land — so
/// the test feels like a warm-up, not an exam.
@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var stage: PlacementStage = .intro
    @Published var currentQuestion: PlacementQuestion?
    @Published var questionsAnswered = 0
    @Published var placementResultUnitIndex: Int = 0

    // Intentionally NOT @Published / not exposed anywhere — the whole point
    // is that the user is never shown their score, only where they land.
    private var currentDifficulty: DifficultyLevel = .intermediate
    private var score = 0
    private var askedQuestionIDs: Set<String> = []
    private let totalQuestions = 10

    func startPlacementTest() {
        stage = .test
        currentDifficulty = .intermediate
        score = 0
        questionsAnswered = 0
        askedQuestionIDs = []
        currentQuestion = nextQuestion()
    }

    private func nextQuestion() -> PlacementQuestion? {
        let pool = PlacementQuestionData.all.filter {
            $0.difficulty == currentDifficulty && !askedQuestionIDs.contains($0.id)
        }
        let fallbackPool = PlacementQuestionData.all.filter { !askedQuestionIDs.contains($0.id) }
        guard var question = pool.randomElement() ?? fallbackPool.randomElement() else { return nil }
        askedQuestionIDs.insert(question.id)
        // Shuffle multiple-choice answers so the right one isn't always in
        // the same spot. True/False keeps its natural order. Grading uses
        // choice IDs, so order doesn't matter.
        if question.choices.count > 2 { question.choices.shuffle() }
        return question
    }

    /// Pass nil for "I'm not sure / skip" — treated like a wrong answer for
    /// difficulty adjustment, but never penalized beyond that. This is what
    /// lets someone pass on questions they don't know.
    func answer(choiceID: Int?) {
        guard let question = currentQuestion else { return }
        questionsAnswered += 1

        if let choiceID, choiceID == question.correctChoiceID {
            score += question.difficulty.rawValue
            currentDifficulty = DifficultyLevel(rawValue: min(currentDifficulty.rawValue + 1, 3)) ?? .advanced
        } else {
            currentDifficulty = DifficultyLevel(rawValue: max(currentDifficulty.rawValue - 1, 1)) ?? .beginner
        }

        if questionsAnswered >= totalQuestions {
            finishPlacementTest()
        } else {
            currentQuestion = nextQuestion()
        }
    }

    private func finishPlacementTest() {
        switch score {
        case ..<12: placementResultUnitIndex = 0
        case 12..<20: placementResultUnitIndex = 1
        default: placementResultUnitIndex = 2
        }
        placementResultUnitIndex = min(placementResultUnitIndex, LessonContentData.units.count - 1)
        stage = .result
    }

    /// Called when the user taps "Start Learning" on the result screen.
    /// The score itself is discarded here — only the resulting starting
    /// unit is ever saved.
    func finalizePlacement() {
        guard var user = AppState.shared.currentUser else { return }
        // A first placement sets the starting unit. A retake (from Settings)
        // only ever moves a learner forward, never back past finished work.
        let isFirstPlacement = user.completedLessonIDs.isEmpty
        if isFirstPlacement || placementResultUnitIndex > user.currentUnitIndex {
            user.currentUnitIndex = placementResultUnitIndex
            user.currentLessonIndex = 0
        }
        user.hasCompletedPlacement = true
        AppState.shared.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }
}
