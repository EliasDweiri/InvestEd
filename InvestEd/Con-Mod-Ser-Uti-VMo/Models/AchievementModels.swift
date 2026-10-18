import Foundation

/// Achievements are computed straight from the user document — nothing
/// extra to store or sync. Each one knows how to check itself.
struct Achievement: Identifiable {
    let id: String
    let title: String
    let caption: String
    let icon: String
    let colorHex: String
    let isUnlocked: (AppUser) -> Bool

    static let all: [Achievement] = [
        Achievement(id: "firstLesson", title: "First Steps", caption: "Complete your first lesson", icon: "figure.walk", colorHex: "00C896") { !$0.completedLessonIDs.isEmpty },
        Achievement(id: "bookworm", title: "Bookworm", caption: "Complete 10 lessons", icon: "books.vertical.fill", colorHex: "4361EE") { $0.completedLessonIDs.count >= 10 },
        Achievement(id: "scholar", title: "Scholar", caption: "Complete every lesson", icon: "graduationcap.fill", colorHex: "9B5DE5") { user in
            user.completedLessonIDs.count >= LessonContentData.units.reduce(0) { $0 + $1.lessons.count }
        },
        Achievement(id: "weekWarrior", title: "Week Warrior", caption: "Reach a 7-day streak", icon: "flame.fill", colorHex: "FF6B4A") { $0.streak >= 7 },
        Achievement(id: "monthMaster", title: "Month Master", caption: "Reach a 30-day streak", icon: "calendar", colorHex: "F15BB5") { $0.streak >= 30 },
        Achievement(id: "firstTrade", title: "Opening Bell", caption: "Make your first practice trade", icon: "bell.fill", colorHex: "FFC93C") { !$0.transactions.isEmpty },
        Achievement(id: "diversified", title: "Diversified", caption: "Hold 3 different stocks", icon: "square.grid.2x2.fill", colorHex: "00B4D8") { $0.holdings.count >= 3 },
        Achievement(id: "highRoller", title: "In the Green", caption: "Grow your portfolio past $10,500", icon: "chart.line.uptrend.xyaxis", colorHex: "00C896") { user in
            let holdingsValue = user.holdings.reduce(0.0) { $0 + $1.shares * $1.averageCost }
            return user.cashBalance + holdingsValue > 10_500
        },
        Achievement(id: "levelFive", title: "Level 5", caption: "Reach level 5", icon: "star.fill", colorHex: "FFC93C") { $0.level >= 5 },
        Achievement(id: "social", title: "Money Buddies", caption: "Add your first friend", icon: "person.2.fill", colorHex: "FF6B4A") { !$0.friendIDs.isEmpty },
    ]

    /// The rotating monthly badge: earned by doing at least one lesson in
    /// the current calendar month.
    static func monthlyBadgeEarned(by user: AppUser) -> Bool {
        guard let last = user.lastLessonDate else { return false }
        return Calendar.current.isDate(last, equalTo: Date(), toGranularity: .month)
    }

    static var currentMonthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter.string(from: Date())
    }
}
