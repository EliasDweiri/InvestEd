import Foundation

#if DEBUG
/// A ready-made signed-in learner used only for local UI verification. It's
/// activated by launching the app with the `-previewSeed` argument (see
/// ContentView), so it never touches Firebase or normal runs. Lessons 1–3 of
/// Unit 1 are marked done, which puts the path in a mixed state: completed
/// stops, a current stop, later stops, and a still-locked final test.
extension AppUser {
    static var debugLearner: AppUser {
        var user = AppUser.newUserDefault
        user.id = "preview-user"
        user.username = "PreviewPenny"
        user.email = "preview@invested.app"
        user.hasCompletedPlacement = true
        user.xp = 240
        user.streak = 4
        user.cents = 180
        user.currentUnitIndex = 0
        user.currentLessonIndex = 3
        user.completedLessonIDs = ["unit1-lesson1", "unit1-lesson2", "unit1-lesson3"]
        return user
    }

    /// Jumps to the Stock Market unit's Options lesson so the interactive
    /// options challenge is the current stop. Activated with `-previewOptions`.
    static var debugOptionsLearner: AppUser {
        var user = AppUser.debugLearner
        user.currentUnitIndex = 5          // Stock Market is the 6th unit on the path
        user.currentLessonIndex = 4        // its 5th lesson (Options Challenge)
        user.completedLessonIDs += ["unit3-lesson1", "unit3-lesson2", "unit3-lesson3", "unit3-lesson4"]
        return user
    }
}
#endif
