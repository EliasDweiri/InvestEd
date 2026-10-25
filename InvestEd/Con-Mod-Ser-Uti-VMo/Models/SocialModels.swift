import Foundation

enum FriendRequestStatus: String, Codable {
    case pending, accepted, declined
}

struct FriendRequest: Identifiable, Codable, Equatable {
    var id: String
    var fromUserID: String
    var fromUsername: String
    var toUserID: String
    var status: FriendRequestStatus
    var dateSent: Date
}

/// A lightweight, public-facing view of a friend — only what's safe/useful
/// to show other users (never email, cash balance, etc.)
struct FriendProfile: Identifiable, Codable, Equatable {
    var id: String
    var username: String
    var avatarEmoji: String
    var xp: Int
    var streak: Int
    var weeklyXP: Int? = nil

    var level: Int { xp / 100 + 1 }
}

// MARK: - Leagues

/// Weekly XP leagues — the coin ladder. Everyone starts each week as a
/// Penny (like our mascot!) and climbs toward Fortune by earning XP in
/// lessons. The tier is derived purely from this week's XP, so there's
/// nothing extra to sync.
enum LeagueTier: Int, CaseIterable, Comparable {
    case penny = 0, nickel, dime, quarter, silverDollar, fortune

    static func < (lhs: LeagueTier, rhs: LeagueTier) -> Bool { lhs.rawValue < rhs.rawValue }

    static func tier(forWeeklyXP xp: Int) -> LeagueTier {
        switch xp {
        case ..<30: return .penny
        case ..<80: return .nickel
        case ..<160: return .dime
        case ..<300: return .quarter
        case ..<500: return .silverDollar
        default: return .fortune
        }
    }

    var name: String {
        switch self {
        case .penny: return "Penny League"
        case .nickel: return "Nickel League"
        case .dime: return "Dime League"
        case .quarter: return "Quarter League"
        case .silverDollar: return "Silver Dollar League"
        case .fortune: return "Fortune League"
        }
    }

    var colorHex: String {
        switch self {
        case .penny: return "B87333"
        case .nickel: return "8E9AA6"
        case .dime: return "74A7C4"
        case .quarter: return "1F5F7A"
        case .silverDollar: return "A3A9AE"
        case .fortune: return "D49A1E"
        }
    }

    /// The coin's face value, printed on the league badge.
    var faceValue: String? {
        switch self {
        case .penny: return "1¢"
        case .nickel: return "5¢"
        case .dime: return "10¢"
        case .quarter: return "25¢"
        case .silverDollar: return "$1"
        case .fortune: return nil
        }
    }

    var iconName: String {
        switch self {
        case .penny, .nickel, .dime: return "centsign.circle.fill"
        case .quarter, .silverDollar: return "dollarsign.circle.fill"
        case .fortune: return "crown.fill"
        }
    }

    /// Weekly XP needed to reach the NEXT tier, nil at the top.
    var nextTierXP: Int? {
        switch self {
        case .penny: return 30
        case .nickel: return 80
        case .dime: return 160
        case .quarter: return 300
        case .silverDollar: return 500
        case .fortune: return nil
        }
    }

    /// Weekly XP where this tier begins.
    var minXP: Int {
        switch self {
        case .penny: return 0
        case .nickel: return 30
        case .dime: return 80
        case .quarter: return 160
        case .silverDollar: return 300
        case .fortune: return 500
        }
    }
}
