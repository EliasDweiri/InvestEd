import Foundation

/// The question bank for the placement test users take before their first
/// lesson. The test is adaptive (see OnboardingViewModel, coming in Step 5):
/// correct answers move to a harder question, wrong or skipped answers
/// move to an easier one. The resulting score is never shown to the user —
/// it's only used to pick where on the Learn path they start.
enum PlacementQuestionData {
    static let all: [PlacementQuestion] = [
        // MARK: Beginner
        PlacementQuestion(id: "p1", prompt: "What is a budget?",
                           choices: [
                            AnswerChoice(id: 0, text: "A plan for spending and saving your money"),
                            AnswerChoice(id: 1, text: "A type of loan"),
                            AnswerChoice(id: 2, text: "A stock exchange"),
                            AnswerChoice(id: 3, text: "A tax form")
                           ], correctChoiceID: 0, difficulty: .beginner),
        PlacementQuestion(id: "p2", prompt: "True or False: Saving money means spending less than you earn.",
                           choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                           correctChoiceID: 0, difficulty: .beginner),
        PlacementQuestion(id: "p3", prompt: "What is an emergency fund used for?",
                           choices: [
                            AnswerChoice(id: 0, text: "Unexpected expenses"),
                            AnswerChoice(id: 1, text: "Buying luxury items"),
                            AnswerChoice(id: 2, text: "Daily groceries"),
                            AnswerChoice(id: 3, text: "Paying taxes early")
                           ], correctChoiceID: 0, difficulty: .beginner),
        PlacementQuestion(id: "p4", prompt: "Which of these is a \"need\" rather than a \"want\"?",
                           choices: [
                            AnswerChoice(id: 0, text: "Groceries"),
                            AnswerChoice(id: 1, text: "Video games"),
                            AnswerChoice(id: 2, text: "Designer bags"),
                            AnswerChoice(id: 3, text: "Concert tickets")
                           ], correctChoiceID: 0, difficulty: .beginner),
        PlacementQuestion(id: "p5", prompt: "True or False: A savings account is the same thing as a stock.",
                           choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                           correctChoiceID: 1, difficulty: .beginner),

        // MARK: Intermediate
        PlacementQuestion(id: "p6", prompt: "What does it mean to own a share of stock?",
                           choices: [
                            AnswerChoice(id: 0, text: "You own a small piece of that company"),
                            AnswerChoice(id: 1, text: "You've given the company a loan"),
                            AnswerChoice(id: 2, text: "You are guaranteed a job there"),
                            AnswerChoice(id: 3, text: "You control its day-to-day operations")
                           ], correctChoiceID: 0, difficulty: .intermediate),
        PlacementQuestion(id: "p7", prompt: "True or False: Diversification helps reduce investment risk.",
                           choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                           correctChoiceID: 0, difficulty: .intermediate),
        PlacementQuestion(id: "p8", prompt: "What is compound interest?",
                           choices: [
                            AnswerChoice(id: 0, text: "Interest calculated on both the initial principal and accumulated interest"),
                            AnswerChoice(id: 1, text: "A one-time fee on a loan"),
                            AnswerChoice(id: 2, text: "A government tax on savings"),
                            AnswerChoice(id: 3, text: "A penalty for early withdrawal")
                           ], correctChoiceID: 0, difficulty: .intermediate),
        PlacementQuestion(id: "p9", prompt: "Which is generally riskier?",
                           choices: [
                            AnswerChoice(id: 0, text: "An individual company's stock"),
                            AnswerChoice(id: 1, text: "A savings account"),
                            AnswerChoice(id: 2, text: "A certificate of deposit (CD)"),
                            AnswerChoice(id: 3, text: "A checking account")
                           ], correctChoiceID: 0, difficulty: .intermediate),
        PlacementQuestion(id: "p10", prompt: "True or False: A bull market means prices are generally falling.",
                           choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                           correctChoiceID: 1, difficulty: .intermediate),

        // MARK: Advanced
        PlacementQuestion(id: "p11", prompt: "What's the key difference between a market order and a limit order?",
                           choices: [
                            AnswerChoice(id: 0, text: "A market order executes immediately at the current price; a limit order sets a specific price"),
                            AnswerChoice(id: 1, text: "They are exactly the same"),
                            AnswerChoice(id: 2, text: "A limit order is only for bonds"),
                            AnswerChoice(id: 3, text: "A market order can only be used once a year")
                           ], correctChoiceID: 0, difficulty: .advanced),
        PlacementQuestion(id: "p12", prompt: "True or False: Market capitalization equals share price multiplied by total shares outstanding.",
                           choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                           correctChoiceID: 0, difficulty: .advanced),
        PlacementQuestion(id: "p13", prompt: "A bear market is typically defined as a decline of what percentage from recent highs?",
                           choices: [
                            AnswerChoice(id: 0, text: "About 20% or more"),
                            AnswerChoice(id: 1, text: "About 1-2%"),
                            AnswerChoice(id: 2, text: "Exactly 50%"),
                            AnswerChoice(id: 3, text: "Any decline at all, even 0.5%")
                           ], correctChoiceID: 0, difficulty: .advanced),
        PlacementQuestion(id: "p14", prompt: "What is \"dollar-cost averaging\"?",
                           choices: [
                            AnswerChoice(id: 0, text: "Investing a fixed amount at regular intervals regardless of price"),
                            AnswerChoice(id: 1, text: "Only investing when prices are at their lowest"),
                            AnswerChoice(id: 2, text: "Converting all investments to cash"),
                            AnswerChoice(id: 3, text: "A tax on foreign currency trades")
                           ], correctChoiceID: 0, difficulty: .advanced),
        PlacementQuestion(id: "p15", prompt: "True or False: The P/E (price-to-earnings) ratio helps evaluate whether a stock might be over- or under-valued.",
                           choices: [AnswerChoice(id: 0, text: "True"), AnswerChoice(id: 1, text: "False")],
                           correctChoiceID: 0, difficulty: .advanced)
    ]
}
