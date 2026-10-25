import SwiftUI

/// InvestEd's cast of money-animal mascots. Each learning unit has its own
/// guide whose symbolism connects the animal to the money idea: the bull and
/// bear ARE the market, the clever fox handles credit, the tortoise wins the
/// compounding race, the squirrel stockpiles acorns like a fund, and so on.
/// All artwork is generated flat-vector PNG in Assets.xcassets — no emojis.
struct Mascot: Identifiable, Equatable {
    let key: String          // stable id, also the avatar key stored on users
    let imageName: String    // asset catalog image
    let name: String
    let blurb: String

    var id: String { key }
}

enum Mascots {
    static let pig      = Mascot(key: "pig",      imageName: "MascotPig",      name: "Penny",   blurb: "Your piggy-bank guide to money basics")
    static let beaver   = Mascot(key: "beaver",   imageName: "MascotBeaver",   name: "Chip",    blurb: "Hard worker who knows every paycheck line")
    static let fox      = Mascot(key: "fox",      imageName: "MascotFox",      name: "Felix",   blurb: "Clever with credit and hard to outfox")
    static let turtle   = Mascot(key: "turtle",   imageName: "MascotTurtle",   name: "Shelley", blurb: "Slow and steady, letting compounding do the work")
    static let owl      = Mascot(key: "owl",      imageName: "MascotOwl",      name: "Sage",    blurb: "The wise investor who studies before buying")
    static let bull     = Mascot(key: "bull",     imageName: "MascotBull",     name: "Toro",    blurb: "Charges upward, like a rising market")
    static let squirrel = Mascot(key: "squirrel", imageName: "MascotSquirrel", name: "Hazel",   blurb: "Stockpiles acorns the way funds hold stocks")
    static let elephant = Mascot(key: "elephant", imageName: "MascotElephant", name: "Econ",    blurb: "Big-picture thinker who never forgets a cycle")
    static let bear     = Mascot(key: "bear",     imageName: "MascotBear",     name: "Bearry",  blurb: "Teaches you to stay calm in a bear market")
    static let raccoon  = Mascot(key: "raccoon",  imageName: "MascotRaccoon",  name: "Rocky",   blurb: "Curious night owl of the crypto world")
    static let octopus  = Mascot(key: "octopus",  imageName: "MascotOctopus",  name: "Otto",    blurb: "Eight arms, all of them crunching numbers")
    static let whale    = Mascot(key: "whale",    imageName: "MascotWhale",    name: "Moby",    blurb: "The market whale who runs the shop")
    static let panda    = Mascot(key: "panda",    imageName: "MascotPanda",    name: "Bamboo",  blurb: "Perfectly balanced, like a good portfolio")

    static let all: [Mascot] = [pig, beaver, fox, turtle, owl, bull, squirrel,
                                elephant, bear, raccoon, octopus, whale, panda]

    /// Which mascot guides each learning unit.
    private static let unitGuides: [String: Mascot] = [
        "unit1": pig,        // Money Basics
        "unit7": beaver,     // Paychecks & Taxes
        "unit4": fox,        // Credit & Debt
        "unit5": turtle,     // The Power of Time
        "unit2": owl,        // Investing Foundations
        "unit3": bull,       // The Stock Market
        "unit6": squirrel,   // Funds & Fees
        "unit10": elephant,  // Macro Economics I (the big picture & the cycle)
        "unit12": whale,     // Macro Economics II (policy, trade & the world)
        "unit8": bear,       // Investor Psychology
        "unit9": raccoon,    // Crypto & Digital Assets
        "unit11": octopus    // Quant Corner
    ]

    static func guide(forUnit unitID: String) -> Mascot {
        unitGuides[unitID] ?? pig
    }

    /// Accounts created before mascot art stored emoji avatars — map those
    /// old values (and current keys) to an asset name, falling back to Penny.
    private static let legacyEmojiKeys: [String: String] = [
        "🐷": "pig", "🦊": "fox", "🐻": "bear", "🐢": "turtle", "🦉": "owl",
        "🐼": "panda", "🐂": "bull", "🐋": "whale", "🐿️": "squirrel",
        "🦁": "bear", "🐸": "turtle", "🐵": "raccoon", "🤑": "pig",
        "🚀": "octopus", "💰": "whale", "📈": "bull", "🪙": "pig",
        "🐣": "panda", "🦄": "octopus"
    ]

    static func mascot(forAvatarKey key: String) -> Mascot {
        let resolved = legacyEmojiKeys[key] ?? key
        return all.first { $0.key == resolved } ?? pig
    }

    static func imageName(forAvatarKey key: String) -> String {
        mascot(forAvatarKey: key).imageName
    }
}

/// A small round mascot portrait — used for friend rows, league standings,
/// and anywhere a character face is needed at a glance.
struct MascotBubble: View {
    let avatarKey: String
    var size: CGFloat = 34

    var body: some View {
        Image(Mascots.imageName(forAvatarKey: avatarKey))
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

/// The gold coin — InvestEd's in-app currency mark (Penny's snout-coin).
struct GoldCoinIcon: View {
    var size: CGFloat = 16

    var body: some View {
        SnoutCoinMark(size: size)
    }
}
