import Foundation
import Combine
import SwiftUI

/// The lesson engine behind the Learn tab.
///
/// Responsibilities:
///   • Gating — which units, lessons and Knowledge Checks are unlocked. A unit
///     opens when the previous unit's Knowledge Check is passed; lessons open
///     in order; a Knowledge Check opens once every lesson in its unit is done.
///   • Play — serving questions, grading any of the 8 question types through
///     `Question.isCorrect`, and spending a heart on each miss (5 per lesson).
///   • Rewards — XP (+bonus for a perfect run), Gold, and the daily streak,
///     including Streak Freezes that absorb a missed day.
///
/// Gating rules are covered by `LearnGatingTests`; grading by `GradingEdgeTests`.
@MainActor
final class LearnViewModel: ObservableObject {
    @Published var units: [LearningUnit] = LessonContentData.units
    @Published var activeLesson: Lesson?
    @Published var activeUnitIndex = 0
    @Published var activeIsFinalTest = false
    @Published var currentQuestionIndex = 0
    @Published var hearts = Constants.heartsPerLesson
    @Published var correctInLesson = 0
    @Published var showLessonComplete = false
    @Published var lessonFailed = false
    @Published var lastEarnedXP = 0
    @Published var lastEarnedGold = 0
    @Published var streakFreezeUsed = false

    private var appState: AppState { AppState.shared }

    // MARK: - Unlock & gating

    /// A unit opens once the *previous* unit's final test is passed (unit 0 is
    /// always open, and the placement test can start a user further along).
    func isUnitUnlocked(_ unitIndex: Int) -> Bool {
        if unitIndex == 0 { return true }
        guard let user = appState.currentUser else { return false }
        if unitIndex <= user.currentUnitIndex { return true }
        return isFinalTestPassed(unitIndex - 1)
    }

    func isLessonUnlocked(unitIndex: Int, lessonIndex: Int) -> Bool {
        guard let user = appState.currentUser else { return unitIndex == 0 && lessonIndex == 0 }
        if unitIndex < user.currentUnitIndex { return true }
        if unitIndex == user.currentUnitIndex && lessonIndex <= user.currentLessonIndex { return true }
        return false
    }

    func isLessonCompleted(_ lesson: Lesson) -> Bool {
        appState.currentUser?.completedLessonIDs.contains(lesson.id) ?? false
    }

    /// The final test unlocks only after every regular lesson in the unit is done.
    func isFinalTestUnlocked(_ unitIndex: Int) -> Bool {
        guard units.indices.contains(unitIndex),
              units[unitIndex].finalTest != nil,
              !units[unitIndex].lessons.isEmpty else { return false }
        return units[unitIndex].lessons.allSatisfy { isLessonCompleted($0) }
    }

    func isFinalTestPassed(_ unitIndex: Int) -> Bool {
        guard units.indices.contains(unitIndex), let test = units[unitIndex].finalTest else { return false }
        return appState.currentUser?.passedFinalTestIDs?.contains(test.id) ?? false
    }

    // MARK: - Playing a lesson or final test

    func startLesson(_ lesson: Lesson, unitIndex: Int) {
        activeLesson = lesson
        activeUnitIndex = unitIndex
        activeIsFinalTest = false
        resetPlay()
    }

    func startFinalTest(unitIndex: Int) {
        guard units.indices.contains(unitIndex), let test = units[unitIndex].finalTest else { return }
        activeUnitIndex = unitIndex
        activeIsFinalTest = true
        resetPlay()
        activeLesson = test
    }

    /// Gold cost to refill hearts and keep your place (a soft-currency sink —
    /// never a real-money "pay to continue", which App Review frowns on in a
    /// teen app).
    let heartRefillCost = 50

    var canAffordHeartRefill: Bool {
        (appState.currentUser?.goldBalance ?? 0) >= heartRefillCost
    }

