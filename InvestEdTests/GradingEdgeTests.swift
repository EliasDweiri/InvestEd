import Testing
@testable import InvestEd

/// Targeted rules for `Question.isCorrect` on hand-built questions — the exact
/// grading behavior each interactive type promises.
struct GradingEdgeTests {

    @Test func multiSelectRequiresTheExactSet() {
        let q = Question.multiSelect(id: "t", prompt: "p",
            choices: [AnswerChoice(id: 0, text: "a"), AnswerChoice(id: 1, text: "b"), AnswerChoice(id: 2, text: "c")],
            correctIDs: [0, 2], explanation: "e")
        #expect(q.isCorrect(.choiceSet([0, 2])))
        #expect(!q.isCorrect(.choiceSet([0])), "a subset is wrong")
        #expect(!q.isCorrect(.choiceSet([0, 1, 2])), "a superset is wrong")
    }

    @Test func orderingRequiresTheExactOrder() {
        let q = Question.ordering(id: "t", prompt: "p", items: ["first", "second", "third"], explanation: "e")
        #expect(q.isCorrect(.order([0, 1, 2])))
        #expect(!q.isCorrect(.order([1, 0, 2])))
        #expect(!q.isCorrect(.order([0, 1])), "an incomplete order is wrong")
    }

    @Test func matchingRequiresEveryPair() {
        let q = Question.matching(id: "t", prompt: "p",
            pairs: [MatchPair(id: 0, left: "a", right: "A"), MatchPair(id: 1, left: "b", right: "B")],
            explanation: "e")
        #expect(q.isCorrect(.matches([0: 0, 1: 1])))
        #expect(!q.isCorrect(.matches([0: 1, 1: 0])), "swapped matches are wrong")
        #expect(!q.isCorrect(.matches([0: 0])), "a partial map is wrong")
    }

    @Test func matchingAcceptsEitherIdenticalAnswer() {
        // Two items share the answer "Need": either "Need" chip is right.
        let q = Question.matching(id: "t", prompt: "p",
            pairs: [MatchPair(id: 0, left: "Medicine", right: "Need"),
                    MatchPair(id: 1, left: "Concert", right: "Want"),
                    MatchPair(id: 2, left: "Coat", right: "Need")],
            explanation: "e")
        #expect(q.isCorrect(.matches([0: 2, 1: 1, 2: 0])))
        #expect(!q.isCorrect(.matches([0: 1, 1: 0, 2: 2])))
    }

    @Test func numericHonorsTolerance() {
        let q = Question.numeric(id: "t", prompt: "p", answer: 100, tolerance: 2, explanation: "e")
        #expect(q.isCorrect(.number(100)))
        #expect(q.isCorrect(.number(102)))
        #expect(q.isCorrect(.number(98)))
        #expect(!q.isCorrect(.number(103)))
        #expect(!q.isCorrect(.number(97)))
    }

    @Test func categorizeRequiresAllItemsCorrect() {
        let q = Question.categorize(id: "t", prompt: "p", categories: ["X", "Y"],
            items: [CategoryItem(id: 0, text: "a", correctCategory: "X"),
                    CategoryItem(id: 1, text: "b", correctCategory: "Y")],
            explanation: "e")
        #expect(q.isCorrect(.categorization([0: "X", 1: "Y"])))
        #expect(!q.isCorrect(.categorization([0: "X", 1: "X"])), "one wrong bucket fails the whole thing")
        #expect(!q.isCorrect(.categorization([0: "X"])), "a partial sort is wrong")
    }

    @Test func trueFalseFactoryKeysCorrectly() {
        let t = Question.trueFalse(id: "t", prompt: "p", correctIsTrue: true, explanation: "e")
        #expect(t.isCorrect(.choice(0)))   // index 0 = "True"
        #expect(!t.isCorrect(.choice(1)))
        let f = Question.trueFalse(id: "f", prompt: "p", correctIsTrue: false, explanation: "e")
        #expect(f.isCorrect(.choice(1)))
        #expect(!f.isCorrect(.choice(0)))
    }

    @Test func interactiveOptionGradesOnInstrument() {
        let bullish = Question.interactiveOption(id: "t", prompt: "p",
            challenge: OptionChallenge(symbol: "X", companyName: "X Co", spot: 100,
                scenario: "up", requiredKind: .call, targetPrice: 120, successNote: "n"),
            explanation: "e")
        #expect(bullish.isCorrect(.option(kind: .call)))
        #expect(!bullish.isCorrect(.option(kind: .put)))
    }

    @Test func mismatchedResponseTypeIsRejected() {
        let mc = Question.multipleChoice(id: "t", prompt: "p",
            choices: [AnswerChoice(id: 0, text: "a"), AnswerChoice(id: 1, text: "b")],
            correct: 0, explanation: "e")
        #expect(!mc.isCorrect(.number(0)))
        #expect(!mc.isCorrect(.order([0])))
    }
}
