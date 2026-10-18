import Testing
@testable import InvestEd

/// Locks the whole Learn curriculum: structure, unique IDs, and — most
/// importantly — that every one of the 420 lesson questions can be answered
/// correctly with its own declared answer key. If a future content edit
/// breaks an answer key, this suite fails loudly.
struct ContentIntegrityTests {

    /// Builds the response that SHOULD grade as correct for a question.
    static func correctResponse(for q: Question) -> QuestionResponse {
        switch q.type {
        case .multipleChoice, .trueFalse:
            return .choice(q.correctChoiceID)
        case .multiSelect:
            return .choiceSet(Set(q.correctChoiceIDs))
        case .ordering:
            return .order(Array(q.orderingItems.indices))
        case .matching:
            var m: [Int: Int] = [:]
            for p in q.matchPairs { m[p.id] = p.id }
            return .matches(m)
        case .numericEntry:
            return .number(q.numericAnswer ?? .nan)
        case .categorize:
            var m: [Int: String] = [:]
            for it in q.categoryItems { m[it.id] = it.correctCategory }
            return .categorization(m)
        case .interactiveOption:
            return .option(kind: q.optionChallenge?.requiredKind ?? .call)
        }
    }

    private var allQuestions: [Question] {
        LessonContentData.units.flatMap { unit in
            unit.lessons.flatMap(\.questions) + (unit.finalTest?.questions ?? [])
        }
    }

    @Test func hasTwelveUnits() {
        #expect(LessonContentData.units.count == 12)
    }

    @Test func everyUnitHasFiveLessonsOfSevenQuestions() {
        for unit in LessonContentData.units {
            #expect(unit.lessons.count == 5, "\(unit.id) should have 5 lessons")
            for lesson in unit.lessons {
                #expect(lesson.questions.count == 7, "\(lesson.id) should have 7 questions")
            }
        }
    }

    @Test func everyUnitHasA15QuestionKnowledgeCheck() {
        for unit in LessonContentData.units {
            let check = unit.finalTest
            #expect(check != nil, "\(unit.id) is missing its Knowledge Check")
            #expect(check?.questions.count == 15, "\(unit.id) check should have 15 questions")
            #expect(check?.isFinalTest == true, "\(unit.id) check should be flagged isFinalTest")
        }
    }

    @Test func allLessonAndQuestionIDsAreUnique() {
        var lessonIDs = Set<String>()
        var questionIDs = Set<String>()
        for unit in LessonContentData.units {
            for lesson in unit.lessons + [unit.finalTest].compactMap({ $0 }) {
                #expect(lessonIDs.insert(lesson.id).inserted, "duplicate lesson id \(lesson.id)")
                for q in lesson.questions {
                    #expect(questionIDs.insert(q.id).inserted, "duplicate question id \(q.id)")
                }
            }
        }
    }

    /// THE big one: every question grades its own answer key as correct.
    @Test func everyQuestionGradesItsCorrectAnswerAsCorrect() {
        for q in allQuestions {
            let response = Self.correctResponse(for: q)
            #expect(q.isCorrect(response), "answer key for \(q.id) does not grade as correct")
        }
    }

    /// Per-type structural sanity that mirrors the JSON generator's checks,
    /// but at the compiled-Swift level (catches codegen or manual-edit drift).
    @Test func everyQuestionIsStructurallyValid() {
        for q in allQuestions {
            #expect(!q.explanation.isEmpty, "\(q.id) has no explanation")
            switch q.type {
            case .multipleChoice, .trueFalse:
                #expect(q.choices.contains { $0.id == q.correctChoiceID }, "\(q.id) correct id not in choices")
            case .multiSelect:
                #expect(!q.correctChoiceIDs.isEmpty, "\(q.id) has no correct ids")
                let ids = Set(q.choices.map(\.id))
                #expect(q.correctChoiceIDs.allSatisfy { ids.contains($0) }, "\(q.id) correct id out of range")
            case .ordering:
                #expect(q.orderingItems.count >= 2, "\(q.id) needs >= 2 ordering items")
            case .matching:
                #expect(q.matchPairs.count >= 2, "\(q.id) needs >= 2 match pairs")
            case .numericEntry:
                #expect(q.numericAnswer != nil, "\(q.id) missing numeric answer")
            case .categorize:
                let cats = Set(q.categories)
                #expect(cats.count >= 2, "\(q.id) needs >= 2 categories")
                #expect(q.categoryItems.allSatisfy { cats.contains($0.correctCategory) },
                        "\(q.id) has an item whose category isn't listed")
            case .interactiveOption:
                #expect(q.optionChallenge != nil, "\(q.id) missing option challenge")
            }
        }
    }

    /// A wrong answer must NOT grade as correct (spot-checked per type where a
    /// distinct wrong answer is well-defined).
    @Test func wrongAnswersAreRejected() {
        for q in allQuestions {
            switch q.type {
            case .multipleChoice, .trueFalse:
                if let other = q.choices.first(where: { $0.id != q.correctChoiceID }) {
                    #expect(!q.isCorrect(.choice(other.id)), "\(q.id) accepted a wrong choice")
                }
            case .numericEntry:
                if let a = q.numericAnswer {
                    #expect(!q.isCorrect(.number(a + q.numericTolerance + 1)),
                            "\(q.id) accepted an out-of-tolerance number")
                }
            case .multiSelect:
                #expect(!q.isCorrect(.choiceSet([])), "\(q.id) accepted an empty multi-select")
            case .interactiveOption:
                if let kind = q.optionChallenge?.requiredKind {
                    let wrong: OptionKind = kind == .call ? .put : .call
                    #expect(!q.isCorrect(.option(kind: wrong)), "\(q.id) accepted the wrong instrument")
                }
            default:
                break
            }
        }
    }
}