    /// Spends Gold to refill hearts and RESUME at the current question (unlike
    /// `retry`, which starts the whole lesson over). Returns false if broke.
    func refillHearts() -> Bool {
        guard var user = appState.currentUser, user.spendGold(heartRefillCost) else { return false }
        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
        hearts = Constants.heartsPerLesson
        lessonFailed = false
        return true
    }

    /// Restart the current lesson/test from the top (used after running out of hearts).
    func retry() {
        let wasFinal = activeIsFinalTest
        let lesson = activeLesson
        resetPlay()
        activeLesson = lesson
        activeIsFinalTest = wasFinal
    }

    private func resetPlay() {
        currentQuestionIndex = 0
        hearts = Constants.heartsPerLesson
        correctInLesson = 0
        showLessonComplete = false
        lessonFailed = false
    }

    var currentQuestion: Question? {
        guard let lesson = activeLesson, currentQuestionIndex < lesson.questions.count else { return nil }
        return lesson.questions[currentQuestionIndex]
    }

    /// Grades a response, spends a heart on a miss, and reports correctness.
    func submit(_ response: QuestionResponse) -> Bool {
        guard let question = currentQuestion else { return false }
        let correct = question.isCorrect(response)
        if correct {
            correctInLesson += 1
        } else {
            hearts = max(hearts - 1, 0)
            if hearts == 0 { lessonFailed = true }
        }
        return correct
    }

    /// Move to the next question, or finish the lesson. A failed run (out of
    /// hearts) doesn't advance — the player shows the retry screen instead.
    func advance() {
        guard let lesson = activeLesson, !lessonFailed else { return }
        if currentQuestionIndex < lesson.questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            complete()
        }
    }

    private func complete() {
        guard let lesson = activeLesson, var user = appState.currentUser else { return }
        let total = lesson.questions.count
        let perfect = correctInLesson == total && total > 0

        var earnedXP = lesson.xpReward
        if perfect { earnedXP += Constants.xpPerPerfectLessonBonus }
        user.addXP(earnedXP)
        lastEarnedXP = earnedXP

        let earnedGold = (activeIsFinalTest ? 25 : 10) + (perfect ? 5 : 0)
        user.earnGold(earnedGold)
        lastEarnedGold = earnedGold

        updateStreak(user: &user)

        if activeIsFinalTest {
            var passed = user.passedFinalTestIDs ?? []
            if !passed.contains(lesson.id) { passed.append(lesson.id) }
            user.passedFinalTestIDs = passed
            // Passing the final test is what opens the next unit.
            if user.currentUnitIndex == activeUnitIndex && activeUnitIndex < units.count - 1 {
                user.currentUnitIndex = activeUnitIndex + 1
                user.currentLessonIndex = 0
            }
        } else {
            if !user.completedLessonIDs.contains(lesson.id) {
                user.completedLessonIDs.append(lesson.id)
            }
            // Advance within the unit, but never past the last lesson — the
            // final test is the gate to the next unit.
            if user.currentUnitIndex == activeUnitIndex,
               let lessonIndex = units[activeUnitIndex].lessons.firstIndex(where: { $0.id == lesson.id }) {
                let lastIndex = units[activeUnitIndex].lessons.count - 1
                user.currentLessonIndex = min(max(user.currentLessonIndex, lessonIndex + 1), lastIndex)
            }
        }

        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
        showLessonComplete = true
    }

    private func updateStreak(user: inout AppUser) {
        let today = Date()
        streakFreezeUsed = false
        if let last = user.lastLessonDate {
            let days = last.daysBetween(today)
            if days == 1 {
                user.streak += 1
            } else if days > 1 {
                // A Streak Freeze quietly absorbs the missed day(s) —
                // the streak survives and even continues.
                if (user.streakFreezes ?? 0) > 0 {
                    user.streakFreezes = (user.streakFreezes ?? 0) - 1
                    user.streak += 1
                    streakFreezeUsed = true
                } else {
                    user.streak = 1
                }
            }
            // if days == 0, a lesson was already logged today — streak unchanged
        } else {
            user.streak = 1
        }
        user.lastLessonDate = today
    }
}
