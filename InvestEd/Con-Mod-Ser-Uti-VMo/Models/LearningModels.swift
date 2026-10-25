import Foundation

/// Every way a lesson can ask a question. The first two are the classics;
/// the rest are the interactive formats that make InvestEd feel like a game
/// instead of a quiz. Grading for all of them lives in `Question.isCorrect`.
enum QuestionType: String, Codable {
    case multipleChoice     // pick one of several
    case trueFalse          // pick true or false
    case multiSelect        // choose ALL that apply
    case ordering           // arrange steps into the right sequence
    case matching           // connect each term to its match
    case numericEntry       // type or slide to a number (graded with tolerance)
    case categorize         // sort items into the right buckets
    case interactiveOption  // build a real call/put on a stock to fit a scenario
}

struct AnswerChoice: Identifiable, Codable, Equatable {
    var id: Int
    var text: String
}

/// A left↔right pair for `matching` questions. The correct match for a pair
/// is always the right-hand side that shares its `id`.
struct MatchPair: Identifiable, Codable, Equatable, Hashable {
    var id: Int
    var left: String
    var right: String
}

/// One item for `categorize` questions, tagged with the bucket it belongs in.
struct CategoryItem: Identifiable, Codable, Equatable {
    var id: Int
    var text: String
    var correctCategory: String
}

/// The setup for an `interactiveOption` question. The learner builds a call
/// or put — using the same Black-Scholes pricer the Market tab uses — and we
/// grade whether the instrument they chose actually fits the scenario.
struct OptionChallenge: Codable, Equatable {
    var symbol: String
    var companyName: String
    var spot: Double                 // the price the challenge is anchored to
    var scenario: String             // "You're convinced NVDA will jump after earnings."
    var requiredKind: OptionKind     // the correct instrument for that view
    var targetPrice: Double          // the price level the scenario talks about
    var successNote: String          // shown once they get it right
}

/// A single question. The first six fields cover the classic multiple-choice
/// and true/false formats; the rest are optional payloads used only by the
/// interactive types, so existing content keeps compiling untouched.
struct Question: Identifiable, Codable, Equatable {
    var id: String
    var prompt: String
    var type: QuestionType
    var choices: [AnswerChoice]
    var correctChoiceID: Int
    var explanation: String

    // multiSelect — the set of choice IDs that together form the right answer.
    var correctChoiceIDs: [Int] = []
    // ordering — the items in their CORRECT order (the UI shuffles them).
    var orderingItems: [String] = []
    // matching
    var matchPairs: [MatchPair] = []
    // numericEntry
    var numericAnswer: Double? = nil
    var numericTolerance: Double = 0     // ± this much still counts as correct
    var numericPrefix: String? = nil     // "$"
    var numericSuffix: String? = nil     // "%", " yrs"
    var numericMin: Double = 0           // slider lower bound
    var numericMax: Double = 100         // slider upper bound
    var numericStep: Double = 1          // slider granularity
    var useSlider: Bool = false          // slider instead of a keypad
    // categorize
    var categories: [String] = []
    var categoryItems: [CategoryItem] = []
    // interactiveOption
    var optionChallenge: OptionChallenge? = nil
}

// MARK: - Ergonomic builders for the interactive types
//
// These keep the content file readable: a `.ordering` question reads as an
// ordering, not a wall of defaulted fields.

extension Question {
    static func multipleChoice(id: String, prompt: String, choices: [AnswerChoice],
                               correct: Int, explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .multipleChoice, choices: choices,
                 correctChoiceID: correct, explanation: explanation)
    }

    static func trueFalse(id: String, prompt: String, correctIsTrue: Bool,
                          explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .trueFalse,
                 choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                 correctChoiceID: correctIsTrue ? 0 : 1, explanation: explanation)
    }

    static func multiSelect(id: String, prompt: String, choices: [AnswerChoice],
                            correctIDs: [Int], explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .multiSelect, choices: choices,
                 correctChoiceID: correctIDs.first ?? 0, explanation: explanation,
                 correctChoiceIDs: correctIDs)
    }

    /// `items` are given in the correct order; the player shuffles them.
    static func ordering(id: String, prompt: String, items: [String],
                         explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .ordering, choices: [],
                 correctChoiceID: 0, explanation: explanation, orderingItems: items)
    }

    static func matching(id: String, prompt: String, pairs: [MatchPair],
                         explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .matching, choices: [],
                 correctChoiceID: 0, explanation: explanation, matchPairs: pairs)
    }

    static func numeric(id: String, prompt: String, answer: Double, tolerance: Double,
                        prefix: String? = nil, suffix: String? = nil,
                        slider: Bool = false, min: Double = 0, max: Double = 100,
                        step: Double = 1, explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .numericEntry, choices: [],
                 correctChoiceID: 0, explanation: explanation,
                 numericAnswer: answer, numericTolerance: tolerance,
                 numericPrefix: prefix, numericSuffix: suffix,
                 numericMin: min, numericMax: max, numericStep: step, useSlider: slider)
    }

    static func categorize(id: String, prompt: String, categories: [String],
                           items: [CategoryItem], explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .categorize, choices: [],
                 correctChoiceID: 0, explanation: explanation,
                 categories: categories, categoryItems: items)
    }

    static func interactiveOption(id: String, prompt: String, challenge: OptionChallenge,
                                  explanation: String) -> Question {
        Question(id: id, prompt: prompt, type: .interactiveOption, choices: [],
                 correctChoiceID: 0, explanation: explanation, optionChallenge: challenge)
    }
}

