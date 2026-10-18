import Foundation

/// A buildable avatar: pick a character, a backdrop color, and up to two
/// money-flavored extras (hat + accessory). Stored on the user document so
/// friends see your look everywhere.
struct AvatarConfig: Codable, Equatable {
    // Named baseEmoji for Firestore backward compatibility, but it now holds
    // a mascot key ("pig", "fox", ...). Old emoji values still decode fine —
    // Mascots.mascot(forAvatarKey:) maps them to the right artwork.
    var baseEmoji: String = "pig"
    var backgroundHex: String = "00C896"
    var hat: String? = nil          // SF Symbol name, worn up top
    var accessory: String? = nil    // SF Symbol name, badge at the side

    static let baseOptions = ["pig", "fox", "bear", "bull", "turtle", "owl",
                              "squirrel", "elephant", "raccoon", "octopus",
                              "whale", "beaver", "panda"]
    static let backgroundOptions = ["00C896", "4361EE", "FFC93C", "FF6B4A", "9B5DE5", "F15BB5", "00B4D8", "1B1F3B"]

    /// (symbol, display name) — mostly money-themed, a few just for fun.
    static let hatOptions: [(String, String)] = [
        ("crown.fill", "Crown"),
        ("graduationcap.fill", "Grad Cap"),
        ("dollarsign.circle.fill", "Coin Halo"),
        ("star.fill", "Star"),
        ("flame.fill", "Flame"),
        ("sparkles", "Sparkles")
    ]
    static let accessoryOptions: [(String, String)] = [
        ("banknote.fill", "Cash Clip"),
        ("chart.line.uptrend.xyaxis", "Bull Run"),
        ("medal.fill", "Medal"),
        ("creditcard.fill", "Gold Card"),
        ("heart.fill", "Heart"),
        ("bolt.fill", "Bolt")
    ]

    /// Premium items and their price in Gold. Anything not listed is free.
    static let itemPrices: [String: Int] = [
        "crown.fill": 150,
        "dollarsign.circle.fill": 100,
        "sparkles": 75,
        "creditcard.fill": 150,
        "chart.line.uptrend.xyaxis": 100,
        "banknote.fill": 75
    ]

    static func price(of symbol: String) -> Int? { itemPrices[symbol] }
}

/// The single source of truth for one person's InvestEd account.
/// This whole struct is saved as one Firestore document per user, which
/// keeps things simple: profile info, learning progress, and portfolio
/// data all live and sync together.
struct AppUser: Identifiable, Codable, Equatable {
    var id: String                    // Firebase Auth UID
    var username: String
    var email: String
    var avatarEmoji: String
    var xp: Int
    var streak: Int
    var lastLessonDate: Date?
    var currentUnitIndex: Int
    var currentLessonIndex: Int
    var completedLessonIDs: [String]
    var cashBalance: Double
    var holdings: [Holding]
    var transactions: [Transaction]
    var joinDate: Date
    var friendIDs: [String]
    var hasCompletedPlacement: Bool

    // League progress. Optional so accounts created before leagues
    // existed still decode cleanly from Firestore.
    var weeklyXP: Int?
    var weekAnchor: Date?

    // Custom avatar. Optional for the same backward-compat reason.
    var avatar: AvatarConfig?

    // Gold — the in-app currency earned by learning. The stored property is
    // still called `cents` so existing Firestore documents decode unchanged;
    // everything user-facing calls it Gold.
    var cents: Int?
    var unlockedItems: [String]?
    var streakFreezes: Int?

    // Simulated option positions. Optional so accounts created before the
    // Options Playground existed still decode cleanly from Firestore.
    var optionPositions: [OptionPosition]?

    // IDs of the unit final tests the user has passed. Passing a unit's final
    // test is what unlocks the next unit. Optional for backward-compatibility
    // with accounts created before final tests existed.
    var passedFinalTestIDs: [String]?

    var goldBalance: Int { cents ?? 0 }

    mutating func earnGold(_ amount: Int) {
        cents = (cents ?? 0) + amount
    }

    /// Returns true (and deducts) if the balance covers the price.
    mutating func spendGold(_ amount: Int) -> Bool {
        guard goldBalance >= amount else { return false }
        cents = goldBalance - amount
        return true
    }

    /// Simple leveling: every 100 XP is one level.
    var level: Int { xp / 100 + 1 }

    /// The streak as it stands *today*. `streak` is only recalculated when a
    /// lesson is finished, so after missed days it still holds the old number.
    /// If days were missed and there's no Streak Freeze to cover them, the
    /// streak is already over — show 0 instead of a number that's gone.
    var activeStreak: Int {
        guard let last = lastLessonDate else { return 0 }
        let missedDays = last.daysBetween(Date()) - 1
        if missedDays <= 0 { return streak }
        return (streakFreezes ?? 0) > 0 ? streak : 0
    }

    /// XP earned during the current league week. Reads as 0 automatically
    /// once the stored anchor falls in a previous week.
    var currentWeeklyXP: Int {
        guard let anchor = weekAnchor,
              Calendar.current.isDate(anchor, equalTo: Date(), toGranularity: .weekOfYear) else { return 0 }
        return weeklyXP ?? 0
    }

    /// Adds XP to both the lifetime total and the current league week,
    /// rolling the week over if needed.
    mutating func addXP(_ amount: Int) {
        xp += amount
        if let anchor = weekAnchor,
           Calendar.current.isDate(anchor, equalTo: Date(), toGranularity: .weekOfYear) {
            weeklyXP = (weeklyXP ?? 0) + amount
        } else {
            weekAnchor = Date()
            weeklyXP = amount
        }
    }

    static let newUserDefault = AppUser(
        id: "",
        username: "",
        email: "",
        avatarEmoji: "pig",
        xp: 0,
        streak: 0,
        lastLessonDate: nil,
        currentUnitIndex: 0,
        currentLessonIndex: 0,
        completedLessonIDs: [],
        cashBalance: Constants.startingCashBalance,
        holdings: [],
        transactions: [],
        joinDate: Date(),
        friendIDs: [],
        hasCompletedPlacement: false,
        weeklyXP: 0,
        weekAnchor: nil,
        avatar: AvatarConfig(),
        cents: 0,
        unlockedItems: [],
        streakFreezes: 0,
        optionPositions: [],
        passedFinalTestIDs: []
    )
}