// MARK: - Answering & grading

/// The learner's answer to a question — one case per question type. Keeping
/// grading in one place (`Question.isCorrect`) means the UI just has to build
/// the right response and the rules live here.
enum QuestionResponse: Equatable {
    case choice(Int)                 // multipleChoice, trueFalse
    case choiceSet(Set<Int>)         // multiSelect
    case order([Int])                // ordering — original indices in the learner's order
    case matches([Int: Int])         // matching — left pair id → chosen right pair id
    case number(Double)              // numericEntry
    case categorization([Int: String]) // categorize — item id → chosen bucket
    case option(kind: OptionKind)    // interactiveOption — the instrument they built
}

extension Question {
    /// True when the right-hand option chosen for `pair` carries the same
    /// text as the pair's own right side.
    func isMatchCorrect(_ pair: MatchPair, chosenRightID: Int?) -> Bool {
        guard let chosenRightID,
              let chosen = matchPairs.first(where: { $0.id == chosenRightID }) else { return false }
        return chosen.right == pair.right
    }

    func isCorrect(_ response: QuestionResponse) -> Bool {
        switch (type, response) {
        case (.multipleChoice, .choice(let id)), (.trueFalse, .choice(let id)):
            return id == correctChoiceID
        case (.multiSelect, .choiceSet(let picked)):
            return picked == Set(correctChoiceIDs)
        case (.ordering, .order(let indices)):
            return indices == Array(orderingItems.indices)
        case (.matching, .matches(let map)):
            guard map.count == matchPairs.count else { return false }
            // Compare by the right-hand TEXT, not the pair id: when two pairs
            // share an answer (e.g. two items that are both "Need"), either
            // identical chip is correct.
            return matchPairs.allSatisfy { isMatchCorrect($0, chosenRightID: map[$0.id]) }
        case (.numericEntry, .number(let value)):
            guard let answer = numericAnswer else { return false }
            return abs(value - answer) <= numericTolerance + 0.0001
        case (.categorize, .categorization(let map)):
            guard map.count == categoryItems.count else { return false }
            return categoryItems.allSatisfy { map[$0.id] == $0.correctCategory }
        case (.interactiveOption, .option(let kind)):
            return kind == optionChallenge?.requiredKind
        default:
            return false
        }
    }
}

struct Lesson: Identifiable, Codable, Equatable {
    var id: String
    var title: String
    var iconName: String            // SF Symbol name — no image assets needed
    var questions: [Question]
    var xpReward: Int
    /// A final test is the "boss" at the end of a unit: passing it is what
    /// unlocks the next unit. Regular lessons leave this false.
    var isFinalTest: Bool = false
}

struct LearningUnit: Identifiable, Codable, Equatable {
    var id: String
    var title: String
    var subtitle: String
    var colorHex: String
    var lessons: [Lesson]
    /// The unit's final exam. Optional so a unit can exist before its test is
    /// authored, but every shipping unit has one.
    var finalTest: Lesson? = nil
}

// MARK: - Placement test

/// Used to adaptively pick the next placement question: correct answers
/// move you up a tier, wrong/skipped answers move you down a tier.
enum DifficultyLevel: Int, Codable, Comparable {
    case beginner = 1
    case intermediate = 2
    case advanced = 3

    static func < (lhs: DifficultyLevel, rhs: DifficultyLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

struct PlacementQuestion: Identifiable, Codable, Equatable {
    var id: String
    var prompt: String
    var choices: [AnswerChoice]
    var correctChoiceID: Int
    var difficulty: DifficultyLevel
}
