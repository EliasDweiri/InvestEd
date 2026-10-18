import Foundation

// !!! GENERATED FILE — do not edit by hand. !!!
// Source of truth: content_src/units/*.json  (regenerate: python3 tools/gen_content.py)
//
// Twelve units. Each has five lessons (seven questions each) plus a
// 15-question Knowledge Check — auto-assembled from all five lessons —
// that gates the next unit. Questions span eight interactive formats.
enum LessonContentData {
    static let units: [LearningUnit] = [
        moneyBasics,
        paychecksAndTaxes,
        creditAndDebt,
        powerOfTime,
        investingFoundations,
        stockMarket,
        fundsAndFees,
        macroEconOne,
        macroEconTwo,
        investorPsychology,
        cryptoAndDigitalAssets,
        quantCorner
    ]

    private static let moneyBasics = LearningUnit(
            id: "unit1",
            title: "Unit 1: Money Basics",
            subtitle: "Budgeting, saving, and everyday money habits",
            colorHex: "00C896",
            lessons: [
                Lesson(
                    id: "unit1-lesson1",
                    title: "Budgeting 101",
                    iconName: "chart.pie.fill",
                    questions: [
                        .multipleChoice(id: "u1l1q1", prompt: "What is a budget?",
                            choices: [
                            AnswerChoice(id: 0, text: "A plan for how you'll spend and save your money"),
                            AnswerChoice(id: 1, text: "A type of bank account"),
                            AnswerChoice(id: 2, text: "A loan from the government"),
                            AnswerChoice(id: 3, text: "A stock market index")
                            ], correct: 0,
                            explanation: "A budget is simply a plan that maps out your income and expenses so you know where your money is going."),
                        .trueFalse(id: "u1l1q2", prompt: "A budget should include both your income and your expenses.", correctIsTrue: true,
                            explanation: "A good budget tracks money coming in (income) and money going out (expenses)."),
                        .categorize(id: "u1l1q3", prompt: "Sort each item into fixed (same every month) or variable (changes month to month).",
                            categories: ["Fixed", "Variable"],
                            items: [
                            CategoryItem(id: 0, text: "Rent", correctCategory: "Fixed"),
                            CategoryItem(id: 1, text: "Groceries", correctCategory: "Variable"),
                            CategoryItem(id: 2, text: "Car insurance", correctCategory: "Fixed"),
                            CategoryItem(id: 3, text: "Dining out", correctCategory: "Variable"),
                            CategoryItem(id: 4, text: "Netflix subscription", correctCategory: "Fixed")
                            ],
                            explanation: "Fixed costs like rent and insurance stay the same; variable costs like groceries and dining out move around with your choices."),
                        .numeric(id: "u1l1q4", prompt: "You earn $2,000 a month and spend $2,300. How many dollars over budget are you?", answer: 300, tolerance: 0, prefix: "$",
                            explanation: "Spending $2,300 on $2,000 of income is a $300 deficit — you're relying on savings or debt to cover the gap."),
                        .trueFalse(id: "u1l1q5", prompt: "The 50/30/20 rule suggests 50% needs, 30% wants, 20% savings.", correctIsTrue: true,
                            explanation: "It's a popular, simple guideline for splitting take-home pay across needs, wants, and savings."),
                        .multiSelect(id: "u1l1q6", prompt: "Which of these belong in the 'needs' bucket of a budget? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Rent"),
                            AnswerChoice(id: 1, text: "Groceries"),
                            AnswerChoice(id: 2, text: "Concert tickets"),
                            AnswerChoice(id: 3, text: "Electricity bill")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Rent, groceries, and utilities are essentials. Concert tickets are a 'want' — nice, but not required to live."),
                        .ordering(id: "u1l1q7", prompt: "Put these budgeting steps in the order you'd do them.",
                            items: [
                            "Add up your monthly income",
                            "List your expenses",
                            "Subtract expenses from income",
                            "Adjust spending to hit your savings goal"
                            ],
                            explanation: "Start with what comes in, list what goes out, find the difference, then adjust — that's the budgeting loop.")
                    ],
                    xpReward: Constants.xpPerLesson
                ),
                Lesson(
                    id: "unit1-lesson2",
                    title: "Needs vs. Wants",
                    iconName: "cart.fill",
                    questions: [
                        .categorize(id: "u1l2q1", prompt: "Drop each purchase into 'Need' or 'Want'.",
                            categories: ["Need", "Want"],
                            items: [
                            CategoryItem(id: 0, text: "Groceries", correctCategory: "Need"),
                            CategoryItem(id: 1, text: "Designer sneakers", correctCategory: "Want"),
                            CategoryItem(id: 2, text: "Bus fare to work", correctCategory: "Need"),
                            CategoryItem(id: 3, text: "A new video game", correctCategory: "Want"),
                            CategoryItem(id: 4, text: "Basic phone plan", correctCategory: "Need")
                            ],
                            explanation: "Needs keep you fed, housed, and able to earn. Wants add enjoyment but you could live without them."),
                        .trueFalse(id: "u1l2q2", prompt: "Streaming subscriptions are usually considered a 'want.'", correctIsTrue: true,
                            explanation: "Enjoyable, but not essential to survive — so streaming is generally a want."),
                        .multipleChoice(id: "u1l2q3", prompt: "Why is it important to separate needs from wants?",
                            choices: [
                            AnswerChoice(id: 0, text: "It helps you cover essentials first and avoid debt"),
                            AnswerChoice(id: 1, text: "It has no real impact on your finances"),
                            AnswerChoice(id: 2, text: "It only matters for businesses"),
                            AnswerChoice(id: 3, text: "It's required by law")
                            ], correct: 0,
                            explanation: "Knowing the difference makes sure essentials are funded before extras — the core of not overspending."),
                        .multipleChoice(id: "u1l2q4", prompt: "Which best describes a 'want'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Something that improves life but isn't essential to survive"),
                            AnswerChoice(id: 1, text: "Something you must have to survive"),
                            AnswerChoice(id: 2, text: "A type of tax"),
                            AnswerChoice(id: 3, text: "A government benefit")
                            ], correct: 0,
                            explanation: "Wants add comfort or fun; you could go without them if money got tight."),
                        .matching(id: "u1l2q5", prompt: "Match each item to whether it's usually a need or a want.",
                            pairs: [
                            MatchPair(id: 0, left: "Prescription medicine", right: "Need"),
                            MatchPair(id: 1, left: "Second streaming service", right: "Want"),
                            MatchPair(id: 2, left: "Winter coat", right: "Need"),
                            MatchPair(id: 3, left: "Concert VIP upgrade", right: "Want")
                            ],
                            explanation: "Health and staying warm are needs; extra entertainment and upgrades are wants."),
                        .trueFalse(id: "u1l2q6", prompt: "Housing and basic utilities are usually considered needs.", correctIsTrue: true,
                            explanation: "Shelter, water, heat, and electricity are essentials — classic needs."),
                        .numeric(id: "u1l2q7", prompt: "Using the 50/30/20 rule on $2,000 take-home pay, how many dollars go to 'wants'?", answer: 600, tolerance: 0, prefix: "$",
                            explanation: "30% of $2,000 is $600 — the slice the rule sets aside for wants.")
                    ],
                    xpReward: Constants.xpPerLesson
                ),
                Lesson(
                    id: "unit1-lesson3",
                    title: "Saving & Emergency Funds",
                    iconName: "banknote.fill",
                    questions: [
                        .multipleChoice(id: "u1l3q1", prompt: "What is an emergency fund for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Unexpected costs like medical bills or car repairs"),
                            AnswerChoice(id: 1, text: "Buying stocks quickly"),
                            AnswerChoice(id: 2, text: "Everyday grocery shopping"),
                            AnswerChoice(id: 3, text: "Paying regular monthly rent")
                            ], correct: 0,
                            explanation: "It's a cushion for life's surprises — not for planned spending."),
                        .numeric(id: "u1l3q2", prompt: "Experts often suggest saving how many months of expenses in an emergency fund? (Give the low end of the common 3–6 range.)", answer: 3, tolerance: 0, suffix: " months",
                            explanation: "3–6 months of expenses is the usual target; 3 months is a solid starting goal."),
                        .multipleChoice(id: "u1l3q3", prompt: "Where should you generally NOT keep your emergency fund?",
                            choices: [
                            AnswerChoice(id: 0, text: "In risky stocks that can drop fast"),
                            AnswerChoice(id: 1, text: "In a high-yield savings account"),
                            AnswerChoice(id: 2, text: "In a regular savings account"),
                            AnswerChoice(id: 3, text: "Somewhere easy to access")
                            ], correct: 0,
                            explanation: "Emergency money must be safe and reachable — not tied up in something that could fall right when you need it."),
                        .multipleChoice(id: "u1l3q4", prompt: "What does 'paying yourself first' mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "Setting aside savings before spending on anything else"),
                            AnswerChoice(id: 1, text: "Buying yourself gifts before bills"),
                            AnswerChoice(id: 2, text: "Only paying bills you enjoy"),
                            AnswerChoice(id: 3, text: "Investing all your income in stocks")
                            ], correct: 0,
                            explanation: "Automate savings before you can spend it — the money's gone before you miss it."),
                        .trueFalse(id: "u1l3q5", prompt: "An emergency fund should be easy to access quickly if needed.", correctIsTrue: true,
                            explanation: "Liquidity matters — in a real emergency you need the cash fast."),
                        .ordering(id: "u1l3q6", prompt: "Order these savings priorities from what most people should do first to last.",
                            items: [
                            "Build a small $500–$1,000 starter fund",
                            "Pay off high-interest debt",
                            "Grow the fund to 3–6 months of expenses",
                            "Start investing for the long term"
                            ],
                            explanation: "A starter cushion first, then kill high-interest debt, then a full emergency fund, then invest — a common ordering."),
                        .numeric(id: "u1l3q7", prompt: "If your essential expenses are $1,500 a month, how big is a 3-month emergency fund?", answer: 4500, tolerance: 0, prefix: "$",
                            explanation: "$1,500 × 3 months = $4,500 — three months of essentials covered.")
                    ],
                    xpReward: Constants.xpPerLesson
                ),
                Lesson(
                    id: "unit1-lesson4",
                    title: "Banking Basics",
                    iconName: "building.columns.fill",
                    questions: [
                        .matching(id: "u1l4q1", prompt: "Match each account or term to what it's for.",
                            pairs: [
                            MatchPair(id: 0, left: "Checking account", right: "Everyday spending and bills"),
                            MatchPair(id: 1, left: "Savings account", right: "Setting money aside to earn interest"),
                            MatchPair(id: 2, left: "APY", right: "Yearly interest a savings account pays"),
                            MatchPair(id: 3, left: "Overdraft", right: "Spending more than your balance")
                            ],
                            explanation: "Checking is for daily use, savings earns interest (measured as APY), and an overdraft is spending past your balance."),
                        .trueFalse(id: "u1l4q2", prompt: "A high-yield savings account usually pays more interest than a regular checking account.", correctIsTrue: true,
                            explanation: "High-yield savings accounts exist to grow your cash; checking is built for spending and pays little or nothing."),
                        .multipleChoice(id: "u1l4q3", prompt: "In the U.S., what does FDIC insurance protect?",
                            choices: [
                            AnswerChoice(id: 0, text: "Your bank deposits (up to the limit) if the bank fails"),
                            AnswerChoice(id: 1, text: "Your stocks if they lose value"),
                            AnswerChoice(id: 2, text: "Your car in an accident"),
                            AnswerChoice(id: 3, text: "Your credit score")
                            ], correct: 0,
                            explanation: "FDIC insurance covers bank deposits up to $250,000 per depositor, per bank — a key safety net that crypto and stocks don't have."),
                        .multipleChoice(id: "u1l4q4", prompt: "What is an overdraft fee?",
                            choices: [
                            AnswerChoice(id: 0, text: "A charge for spending more than your account balance"),
                            AnswerChoice(id: 1, text: "A reward for saving"),
                            AnswerChoice(id: 2, text: "A fee for checking your balance"),
                            AnswerChoice(id: 3, text: "Interest you earn")
                            ], correct: 0,
                            explanation: "Spend past your balance and many banks charge an overdraft fee — often $30+ per slip."),
                        .numeric(id: "u1l4q5", prompt: "You keep $2,000 in a savings account earning 4% APY. Roughly how many dollars of interest is that in one year?", answer: 80, tolerance: 5, prefix: "$",
                            explanation: "4% of $2,000 is about $80 a year — free money for letting your cash sit in the right account."),
                        .multiSelect(id: "u1l4q6", prompt: "Which habits help you avoid unnecessary bank fees? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Keep enough balance to avoid overdrafts"),
                            AnswerChoice(id: 1, text: "Use in-network ATMs"),
                            AnswerChoice(id: 2, text: "Ignore your account until payday"),
                            AnswerChoice(id: 3, text: "Set up low-balance alerts")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Watching your balance, using in-network ATMs, and alerts all prevent fees. Ignoring the account is how fees sneak up on you."),
                        .trueFalse(id: "u1l4q7", prompt: "Money in a checking account is a good long-term investment for growing wealth.", correctIsTrue: false,
                            explanation: "Checking pays little to no interest, so inflation slowly erodes it. It's for spending — invest longer-term money elsewhere.")
                    ],
                    xpReward: Constants.xpPerLesson
                ),
                Lesson(
                    id: "unit1-lesson5",
                    title: "Smart Spending",
                    iconName: "tag.fill",
                    questions: [
                        .multipleChoice(id: "u1l5q1", prompt: "What is 'impulse spending'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Buying on a whim without planning it"),
                            AnswerChoice(id: 1, text: "Carefully comparing prices first"),
                            AnswerChoice(id: 2, text: "Saving before you spend"),
                            AnswerChoice(id: 3, text: "Paying a bill on time")
                            ], correct: 0,
                            explanation: "Impulse buys are unplanned purchases driven by the moment — the enemy of a budget."),
                        .multipleChoice(id: "u1l5q2", prompt: "The '24-hour rule' for shopping means…",
                            choices: [
                            AnswerChoice(id: 0, text: "Waiting a day before a non-essential purchase to see if you still want it"),
                            AnswerChoice(id: 1, text: "Only shopping for 24 hours a year"),
                            AnswerChoice(id: 2, text: "Returning everything within 24 hours"),
                            AnswerChoice(id: 3, text: "Spending 24% of income on wants")
                            ], correct: 0,
                            explanation: "Sleeping on it filters out impulse buys — a lot of 'must-haves' feel optional the next day."),
                        .numeric(id: "u1l5q3", prompt: "A $6 coffee bought every weekday. Roughly how many dollars is that over a 4-week month? (5 days × 4 weeks)", answer: 120, tolerance: 0, prefix: "$",
                            explanation: "$6 × 5 × 4 = $120 a month. Small daily buys add up fast — that's the 'latte factor.'"),
                        .categorize(id: "u1l5q4", prompt: "Sort these into smart-spending habits vs. money traps.",
                            categories: ["Smart habit", "Money trap"],
                            items: [
                            CategoryItem(id: 0, text: "Comparing prices before buying", correctCategory: "Smart habit"),
                            CategoryItem(id: 1, text: "Buying because it's 'on sale'", correctCategory: "Money trap"),
                            CategoryItem(id: 2, text: "Using a shopping list", correctCategory: "Smart habit"),
                            CategoryItem(id: 3, text: "Paying only the card minimum", correctCategory: "Money trap")
                            ],
                            explanation: "Lists and price comparison protect your money; chasing 'sales' and minimum payments quietly drain it."),
                        .trueFalse(id: "u1l5q5", prompt: "A sale is only a good deal if it's something you were already going to buy.", correctIsTrue: true,
                            explanation: "Spending $40 to 'save' $10 on something you didn't need still costs you $40. A deal only helps on real needs."),
                        .multipleChoice(id: "u1l5q6", prompt: "Why are forgotten subscriptions a common money leak?",
                            choices: [
                            AnswerChoice(id: 0, text: "They quietly charge you every month whether you use them or not"),
                            AnswerChoice(id: 1, text: "They're illegal"),
                            AnswerChoice(id: 2, text: "They pay you interest"),
                            AnswerChoice(id: 3, text: "They improve your credit score")
                            ], correct: 0,
                            explanation: "Auto-renewing subscriptions bill you on autopilot — auditing them a few times a year plugs the leak."),
                        .ordering(id: "u1l5q7", prompt: "Order these steps for making a smart big purchase.",
                            items: [
                            "Decide if it's a need or a want",
                            "Set a budget for it",
                            "Compare prices across sellers",
                            "Wait a day, then buy if it still makes sense"
                            ],
                            explanation: "Need vs. want, then a budget, then comparison, then a cool-off — a simple guardrail against overspending.")
                    ],
                    xpReward: Constants.xpPerLesson
                )
            ],
            finalTest:
                Lesson(
                    id: "unit1-check",
                    title: "Money Basics: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u1l1q2-kc", prompt: "A budget should include both your income and your expenses.", correctIsTrue: true,
                            explanation: "A good budget tracks money coming in (income) and money going out (expenses)."),
                        .numeric(id: "u1l1q4-kc", prompt: "You earn $2,000 a month and spend $2,300. How many dollars over budget are you?", answer: 300, tolerance: 0, prefix: "$",
                            explanation: "Spending $2,300 on $2,000 of income is a $300 deficit — you're relying on savings or debt to cover the gap."),
                        .multiSelect(id: "u1l1q6-kc", prompt: "Which of these belong in the 'needs' bucket of a budget? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Rent"),
                            AnswerChoice(id: 1, text: "Groceries"),
                            AnswerChoice(id: 2, text: "Concert tickets"),
                            AnswerChoice(id: 3, text: "Electricity bill")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Rent, groceries, and utilities are essentials. Concert tickets are a 'want' — nice, but not required to live."),
                        .trueFalse(id: "u1l2q2-kc", prompt: "Streaming subscriptions are usually considered a 'want.'", correctIsTrue: true,
                            explanation: "Enjoyable, but not essential to survive — so streaming is generally a want."),
                        .multipleChoice(id: "u1l2q4-kc", prompt: "Which best describes a 'want'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Something that improves life but isn't essential to survive"),
                            AnswerChoice(id: 1, text: "Something you must have to survive"),
                            AnswerChoice(id: 2, text: "A type of tax"),
                            AnswerChoice(id: 3, text: "A government benefit")
                            ], correct: 0,
                            explanation: "Wants add comfort or fun; you could go without them if money got tight."),
                        .trueFalse(id: "u1l2q6-kc", prompt: "Housing and basic utilities are usually considered needs.", correctIsTrue: true,
                            explanation: "Shelter, water, heat, and electricity are essentials — classic needs."),
                        .numeric(id: "u1l3q2-kc", prompt: "Experts often suggest saving how many months of expenses in an emergency fund? (Give the low end of the common 3–6 range.)", answer: 3, tolerance: 0, suffix: " months",
                            explanation: "3–6 months of expenses is the usual target; 3 months is a solid starting goal."),
                        .multipleChoice(id: "u1l3q4-kc", prompt: "What does 'paying yourself first' mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "Setting aside savings before spending on anything else"),
                            AnswerChoice(id: 1, text: "Buying yourself gifts before bills"),
                            AnswerChoice(id: 2, text: "Only paying bills you enjoy"),
                            AnswerChoice(id: 3, text: "Investing all your income in stocks")
                            ], correct: 0,
                            explanation: "Automate savings before you can spend it — the money's gone before you miss it."),
                        .ordering(id: "u1l3q6-kc", prompt: "Order these savings priorities from what most people should do first to last.",
                            items: [
                            "Build a small $500–$1,000 starter fund",
                            "Pay off high-interest debt",
                            "Grow the fund to 3–6 months of expenses",
                            "Start investing for the long term"
                            ],
                            explanation: "A starter cushion first, then kill high-interest debt, then a full emergency fund, then invest — a common ordering."),
                        .trueFalse(id: "u1l4q2-kc", prompt: "A high-yield savings account usually pays more interest than a regular checking account.", correctIsTrue: true,
                            explanation: "High-yield savings accounts exist to grow your cash; checking is built for spending and pays little or nothing."),
                        .multipleChoice(id: "u1l4q4-kc", prompt: "What is an overdraft fee?",
                            choices: [
                            AnswerChoice(id: 0, text: "A charge for spending more than your account balance"),
                            AnswerChoice(id: 1, text: "A reward for saving"),
                            AnswerChoice(id: 2, text: "A fee for checking your balance"),
                            AnswerChoice(id: 3, text: "Interest you earn")
                            ], correct: 0,
                            explanation: "Spend past your balance and many banks charge an overdraft fee — often $30+ per slip."),
                        .multiSelect(id: "u1l4q6-kc", prompt: "Which habits help you avoid unnecessary bank fees? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Keep enough balance to avoid overdrafts"),
                            AnswerChoice(id: 1, text: "Use in-network ATMs"),
                            AnswerChoice(id: 2, text: "Ignore your account until payday"),
                            AnswerChoice(id: 3, text: "Set up low-balance alerts")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Watching your balance, using in-network ATMs, and alerts all prevent fees. Ignoring the account is how fees sneak up on you."),
                        .multipleChoice(id: "u1l5q2-kc", prompt: "The '24-hour rule' for shopping means…",
                            choices: [
                            AnswerChoice(id: 0, text: "Waiting a day before a non-essential purchase to see if you still want it"),
                            AnswerChoice(id: 1, text: "Only shopping for 24 hours a year"),
                            AnswerChoice(id: 2, text: "Returning everything within 24 hours"),
                            AnswerChoice(id: 3, text: "Spending 24% of income on wants")
                            ], correct: 0,
                            explanation: "Sleeping on it filters out impulse buys — a lot of 'must-haves' feel optional the next day."),
                        .categorize(id: "u1l5q4-kc", prompt: "Sort these into smart-spending habits vs. money traps.",
                            categories: ["Smart habit", "Money trap"],
                            items: [
                            CategoryItem(id: 0, text: "Comparing prices before buying", correctCategory: "Smart habit"),
                            CategoryItem(id: 1, text: "Buying because it's 'on sale'", correctCategory: "Money trap"),
                            CategoryItem(id: 2, text: "Using a shopping list", correctCategory: "Smart habit"),
                            CategoryItem(id: 3, text: "Paying only the card minimum", correctCategory: "Money trap")
                            ],
                            explanation: "Lists and price comparison protect your money; chasing 'sales' and minimum payments quietly drain it."),
                        .multipleChoice(id: "u1l5q6-kc", prompt: "Why are forgotten subscriptions a common money leak?",
                            choices: [
                            AnswerChoice(id: 0, text: "They quietly charge you every month whether you use them or not"),
                            AnswerChoice(id: 1, text: "They're illegal"),
                            AnswerChoice(id: 2, text: "They pay you interest"),
                            AnswerChoice(id: 3, text: "They improve your credit score")
                            ], correct: 0,
                            explanation: "Auto-renewing subscriptions bill you on autopilot — auditing them a few times a year plugs the leak.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let paychecksAndTaxes = LearningUnit(
            id: "unit7",
            title: "Unit 2: Paychecks & Taxes",
            subtitle: "Where your money goes before you see it",
            colorHex: "00B4D8",
            lessons: [
                Lesson(
                    id: "unit7-lesson1",
                    title: "Reading a Paycheck",
                    iconName: "banknote.fill",
                    questions: [
                        .multipleChoice(id: "u7l1q1", prompt: "What does 'gross pay' mean on a paycheck?",
                            choices: [
                            AnswerChoice(id: 0, text: "Your total earnings before any deductions"),
                            AnswerChoice(id: 1, text: "The money you actually take home"),
                            AnswerChoice(id: 2, text: "The tax you owe the government"),
                            AnswerChoice(id: 3, text: "Your yearly bonus")
                            ], correct: 0,
                            explanation: "Gross pay is everything you earned before taxes and other deductions are taken out. It's always the bigger number."),
                        .trueFalse(id: "u7l1q2", prompt: "When deductions come out of your pay, your net (take-home) pay is smaller than your gross pay.", correctIsTrue: true,
                            explanation: "Net pay is what's left after taxes and deductions, so it's the smaller amount that lands in your bank account."),
                        .numeric(id: "u7l1q3", prompt: "Your gross pay is $1,000 and total deductions are $250. What is your net (take-home) pay?", answer: 750, tolerance: 0, prefix: "$",
                            explanation: "$1,000 gross minus $250 in deductions leaves $750 of take-home pay."),
                        .matching(id: "u7l1q4", prompt: "Match each paycheck term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Gross pay", right: "Earnings before deductions"),
                            MatchPair(id: 1, left: "Net pay", right: "Take-home after deductions"),
                            MatchPair(id: 2, left: "Deduction", right: "Money withheld from your pay"),
                            MatchPair(id: 3, left: "W-4", right: "Form telling your employer how much tax to withhold")
                            ],
                            explanation: "Gross is before, net is after, deductions are what's taken out, and the W-4 sets how much tax gets withheld."),
                        .multiSelect(id: "u7l1q5", prompt: "Which of these are common deductions taken out of a paycheck? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Federal income tax"),
                            AnswerChoice(id: 1, text: "Social Security & Medicare (FICA)"),
                            AnswerChoice(id: 2, text: "Your weekly grocery bill"),
                            AnswerChoice(id: 3, text: "Health insurance premium")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Taxes, FICA, and benefits like health insurance come straight out of your pay. Your grocery bill is spending you handle yourself."),
                        .multipleChoice(id: "u7l1q6", prompt: "What is a W-4 form used for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Telling your employer how much federal tax to withhold from each paycheck"),
                            AnswerChoice(id: 1, text: "Applying for a credit card"),
                            AnswerChoice(id: 2, text: "Opening a savings account"),
                            AnswerChoice(id: 3, text: "Filing for unemployment")
                            ], correct: 0,
                            explanation: "You fill out a W-4 when you start a job so your employer knows how much tax to hold back from each check."),
                        .ordering(id: "u7l1q7", prompt: "Put these steps in order, from earning money to getting paid.",
                            items: [
                            "Employer calculates your gross pay",
                            "Taxes are withheld",
                            "Other deductions come out",
                            "You receive your net pay by direct deposit"
                            ],
                            explanation: "You earn gross pay, taxes and deductions are subtracted, and what's left is deposited as your net pay.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit7-lesson2",
                    title: "How Income Tax Works",
                    iconName: "percent",
                    questions: [
                        .multipleChoice(id: "u7l2q1", prompt: "What is your 'marginal tax rate'?",
                            choices: [
                            AnswerChoice(id: 0, text: "The rate applied to your last (highest) dollar of income"),
                            AnswerChoice(id: 1, text: "The rate applied to every dollar you earn"),
                            AnswerChoice(id: 2, text: "A tax only businesses pay"),
                            AnswerChoice(id: 3, text: "A flat 10% on all income")
                            ], correct: 0,
                            explanation: "Your marginal rate is the rate on the top slice of your income, not on all of it. Different chunks of income get taxed at different rates."),
                        .trueFalse(id: "u7l2q2", prompt: "Moving into a higher tax bracket means your entire income is suddenly taxed at that higher rate.", correctIsTrue: false,
                            explanation: "This is the classic 'raise myth.' Only the income above the bracket's threshold is taxed at the higher rate, so a raise always leaves you with more money."),
                        .trueFalse(id: "u7l2q3", prompt: "A tax refund happens when you overpaid taxes during the year and the government returns the extra.", correctIsTrue: true,
                            explanation: "A refund isn't a bonus. It's your own money coming back because too much was withheld from your paychecks."),
                        .numeric(id: "u7l2q4", prompt: "Say the first $10,000 you earn is taxed at 10%, and income above $10,000 is taxed at 20%. If you earn $30,000, how much tax do you owe in dollars?", answer: 5000, tolerance: 0, prefix: "$",
                            explanation: "10% of the first $10,000 is $1,000, and 20% of the remaining $20,000 is $4,000, for a total of $5,000."),
                        .multipleChoice(id: "u7l2q5", prompt: "You get a raise that pushes part of your income into a higher bracket. What happens to your take-home pay?",
                            choices: [
                            AnswerChoice(id: 0, text: "Only the portion above the threshold is taxed higher, so you still take home more overall"),
                            AnswerChoice(id: 1, text: "Your whole paycheck shrinks because you're now 'in' the higher bracket"),
                            AnswerChoice(id: 2, text: "You take home exactly the same as before"),
                            AnswerChoice(id: 3, text: "You now owe tax on money you earned in past years")
                            ], correct: 0,
                            explanation: "Brackets are marginal, so a raise always increases your take-home pay. Turning down a raise to 'avoid taxes' never makes sense."),
                        .matching(id: "u7l2q6", prompt: "Match each tax term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Tax bracket", right: "An income range taxed at a set rate"),
                            MatchPair(id: 1, left: "Marginal rate", right: "The rate on your last dollar earned"),
                            MatchPair(id: 2, left: "Effective rate", right: "Your average rate across all income"),
                            MatchPair(id: 3, left: "Refund", right: "Money back when you overpaid taxes")
                            ],
                            explanation: "Brackets set the ranges, the marginal rate hits your top dollar, the effective rate is your overall average, and a refund returns any overpayment."),
                        .trueFalse(id: "u7l2q7", prompt: "Your effective (average) tax rate is usually lower than your top marginal rate.", correctIsTrue: true,
                            explanation: "Because your lower income slices are taxed at lower rates, the average you actually pay comes out below your highest bracket rate.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit7-lesson3",
                    title: "Types of Taxes",
                    iconName: "building.columns.fill",
                    questions: [
                        .categorize(id: "u7l3q1", prompt: "Sort each example into the type of tax it describes.",
                            categories: ["Income tax", "Sales tax", "Property tax"],
                            items: [
                            CategoryItem(id: 0, text: "Tax on the money you earn at your job", correctCategory: "Income tax"),
                            CategoryItem(id: 1, text: "Extra amount added at the register when you buy something", correctCategory: "Sales tax"),
                            CategoryItem(id: 2, text: "Yearly tax based on the value of a home you own", correctCategory: "Property tax"),
                            CategoryItem(id: 3, text: "The 8% added to the price of new sneakers", correctCategory: "Sales tax"),
                            CategoryItem(id: 4, text: "Tax homeowners pay that helps fund local schools", correctCategory: "Property tax")
                            ],
                            explanation: "Income tax hits your earnings, sales tax is added to purchases, and property tax is based on real estate you own."),
                        .multipleChoice(id: "u7l3q2", prompt: "What are payroll taxes (FICA) used for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Funding Social Security and Medicare"),
                            AnswerChoice(id: 1, text: "Paying for your local library only"),
                            AnswerChoice(id: 2, text: "Covering your health insurance directly"),
                            AnswerChoice(id: 3, text: "Repaying your student loans")
                            ], correct: 0,
                            explanation: "FICA taxes come out of your wages to fund Social Security and Medicare, programs that support retirees and people needing care."),
                        .trueFalse(id: "u7l3q3", prompt: "Sales tax is a percentage added to the price of many goods and services when you buy them.", correctIsTrue: true,
                            explanation: "You pay sales tax at checkout, so a listed price often costs a bit more once tax is added on."),
                        .matching(id: "u7l3q4", prompt: "Match each tax to what it's based on or funds.",
                            pairs: [
                            MatchPair(id: 0, left: "Sales tax", right: "Charged at checkout on purchases"),
                            MatchPair(id: 1, left: "Property tax", right: "Based on real estate value, funds local services"),
                            MatchPair(id: 2, left: "Payroll tax (FICA)", right: "Funds Social Security & Medicare"),
                            MatchPair(id: 3, left: "Income tax", right: "Based on what you earn")
                            ],
                            explanation: "Each tax has a different trigger: buying, owning property, earning wages, or earning income overall."),
                        .multiSelect(id: "u7l3q5", prompt: "Which taxes would a teen with a part-time job and no house realistically pay? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Payroll tax (FICA) from their paycheck"),
                            AnswerChoice(id: 1, text: "Sales tax when they buy things"),
                            AnswerChoice(id: 2, text: "State income tax in states that charge it"),
                            AnswerChoice(id: 3, text: "Property tax on a house they don't own")
                            ], correctIDs: [0, 1, 2],
                            explanation: "FICA comes out of every paycheck, sales tax hits purchases, and many states tax wages too. Property tax only applies to real estate you own."),
                        .numeric(id: "u7l3q6", prompt: "You buy a $50 item in a place with 8% sales tax. How much sales tax do you pay in dollars?", answer: 4, tolerance: 0, prefix: "$",
                            explanation: "8% of $50 is $4, so the total at the register would be $54."),
                        .multipleChoice(id: "u7l3q7", prompt: "Property tax is mainly based on what?",
                            choices: [
                            AnswerChoice(id: 0, text: "The assessed value of real estate you own, like a house or land"),
                            AnswerChoice(id: 1, text: "How much you spend at stores each year"),
                            AnswerChoice(id: 2, text: "The number of hours you work"),
                            AnswerChoice(id: 3, text: "Your streaming subscriptions")
                            ], correct: 0,
                            explanation: "Property tax is tied to the value of real estate you own, and it usually helps pay for local services like schools and roads.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit7-lesson4",
                    title: "Retirement Accounts 101",
                    iconName: "chart.line.uptrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u7l4q1", prompt: "What is a 401(k)?",
                            choices: [
                            AnswerChoice(id: 0, text: "A retirement account offered through your employer, often funded straight from your paycheck"),
                            AnswerChoice(id: 1, text: "A type of checking account for daily spending"),
                            AnswerChoice(id: 2, text: "A short-term loan from your boss"),
                            AnswerChoice(id: 3, text: "A government tax form")
                            ], correct: 0,
                            explanation: "A 401(k) is an employer-sponsored retirement account. Money can go in automatically from your paycheck, often before taxes."),
                        .trueFalse(id: "u7l4q2", prompt: "An employer 401(k) match is basically free money your employer adds when you contribute.", correctIsTrue: true,
                            explanation: "If your employer matches your contributions, that's extra money added to your retirement savings just for participating. Not grabbing it leaves free money on the table."),
                        .numeric(id: "u7l4q3", prompt: "You contribute $2,000 to your 401(k) and your employer matches 50% of your contributions. How much free money does your employer add in dollars?", answer: 1000, tolerance: 0, prefix: "$",
                            explanation: "50% of your $2,000 contribution is $1,000 of employer match, bringing your total to $3,000."),
                        .matching(id: "u7l4q4", prompt: "Match each retirement term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "401(k)", right: "Employer-sponsored retirement account"),
                            MatchPair(id: 1, left: "Roth IRA", right: "After-tax money that grows tax-free"),
                            MatchPair(id: 2, left: "Employer match", right: "Free money added when you contribute"),
                            MatchPair(id: 3, left: "Compound growth", right: "Earnings that go on to earn more")
                            ],
                            explanation: "A 401(k) comes from your job, a Roth IRA gives tax-free withdrawals later, the match is free money, and compounding grows your money over time."),
                        .multipleChoice(id: "u7l4q5", prompt: "What's a key perk of a Roth IRA?",
                            choices: [
                            AnswerChoice(id: 0, text: "You pay taxes now, but qualified withdrawals in retirement are tax-free"),
                            AnswerChoice(id: 1, text: "You never pay any taxes ever on any account"),
                            AnswerChoice(id: 2, text: "Your employer is required to fund it for you"),
                            AnswerChoice(id: 3, text: "You can withdraw all your earnings with no rules the day you open it")
                            ], correct: 0,
                            explanation: "With a Roth IRA you contribute after-tax money, and later your withdrawals (including all the growth) can come out tax-free."),
                        .multiSelect(id: "u7l4q6", prompt: "Which statements about tax-advantaged retirement accounts are true? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "They let your money grow with tax benefits"),
                            AnswerChoice(id: 1, text: "An employer match adds free money"),
                            AnswerChoice(id: 2, text: "You should skip the match to keep more cash today"),
                            AnswerChoice(id: 3, text: "Starting young gives compounding more time to work")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Tax perks, employer matches, and an early start all help. Skipping the match throws away free money."),
                        .trueFalse(id: "u7l4q7", prompt: "Thanks to compound growth, starting to invest at 22 instead of 32 can build a much bigger nest egg, even with the same monthly contribution.", correctIsTrue: true,
                            explanation: "Those extra years let your earnings pile up and earn even more, so time is one of your biggest advantages when investing.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit7-lesson5",
                    title: "Your First Job Money Moves",
                    iconName: "briefcase.fill",
                    questions: [
                        .multipleChoice(id: "u7l5q1", prompt: "What does 'pay yourself first' mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "Set aside savings or investing money before you spend on anything else"),
                            AnswerChoice(id: 1, text: "Buy yourself a treat every payday before paying bills"),
                            AnswerChoice(id: 2, text: "Pay your rent before your savings"),
                            AnswerChoice(id: 3, text: "Give yourself a raise whenever you want")
                            ], correct: 0,
                            explanation: "Paying yourself first means saving off the top of each paycheck, so saving happens automatically instead of with whatever's left over."),
                        .trueFalse(id: "u7l5q2", prompt: "'Lifestyle inflation' is when your spending rises as fast as your income, so you never really get ahead.", correctIsTrue: true,
                            explanation: "Also called lifestyle creep, it's why some people earn more but never save more. Keeping spending steady as income grows is how you build wealth."),
                        .multipleChoice(id: "u7l5q3", prompt: "How can splitting your direct deposit help you save?",
                            choices: [
                            AnswerChoice(id: 0, text: "It automatically sends part of each paycheck to savings before you can spend it"),
                            AnswerChoice(id: 1, text: "It makes your paycheck arrive faster"),
                            AnswerChoice(id: 2, text: "It lowers your income tax rate"),
                            AnswerChoice(id: 3, text: "It doubles your gross pay")
                            ], correct: 0,
                            explanation: "A direct deposit split routes some of every paycheck straight into savings, so you save without having to think about it."),
                        .numeric(id: "u7l5q4", prompt: "You take home $1,500 per paycheck and pay yourself first by saving 20%. How many dollars go to savings?", answer: 300, tolerance: 0, prefix: "$",
                            explanation: "20% of $1,500 is $300, moved to savings before you spend the rest."),
                        .ordering(id: "u7l5q5", prompt: "Put these 'pay yourself first' money moves in a smart order.",
                            items: [
                            "Receive your paycheck by direct deposit",
                            "Automatically move savings out first",
                            "Pay for your needs",
                            "Enjoy what's left on wants"
                            ],
                            explanation: "Get paid, save off the top, cover essentials, then spend the rest guilt-free."),
                        .multiSelect(id: "u7l5q6", prompt: "Which are smart money moves at your first job? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Automate savings with a direct deposit split"),
                            AnswerChoice(id: 1, text: "Grab the full employer 401(k) match"),
                            AnswerChoice(id: 2, text: "Upgrade your lifestyle to match every raise"),
                            AnswerChoice(id: 3, text: "Build an emergency fund")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Automating savings, taking the match, and building an emergency fund all set you up. Spending every raise is lifestyle inflation working against you."),
                        .matching(id: "u7l5q7", prompt: "Match each money move to what it means.",
                            pairs: [
                            MatchPair(id: 0, left: "Pay yourself first", right: "Save before you spend"),
                            MatchPair(id: 1, left: "Lifestyle inflation", right: "Spending rises with income"),
                            MatchPair(id: 2, left: "Direct deposit split", right: "Paycheck auto-divided into accounts"),
                            MatchPair(id: 3, left: "Emergency fund", right: "Cash set aside for surprises")
                            ],
                            explanation: "These habits work together: save first, resist creep, automate the split, and keep a cushion for the unexpected.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit7-check",
                    title: "Paychecks & Taxes: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u7l1q2-kc", prompt: "When deductions come out of your pay, your net (take-home) pay is smaller than your gross pay.", correctIsTrue: true,
                            explanation: "Net pay is what's left after taxes and deductions, so it's the smaller amount that lands in your bank account."),
                        .matching(id: "u7l1q4-kc", prompt: "Match each paycheck term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Gross pay", right: "Earnings before deductions"),
                            MatchPair(id: 1, left: "Net pay", right: "Take-home after deductions"),
                            MatchPair(id: 2, left: "Deduction", right: "Money withheld from your pay"),
                            MatchPair(id: 3, left: "W-4", right: "Form telling your employer how much tax to withhold")
                            ],
                            explanation: "Gross is before, net is after, deductions are what's taken out, and the W-4 sets how much tax gets withheld."),
                        .multipleChoice(id: "u7l1q6-kc", prompt: "What is a W-4 form used for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Telling your employer how much federal tax to withhold from each paycheck"),
                            AnswerChoice(id: 1, text: "Applying for a credit card"),
                            AnswerChoice(id: 2, text: "Opening a savings account"),
                            AnswerChoice(id: 3, text: "Filing for unemployment")
                            ], correct: 0,
                            explanation: "You fill out a W-4 when you start a job so your employer knows how much tax to hold back from each check."),
                        .trueFalse(id: "u7l2q2-kc", prompt: "Moving into a higher tax bracket means your entire income is suddenly taxed at that higher rate.", correctIsTrue: false,
                            explanation: "This is the classic 'raise myth.' Only the income above the bracket's threshold is taxed at the higher rate, so a raise always leaves you with more money."),
                        .numeric(id: "u7l2q4-kc", prompt: "Say the first $10,000 you earn is taxed at 10%, and income above $10,000 is taxed at 20%. If you earn $30,000, how much tax do you owe in dollars?", answer: 5000, tolerance: 0, prefix: "$",
                            explanation: "10% of the first $10,000 is $1,000, and 20% of the remaining $20,000 is $4,000, for a total of $5,000."),
                        .matching(id: "u7l2q6-kc", prompt: "Match each tax term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Tax bracket", right: "An income range taxed at a set rate"),
                            MatchPair(id: 1, left: "Marginal rate", right: "The rate on your last dollar earned"),
                            MatchPair(id: 2, left: "Effective rate", right: "Your average rate across all income"),
                            MatchPair(id: 3, left: "Refund", right: "Money back when you overpaid taxes")
                            ],
                            explanation: "Brackets set the ranges, the marginal rate hits your top dollar, the effective rate is your overall average, and a refund returns any overpayment."),
                        .multipleChoice(id: "u7l3q2-kc", prompt: "What are payroll taxes (FICA) used for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Funding Social Security and Medicare"),
                            AnswerChoice(id: 1, text: "Paying for your local library only"),
                            AnswerChoice(id: 2, text: "Covering your health insurance directly"),
                            AnswerChoice(id: 3, text: "Repaying your student loans")
                            ], correct: 0,
                            explanation: "FICA taxes come out of your wages to fund Social Security and Medicare, programs that support retirees and people needing care."),
                        .matching(id: "u7l3q4-kc", prompt: "Match each tax to what it's based on or funds.",
                            pairs: [
                            MatchPair(id: 0, left: "Sales tax", right: "Charged at checkout on purchases"),
                            MatchPair(id: 1, left: "Property tax", right: "Based on real estate value, funds local services"),
                            MatchPair(id: 2, left: "Payroll tax (FICA)", right: "Funds Social Security & Medicare"),
                            MatchPair(id: 3, left: "Income tax", right: "Based on what you earn")
                            ],
                            explanation: "Each tax has a different trigger: buying, owning property, earning wages, or earning income overall."),
                        .numeric(id: "u7l3q6-kc", prompt: "You buy a $50 item in a place with 8% sales tax. How much sales tax do you pay in dollars?", answer: 4, tolerance: 0, prefix: "$",
                            explanation: "8% of $50 is $4, so the total at the register would be $54."),
                        .trueFalse(id: "u7l4q2-kc", prompt: "An employer 401(k) match is basically free money your employer adds when you contribute.", correctIsTrue: true,
                            explanation: "If your employer matches your contributions, that's extra money added to your retirement savings just for participating. Not grabbing it leaves free money on the table."),
                        .matching(id: "u7l4q4-kc", prompt: "Match each retirement term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "401(k)", right: "Employer-sponsored retirement account"),
                            MatchPair(id: 1, left: "Roth IRA", right: "After-tax money that grows tax-free"),
                            MatchPair(id: 2, left: "Employer match", right: "Free money added when you contribute"),
                            MatchPair(id: 3, left: "Compound growth", right: "Earnings that go on to earn more")
                            ],
                            explanation: "A 401(k) comes from your job, a Roth IRA gives tax-free withdrawals later, the match is free money, and compounding grows your money over time."),
                        .multiSelect(id: "u7l4q6-kc", prompt: "Which statements about tax-advantaged retirement accounts are true? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "They let your money grow with tax benefits"),
                            AnswerChoice(id: 1, text: "An employer match adds free money"),
                            AnswerChoice(id: 2, text: "You should skip the match to keep more cash today"),
                            AnswerChoice(id: 3, text: "Starting young gives compounding more time to work")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Tax perks, employer matches, and an early start all help. Skipping the match throws away free money."),
                        .trueFalse(id: "u7l5q2-kc", prompt: "'Lifestyle inflation' is when your spending rises as fast as your income, so you never really get ahead.", correctIsTrue: true,
                            explanation: "Also called lifestyle creep, it's why some people earn more but never save more. Keeping spending steady as income grows is how you build wealth."),
                        .numeric(id: "u7l5q4-kc", prompt: "You take home $1,500 per paycheck and pay yourself first by saving 20%. How many dollars go to savings?", answer: 300, tolerance: 0, prefix: "$",
                            explanation: "20% of $1,500 is $300, moved to savings before you spend the rest."),
                        .multiSelect(id: "u7l5q6-kc", prompt: "Which are smart money moves at your first job? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Automate savings with a direct deposit split"),
                            AnswerChoice(id: 1, text: "Grab the full employer 401(k) match"),
                            AnswerChoice(id: 2, text: "Upgrade your lifestyle to match every raise"),
                            AnswerChoice(id: 3, text: "Build an emergency fund")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Automating savings, taking the match, and building an emergency fund all set you up. Spending every raise is lifestyle inflation working against you.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let creditAndDebt = LearningUnit(
            id: "unit4",
            title: "Unit 3: Credit & Debt",
            subtitle: "Borrowing without getting bitten",
            colorHex: "EF476F",
            lessons: [
                Lesson(
                    id: "unit4-lesson1",
                    title: "Credit Scores",
                    iconName: "speedometer",
                    questions: [
                        .multipleChoice(id: "u4l1q1", prompt: "What is a credit score?",
                            choices: [
                            AnswerChoice(id: 0, text: "A number that predicts how likely you are to repay borrowed money"),
                            AnswerChoice(id: 1, text: "The amount of money in your bank account"),
                            AnswerChoice(id: 2, text: "A tax the government charges on loans"),
                            AnswerChoice(id: 3, text: "The interest rate on your savings account")
                            ], correct: 0,
                            explanation: "A credit score is a snapshot of your borrowing trustworthiness, so lenders can guess how risky it is to lend to you."),
                        .numeric(id: "u4l1q2", prompt: "A FICO credit score ranges from a low of 300 up to a high of what number?", answer: 850, tolerance: 0,
                            explanation: "FICO scores run from 300 to 850 — the higher you climb, the better the rates lenders offer you."),
                        .trueFalse(id: "u4l1q3", prompt: "Paying your bills on time is the single biggest factor in your credit score.", correctIsTrue: true,
                            explanation: "Payment history is about 35% of a FICO score — nothing else moves the needle more than paying on time."),
                        .categorize(id: "u4l1q4", prompt: "Sort each action into whether it's a soft inquiry (no score impact) or a hard inquiry (can ding your score).",
                            categories: ["Soft inquiry", "Hard inquiry"],
                            items: [
                            CategoryItem(id: 0, text: "Checking your own credit score", correctCategory: "Soft inquiry"),
                            CategoryItem(id: 1, text: "Applying for a new credit card", correctCategory: "Hard inquiry"),
                            CategoryItem(id: 2, text: "Getting a pre-approved offer in the mail", correctCategory: "Soft inquiry"),
                            CategoryItem(id: 3, text: "Taking out an auto loan", correctCategory: "Hard inquiry")
                            ],
                            explanation: "Soft inquiries — like peeking at your own score — never hurt you. Hard inquiries happen when you actually apply for credit and can shave off a few points."),
                        .multiSelect(id: "u4l1q5", prompt: "Which habits help you build a strong credit score? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Paying every bill on time"),
                            AnswerChoice(id: 1, text: "Keeping credit card balances low"),
                            AnswerChoice(id: 2, text: "Maxing out your cards every month"),
                            AnswerChoice(id: 3, text: "Keeping older accounts open")
                            ], correctIDs: [0, 1, 3],
                            explanation: "On-time payments, low balances, and a long history all help. Maxing out cards spikes your utilization and drags your score down."),
                        .matching(id: "u4l1q6", prompt: "Match each FICO score range to its rating.",
                            pairs: [
                            MatchPair(id: 0, left: "800–850", right: "Exceptional"),
                            MatchPair(id: 1, left: "670–739", right: "Good"),
                            MatchPair(id: 2, left: "580–669", right: "Fair"),
                            MatchPair(id: 3, left: "300–579", right: "Poor")
                            ],
                            explanation: "Roughly: 800+ is exceptional, 670–739 is good, 580–669 is fair, and under 580 is poor. Aim to keep climbing."),
                        .trueFalse(id: "u4l1q7", prompt: "A single hard inquiry usually only lowers your score by a few points.", correctIsTrue: true,
                            explanation: "One hard inquiry is a small, temporary dip. Missing payments does far more damage than a single application.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit4-lesson2",
                    title: "Credit Cards",
                    iconName: "creditcard.fill",
                    questions: [
                        .multipleChoice(id: "u4l2q1", prompt: "What does APR stand for on a credit card?",
                            choices: [
                            AnswerChoice(id: 0, text: "Annual Percentage Rate"),
                            AnswerChoice(id: 1, text: "Approved Payment Return"),
                            AnswerChoice(id: 2, text: "Average Purchase Reward"),
                            AnswerChoice(id: 3, text: "Automatic Payment Reminder")
                            ], correct: 0,
                            explanation: "APR is the Annual Percentage Rate — the yearly cost of carrying a balance on your card."),
                        .trueFalse(id: "u4l2q2", prompt: "If you pay your full statement balance by the due date, you typically pay no interest on your purchases.", correctIsTrue: true,
                            explanation: "That interest-free window is called the grace period — pay in full and the card is basically free to use."),
                        .multipleChoice(id: "u4l2q3", prompt: "What is the 'minimum payment trap'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Paying only the minimum keeps you in debt for years because most of it goes to interest"),
                            AnswerChoice(id: 1, text: "The bank forces you to pay extra fees each month"),
                            AnswerChoice(id: 2, text: "You can never pay more than the minimum"),
                            AnswerChoice(id: 3, text: "The minimum payment resets your credit score")
                            ], correct: 0,
                            explanation: "Paying just the minimum barely touches the balance — most goes to interest, so the debt can linger for years."),
                        .numeric(id: "u4l2q4", prompt: "Your card has a $2,000 limit and a $500 balance. What is your credit utilization, as a percent?", answer: 25, tolerance: 0, suffix: "%",
                            explanation: "Utilization is balance ÷ limit: $500 ÷ $2,000 = 25%."),
                        .numeric(id: "u4l2q5", prompt: "Experts suggest keeping your credit utilization below what percent to protect your score?", answer: 30, tolerance: 0, suffix: "%",
                            explanation: "Staying under 30% utilization tells lenders you're not leaning too hard on your available credit."),
                        .multiSelect(id: "u4l2q6", prompt: "Which are smart credit card habits? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Pay the statement balance in full each month"),
                            AnswerChoice(id: 1, text: "Keep your utilization low"),
                            AnswerChoice(id: 2, text: "Only ever pay the minimum"),
                            AnswerChoice(id: 3, text: "Set up autopay for at least the minimum")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Paying in full, keeping balances low, and automating payments keep you safe. Paying only the minimum is the trap to avoid."),
                        .matching(id: "u4l2q7", prompt: "Match each credit card term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "APR", right: "The yearly cost of borrowing"),
                            MatchPair(id: 1, left: "Grace period", right: "Interest-free window if you pay in full"),
                            MatchPair(id: 2, left: "Minimum payment", right: "Smallest amount due to stay current"),
                            MatchPair(id: 3, left: "Utilization", right: "Balance divided by credit limit")
                            ],
                            explanation: "Knowing these four terms is most of what you need to use a card without getting bitten.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit4-lesson3",
                    title: "Loans & Interest",
                    iconName: "percent",
                    questions: [
                        .matching(id: "u4l3q1", prompt: "Match each loan term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Principal", right: "The amount you originally borrow"),
                            MatchPair(id: 1, left: "Interest", right: "The extra you pay for borrowing"),
                            MatchPair(id: 2, left: "APR", right: "Yearly cost including interest and fees"),
                            MatchPair(id: 3, left: "Term", right: "How long you have to repay")
                            ],
                            explanation: "Principal is what you borrow, interest is the price of borrowing it, and the term is how long you take to pay it back."),
                        .numeric(id: "u4l3q2", prompt: "You borrow $1,000 at 5% simple interest for 1 year. How much interest do you owe?", answer: 50, tolerance: 0, prefix: "$",
                            explanation: "Simple interest is principal × rate × time: $1,000 × 5% × 1 = $50."),
                        .numeric(id: "u4l3q3", prompt: "You borrow $1,000 at 5% simple interest, but now for 2 years. How much total interest do you owe?", answer: 100, tolerance: 0, prefix: "$",
                            explanation: "$1,000 × 5% × 2 years = $100 — double the time means double the interest."),
                        .trueFalse(id: "u4l3q4", prompt: "With a fixed-rate amortizing loan, your early payments go mostly toward interest and later payments go mostly toward principal.", correctIsTrue: true,
                            explanation: "Early on you owe interest on a big balance, so most of the payment is interest. As the balance shrinks, more of each payment chips away the principal."),
                        .multipleChoice(id: "u4l3q5", prompt: "What is the principal of a loan?",
                            choices: [
                            AnswerChoice(id: 0, text: "The original amount you borrowed, before interest"),
                            AnswerChoice(id: 1, text: "The interest you pay each month"),
                            AnswerChoice(id: 2, text: "The bank that gave you the loan"),
                            AnswerChoice(id: 3, text: "The penalty for paying late")
                            ], correct: 0,
                            explanation: "The principal is the starting amount you borrowed — interest is charged on top of it."),
                        .ordering(id: "u4l3q6", prompt: "Same loan amount and same interest rate — order these from LEAST total interest paid to MOST.",
                            items: [
                            "1-year loan",
                            "3-year loan",
                            "5-year loan",
                            "7-year loan"
                            ],
                            explanation: "The longer you take to repay, the more total interest you rack up — even if the monthly payment feels smaller."),
                        .multipleChoice(id: "u4l3q7", prompt: "All else equal, which loan will cost you the most in total interest?",
                            choices: [
                            AnswerChoice(id: 0, text: "A higher APR with a longer term"),
                            AnswerChoice(id: 1, text: "A lower APR with a shorter term"),
                            AnswerChoice(id: 2, text: "A lower APR with a longer term"),
                            AnswerChoice(id: 3, text: "A higher APR with a shorter term")
                            ], correct: 0,
                            explanation: "A higher rate and more time both pile on interest — combine them and you pay the most overall.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit4-lesson4",
                    title: "Good Debt vs. Bad Debt",
                    iconName: "arrow.up.arrow.down",
                    questions: [
                        .categorize(id: "u4l4q1", prompt: "Sort each into 'Usually good debt' or 'Usually bad debt'.",
                            categories: ["Usually good debt", "Usually bad debt"],
                            items: [
                            CategoryItem(id: 0, text: "Mortgage on a home", correctCategory: "Usually good debt"),
                            CategoryItem(id: 1, text: "Student loan for a degree", correctCategory: "Usually good debt"),
                            CategoryItem(id: 2, text: "Payday loan", correctCategory: "Usually bad debt"),
                            CategoryItem(id: 3, text: "Credit card debt for a vacation", correctCategory: "Usually bad debt"),
                            CategoryItem(id: 4, text: "Small business loan", correctCategory: "Usually good debt")
                            ],
                            explanation: "Good debt buys things that build wealth or income at a reasonable rate. Bad debt is high-cost borrowing for things that lose value or get used up."),
                        .multipleChoice(id: "u4l4q2", prompt: "What generally makes a debt 'good' debt?",
                            choices: [
                            AnswerChoice(id: 0, text: "It helps you build wealth or income and usually has a lower interest rate"),
                            AnswerChoice(id: 1, text: "It always has to be paid back quickly"),
                            AnswerChoice(id: 2, text: "It comes from a friend instead of a bank"),
                            AnswerChoice(id: 3, text: "It never charges any interest")
                            ], correct: 0,
                            explanation: "Good debt is an investment in your future — like a home or education — at a manageable interest rate."),
                        .trueFalse(id: "u4l4q3", prompt: "Payday loans often carry extremely high APRs, sometimes around 400%.", correctIsTrue: true,
                            explanation: "Payday loans look small but their fees translate to sky-high APRs — that's why they're classic bad debt."),
                        .multipleChoice(id: "u4l4q4", prompt: "What does it mean to 'default' on a loan?",
                            choices: [
                            AnswerChoice(id: 0, text: "Failing to make your payments as agreed"),
                            AnswerChoice(id: 1, text: "Paying the loan off early"),
                            AnswerChoice(id: 2, text: "Refinancing to a lower rate"),
                            AnswerChoice(id: 3, text: "Making an extra payment")
                            ], correct: 0,
                            explanation: "Defaulting means you've stopped paying as promised — a serious step that hurts your credit and can trigger collections."),
                        .multiSelect(id: "u4l4q5", prompt: "Which are possible consequences of defaulting on a loan? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Damage to your credit score"),
                            AnswerChoice(id: 1, text: "Your account sent to collections"),
                            AnswerChoice(id: 2, text: "Possible wage garnishment"),
                            AnswerChoice(id: 3, text: "Your credit score automatically jumps to 850")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Default can wreck your credit, send your debt to collectors, and even lead to garnished wages. It definitely won't boost your score."),
                        .matching(id: "u4l4q6", prompt: "Match each debt to how it's usually classified.",
                            pairs: [
                            MatchPair(id: 0, left: "Mortgage", right: "Often good debt"),
                            MatchPair(id: 1, left: "Payday loan", right: "Usually bad debt"),
                            MatchPair(id: 2, left: "Federal student loan", right: "Often good debt"),
                            MatchPair(id: 3, left: "High-interest card balance", right: "Usually bad debt")
                            ],
                            explanation: "Low-rate borrowing that builds an asset tends to be good; high-rate borrowing for spending tends to be bad."),
                        .numeric(id: "u4l4q7", prompt: "A payday lender charges $15 in fees for every $100 borrowed. On a $200 loan, how many dollars in fees do you pay?", answer: 30, tolerance: 0, prefix: "$",
                            explanation: "$15 per $100 × 2 = $30 in fees for just two weeks — which works out to a shockingly high APR.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit4-lesson5",
                    title: "Getting Out of Debt",
                    iconName: "chart.line.downtrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u4l5q1", prompt: "In the debt 'avalanche' method, which debt do you attack first?",
                            choices: [
                            AnswerChoice(id: 0, text: "The one with the highest interest rate"),
                            AnswerChoice(id: 1, text: "The one with the smallest balance"),
                            AnswerChoice(id: 2, text: "The newest debt you took on"),
                            AnswerChoice(id: 3, text: "The one with the friendliest lender")
                            ], correct: 0,
                            explanation: "The avalanche targets the highest interest rate first, which saves you the most money over time."),
                        .multipleChoice(id: "u4l5q2", prompt: "In the debt 'snowball' method, which debt do you pay off first?",
                            choices: [
                            AnswerChoice(id: 0, text: "The one with the smallest balance"),
                            AnswerChoice(id: 1, text: "The one with the highest interest rate"),
                            AnswerChoice(id: 2, text: "The largest debt you owe"),
                            AnswerChoice(id: 3, text: "Whichever is due first")
                            ], correct: 0,
                            explanation: "The snowball knocks out the smallest balance first, giving you a quick win to stay motivated."),
                        .trueFalse(id: "u4l5q3", prompt: "The avalanche method saves you the most money in interest over time.", correctIsTrue: true,
                            explanation: "By killing the highest-rate debt first, the avalanche minimizes the total interest you pay."),
                        .multipleChoice(id: "u4l5q4", prompt: "Why do some people prefer the snowball method even though it can cost a little more?",
                            choices: [
                            AnswerChoice(id: 0, text: "Quick early wins keep them motivated to keep going"),
                            AnswerChoice(id: 1, text: "It's the only method banks allow"),
                            AnswerChoice(id: 2, text: "It always pays off debt faster than avalanche"),
                            AnswerChoice(id: 3, text: "It erases interest completely")
                            ], correct: 0,
                            explanation: "Paying off a whole debt fast feels great, and that momentum helps many people stick with the plan."),
                        .ordering(id: "u4l5q5", prompt: "You're using the avalanche method. Order these debts by which you'd pay off first (highest rate first).",
                            items: [
                            "Payday loan (25% APR)",
                            "Credit card (19% APR)",
                            "Car loan (7% APR)",
                            "Student loan (4% APR)"
                            ],
                            explanation: "Avalanche always chases the highest interest rate first, then works down — that's the cheapest path out."),
                        .multiSelect(id: "u4l5q6", prompt: "Which are smart steps when getting out of debt? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Always pay at least the minimum on every debt"),
                            AnswerChoice(id: 1, text: "List your debts with their rates and balances"),
                            AnswerChoice(id: 2, text: "Stop making any payments until you've saved a lump sum"),
                            AnswerChoice(id: 3, text: "Put any extra money toward one target debt at a time")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Always cover every minimum, map out your debts, and focus extra cash on one target. Skipping payments just adds fees and damages your credit."),
                        .matching(id: "u4l5q7", prompt: "Match each payoff idea to its defining rule.",
                            pairs: [
                            MatchPair(id: 0, left: "Snowball", right: "Smallest balance first"),
                            MatchPair(id: 1, left: "Avalanche", right: "Highest interest rate first"),
                            MatchPair(id: 2, left: "Minimum payment", right: "Pay on every debt to avoid penalties")
                            ],
                            explanation: "Snowball chases small balances, avalanche chases high rates, and minimums keep every account in good standing while you focus your extra money.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit4-check",
                    title: "Credit & Debt: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .numeric(id: "u4l1q2-kc", prompt: "A FICO credit score ranges from a low of 300 up to a high of what number?", answer: 850, tolerance: 0,
                            explanation: "FICO scores run from 300 to 850 — the higher you climb, the better the rates lenders offer you."),
                        .categorize(id: "u4l1q4-kc", prompt: "Sort each action into whether it's a soft inquiry (no score impact) or a hard inquiry (can ding your score).",
                            categories: ["Soft inquiry", "Hard inquiry"],
                            items: [
                            CategoryItem(id: 0, text: "Checking your own credit score", correctCategory: "Soft inquiry"),
                            CategoryItem(id: 1, text: "Applying for a new credit card", correctCategory: "Hard inquiry"),
                            CategoryItem(id: 2, text: "Getting a pre-approved offer in the mail", correctCategory: "Soft inquiry"),
                            CategoryItem(id: 3, text: "Taking out an auto loan", correctCategory: "Hard inquiry")
                            ],
                            explanation: "Soft inquiries — like peeking at your own score — never hurt you. Hard inquiries happen when you actually apply for credit and can shave off a few points."),
                        .matching(id: "u4l1q6-kc", prompt: "Match each FICO score range to its rating.",
                            pairs: [
                            MatchPair(id: 0, left: "800–850", right: "Exceptional"),
                            MatchPair(id: 1, left: "670–739", right: "Good"),
                            MatchPair(id: 2, left: "580–669", right: "Fair"),
                            MatchPair(id: 3, left: "300–579", right: "Poor")
                            ],
                            explanation: "Roughly: 800+ is exceptional, 670–739 is good, 580–669 is fair, and under 580 is poor. Aim to keep climbing."),
                        .trueFalse(id: "u4l2q2-kc", prompt: "If you pay your full statement balance by the due date, you typically pay no interest on your purchases.", correctIsTrue: true,
                            explanation: "That interest-free window is called the grace period — pay in full and the card is basically free to use."),
                        .numeric(id: "u4l2q4-kc", prompt: "Your card has a $2,000 limit and a $500 balance. What is your credit utilization, as a percent?", answer: 25, tolerance: 0, suffix: "%",
                            explanation: "Utilization is balance ÷ limit: $500 ÷ $2,000 = 25%."),
                        .multiSelect(id: "u4l2q6-kc", prompt: "Which are smart credit card habits? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Pay the statement balance in full each month"),
                            AnswerChoice(id: 1, text: "Keep your utilization low"),
                            AnswerChoice(id: 2, text: "Only ever pay the minimum"),
                            AnswerChoice(id: 3, text: "Set up autopay for at least the minimum")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Paying in full, keeping balances low, and automating payments keep you safe. Paying only the minimum is the trap to avoid."),
                        .numeric(id: "u4l3q2-kc", prompt: "You borrow $1,000 at 5% simple interest for 1 year. How much interest do you owe?", answer: 50, tolerance: 0, prefix: "$",
                            explanation: "Simple interest is principal × rate × time: $1,000 × 5% × 1 = $50."),
                        .trueFalse(id: "u4l3q4-kc", prompt: "With a fixed-rate amortizing loan, your early payments go mostly toward interest and later payments go mostly toward principal.", correctIsTrue: true,
                            explanation: "Early on you owe interest on a big balance, so most of the payment is interest. As the balance shrinks, more of each payment chips away the principal."),
                        .ordering(id: "u4l3q6-kc", prompt: "Same loan amount and same interest rate — order these from LEAST total interest paid to MOST.",
                            items: [
                            "1-year loan",
                            "3-year loan",
                            "5-year loan",
                            "7-year loan"
                            ],
                            explanation: "The longer you take to repay, the more total interest you rack up — even if the monthly payment feels smaller."),
                        .multipleChoice(id: "u4l4q2-kc", prompt: "What generally makes a debt 'good' debt?",
                            choices: [
                            AnswerChoice(id: 0, text: "It helps you build wealth or income and usually has a lower interest rate"),
                            AnswerChoice(id: 1, text: "It always has to be paid back quickly"),
                            AnswerChoice(id: 2, text: "It comes from a friend instead of a bank"),
                            AnswerChoice(id: 3, text: "It never charges any interest")
                            ], correct: 0,
                            explanation: "Good debt is an investment in your future — like a home or education — at a manageable interest rate."),
                        .multipleChoice(id: "u4l4q4-kc", prompt: "What does it mean to 'default' on a loan?",
                            choices: [
                            AnswerChoice(id: 0, text: "Failing to make your payments as agreed"),
                            AnswerChoice(id: 1, text: "Paying the loan off early"),
                            AnswerChoice(id: 2, text: "Refinancing to a lower rate"),
                            AnswerChoice(id: 3, text: "Making an extra payment")
                            ], correct: 0,
                            explanation: "Defaulting means you've stopped paying as promised — a serious step that hurts your credit and can trigger collections."),
                        .matching(id: "u4l4q6-kc", prompt: "Match each debt to how it's usually classified.",
                            pairs: [
                            MatchPair(id: 0, left: "Mortgage", right: "Often good debt"),
                            MatchPair(id: 1, left: "Payday loan", right: "Usually bad debt"),
                            MatchPair(id: 2, left: "Federal student loan", right: "Often good debt"),
                            MatchPair(id: 3, left: "High-interest card balance", right: "Usually bad debt")
                            ],
                            explanation: "Low-rate borrowing that builds an asset tends to be good; high-rate borrowing for spending tends to be bad."),
                        .multipleChoice(id: "u4l5q2-kc", prompt: "In the debt 'snowball' method, which debt do you pay off first?",
                            choices: [
                            AnswerChoice(id: 0, text: "The one with the smallest balance"),
                            AnswerChoice(id: 1, text: "The one with the highest interest rate"),
                            AnswerChoice(id: 2, text: "The largest debt you owe"),
                            AnswerChoice(id: 3, text: "Whichever is due first")
                            ], correct: 0,
                            explanation: "The snowball knocks out the smallest balance first, giving you a quick win to stay motivated."),
                        .multipleChoice(id: "u4l5q4-kc", prompt: "Why do some people prefer the snowball method even though it can cost a little more?",
                            choices: [
                            AnswerChoice(id: 0, text: "Quick early wins keep them motivated to keep going"),
                            AnswerChoice(id: 1, text: "It's the only method banks allow"),
                            AnswerChoice(id: 2, text: "It always pays off debt faster than avalanche"),
                            AnswerChoice(id: 3, text: "It erases interest completely")
                            ], correct: 0,
                            explanation: "Paying off a whole debt fast feels great, and that momentum helps many people stick with the plan."),
                        .multiSelect(id: "u4l5q6-kc", prompt: "Which are smart steps when getting out of debt? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Always pay at least the minimum on every debt"),
                            AnswerChoice(id: 1, text: "List your debts with their rates and balances"),
                            AnswerChoice(id: 2, text: "Stop making any payments until you've saved a lump sum"),
                            AnswerChoice(id: 3, text: "Put any extra money toward one target debt at a time")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Always cover every minimum, map out your debts, and focus extra cash on one target. Skipping payments just adds fees and damages your credit.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let powerOfTime = LearningUnit(
            id: "unit5",
            title: "Unit 4: The Power of Time",
            subtitle: "Compound growth and starting early",
            colorHex: "FF6B4A",
            lessons: [
                Lesson(
                    id: "unit5-lesson1",
                    title: "Compound Interest",
                    iconName: "chart.line.uptrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u5l1q1", prompt: "What is compound interest?",
                            choices: [
                            AnswerChoice(id: 0, text: "Interest earned on your original money AND on the interest it has already earned"),
                            AnswerChoice(id: 1, text: "Interest paid only on the money you first put in"),
                            AnswerChoice(id: 2, text: "A one-time bonus banks give new customers"),
                            AnswerChoice(id: 3, text: "A fee charged when you withdraw savings")
                            ], correct: 0,
                            explanation: "Compound interest means your interest earns interest too. Over time that snowball effect makes your money grow faster and faster."),
                        .trueFalse(id: "u5l1q2", prompt: "Compound interest can also work against you when you carry a balance on a credit card.", correctIsTrue: true,
                            explanation: "Debt compounds too. Unpaid interest gets added to what you owe, so the balance you're charged interest on keeps growing."),
                        .numeric(id: "u5l1q3", prompt: "You invest $1,000 at 10% compounded once a year. How many dollars do you have after 2 years?", answer: 1210, tolerance: 0, prefix: "$",
                            explanation: "Year 1: $1,000 grows to $1,100. Year 2: that $1,100 grows to $1,210 — the extra $10 is interest earning interest."),
                        .multipleChoice(id: "u5l1q4", prompt: "You put $1,000 in two accounts at the same 10% rate. Which ends up with more after several years?",
                            choices: [
                            AnswerChoice(id: 0, text: "The compound-interest account"),
                            AnswerChoice(id: 1, text: "The simple-interest account"),
                            AnswerChoice(id: 2, text: "They always tie exactly"),
                            AnswerChoice(id: 3, text: "Neither earns anything")
                            ], correct: 0,
                            explanation: "Simple interest pays only on your original $1,000 each year. Compound interest pays on the growing balance, so it pulls ahead and the gap widens over time."),
                        .matching(id: "u5l1q5", prompt: "Match each compound-interest term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Principal", right: "The original amount you invest or borrow"),
                            MatchPair(id: 1, left: "Interest rate", right: "The percentage your money grows each period"),
                            MatchPair(id: 2, left: "Compounding", right: "Earning interest on your interest"),
                            MatchPair(id: 3, left: "Balance", right: "The total amount your account is worth right now")
                            ],
                            explanation: "Principal is your starting money, the rate is how fast it grows, compounding is interest on interest, and the balance is the running total."),
                        .multiSelect(id: "u5l1q6", prompt: "Which of these make compound interest work harder for you? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Starting as early as you can"),
                            AnswerChoice(id: 1, text: "Leaving your earnings invested instead of spending them"),
                            AnswerChoice(id: 2, text: "A higher interest rate"),
                            AnswerChoice(id: 3, text: "Withdrawing your interest every year")
                            ], correctIDs: [0, 1, 2],
                            explanation: "More time, reinvested earnings, and a higher rate all feed the snowball. Cashing out your interest every year stops it from compounding."),
                        .ordering(id: "u5l1q7", prompt: "Put these interest rates in order by how much a $1,000 investment earns over 10 years, least to most.",
                            items: [
                            "2% per year",
                            "5% per year",
                            "8% per year",
                            "12% per year"
                            ],
                            explanation: "A higher rate compounds faster, so the higher the rate the more interest you pile up over the same 10 years.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit5-lesson2",
                    title: "The Rule of 72",
                    iconName: "divide.circle.fill",
                    questions: [
                        .multipleChoice(id: "u5l2q1", prompt: "What does the Rule of 72 help you estimate?",
                            choices: [
                            AnswerChoice(id: 0, text: "Roughly how many years it takes your money to double"),
                            AnswerChoice(id: 1, text: "Exactly how much tax you'll owe"),
                            AnswerChoice(id: 2, text: "The best stock to buy"),
                            AnswerChoice(id: 3, text: "How much to spend each month")
                            ], correct: 0,
                            explanation: "Divide 72 by your yearly interest rate and you get a quick estimate of how many years it takes an investment to double."),
                        .numeric(id: "u5l2q2", prompt: "At an 8% yearly return, about how many years does it take your money to double?", answer: 9, tolerance: 0, suffix: " years",
                            explanation: "72 ÷ 8 = 9. So money growing at 8% a year doubles in roughly 9 years."),
                        .matching(id: "u5l2q3", prompt: "Match each yearly return to its approximate doubling time using the Rule of 72.",
                            pairs: [
                            MatchPair(id: 0, left: "4%", right: "18 years"),
                            MatchPair(id: 1, left: "6%", right: "12 years"),
                            MatchPair(id: 2, left: "9%", right: "8 years"),
                            MatchPair(id: 3, left: "12%", right: "6 years")
                            ],
                            explanation: "Just divide 72 by the rate: 72÷4=18, 72÷6=12, 72÷9=8, and 72÷12=6."),
                        .numeric(id: "u5l2q4", prompt: "You want your money to double in about 6 years. Roughly what yearly return do you need?", answer: 12, tolerance: 0, suffix: "%",
                            explanation: "Flip the rule around: 72 ÷ 6 years = 12%. You'd need about a 12% yearly return."),
                        .trueFalse(id: "u5l2q5", prompt: "The Rule of 72 can also estimate how fast rising prices (inflation) cut your money's value in half.", correctIsTrue: true,
                            explanation: "The same math works for anything that grows by a percentage — including inflation eating away at what your dollars can buy."),
                        .multipleChoice(id: "u5l2q6", prompt: "At a 3% yearly return, about how long does it take money to double?",
                            choices: [
                            AnswerChoice(id: 0, text: "24 years"),
                            AnswerChoice(id: 1, text: "12 years"),
                            AnswerChoice(id: 2, text: "6 years"),
                            AnswerChoice(id: 3, text: "36 years")
                            ], correct: 0,
                            explanation: "72 ÷ 3 = 24. Low returns mean a long wait — about 24 years to double at 3%."),
                        .categorize(id: "u5l2q7", prompt: "Using the Rule of 72, sort each yearly return by how long it takes money to double.",
                            categories: ["Doubles in under 10 years", "Doubles in 10 years or more"],
                            items: [
                            CategoryItem(id: 0, text: "10%", correctCategory: "Doubles in under 10 years"),
                            CategoryItem(id: 1, text: "8%", correctCategory: "Doubles in under 10 years"),
                            CategoryItem(id: 2, text: "12%", correctCategory: "Doubles in under 10 years"),
                            CategoryItem(id: 3, text: "6%", correctCategory: "Doubles in 10 years or more"),
                            CategoryItem(id: 4, text: "4%", correctCategory: "Doubles in 10 years or more"),
                            CategoryItem(id: 5, text: "3%", correctCategory: "Doubles in 10 years or more")
                            ],
                            explanation: "72÷10≈7.2, 72÷8=9, 72÷12=6 all beat 10 years; 72÷6=12, 72÷4=18, 72÷3=24 all take 10 years or more.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit5-lesson3",
                    title: "Starting Early",
                    iconName: "hourglass",
                    questions: [
                        .multipleChoice(id: "u5l3q1", prompt: "When it comes to growing wealth, what usually matters most?",
                            choices: [
                            AnswerChoice(id: 0, text: "How early you start, because time lets money compound"),
                            AnswerChoice(id: 1, text: "Picking the single perfect stock"),
                            AnswerChoice(id: 2, text: "Being born rich"),
                            AnswerChoice(id: 3, text: "Waiting until you earn a lot before you invest")
                            ], correct: 0,
                            explanation: "Time is the secret ingredient. The earlier you start, the more years compounding has to turn small amounts into a lot."),
                        .trueFalse(id: "u5l3q2", prompt: "Someone who invests from age 18 to 28 and then stops can end up with more than someone who starts at 28 and invests for decades.", correctIsTrue: true,
                            explanation: "This is the classic early-saver surprise: the head start gives the early investor's money extra years to compound, which can beat a bigger total invested later."),
                        .numeric(id: "u5l3q3", prompt: "Early Erin invests $200 a month for 10 years, then stops. How many dollars did she personally put in?", answer: 24000, tolerance: 0, prefix: "$",
                            explanation: "$200 × 12 months × 10 years = $24,000. That's all Erin ever contributes — the rest of her growth comes from compounding."),
                        .numeric(id: "u5l3q4", prompt: "Late Liam invests $200 a month from age 28 to 65 — that's 37 years. How many dollars does he personally put in?", answer: 88800, tolerance: 0, prefix: "$",
                            explanation: "$200 × 12 × 37 = $88,800. Liam contributes far more than Erin, yet her early start can still put her ahead."),
                        .multipleChoice(id: "u5l3q5", prompt: "Why can an early starter end up ahead even after investing fewer total dollars?",
                            choices: [
                            AnswerChoice(id: 0, text: "Their money has many more years to compound"),
                            AnswerChoice(id: 1, text: "Early investors get a secret higher rate"),
                            AnswerChoice(id: 2, text: "Banks reward youth with free money"),
                            AnswerChoice(id: 3, text: "Older investors pay a penalty")
                            ], correct: 0,
                            explanation: "Extra decades of compounding do the heavy lifting. Time in the market beats the amount you put in."),
                        .multiSelect(id: "u5l3q6", prompt: "Which habits help you take full advantage of time? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Start investing as early as possible"),
                            AnswerChoice(id: 1, text: "Invest consistently, even small amounts"),
                            AnswerChoice(id: 2, text: "Leave your money invested to keep compounding"),
                            AnswerChoice(id: 3, text: "Wait many years before you begin")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Start early, stay consistent, and let it ride — those three give compounding the years it needs. Waiting just throws that time away."),
                        .ordering(id: "u5l3q7", prompt: "Put these savers in order by the total dollars they personally contribute, least to most.",
                            items: [
                            "Erin: $200/month for 10 years",
                            "Maya: $200/month for 20 years",
                            "Liam: $200/month for 37 years"
                            ],
                            explanation: "$24,000 vs $48,000 vs $88,800. Erin puts in the least — yet starting first gives her money the most time to grow.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit5-lesson4",
                    title: "Dollar-Cost Averaging",
                    iconName: "calendar.badge.clock",
                    questions: [
                        .multipleChoice(id: "u5l4q1", prompt: "What is dollar-cost averaging?",
                            choices: [
                            AnswerChoice(id: 0, text: "Investing a fixed dollar amount on a regular schedule, no matter the price"),
                            AnswerChoice(id: 1, text: "Investing everything you have the moment you get it"),
                            AnswerChoice(id: 2, text: "Only buying when prices are at their lowest"),
                            AnswerChoice(id: 3, text: "Selling a little bit every month")
                            ], correct: 0,
                            explanation: "You put in the same amount on a set schedule — say $100 every month — regardless of whether prices are up or down."),
                        .trueFalse(id: "u5l4q2", prompt: "With dollar-cost averaging, a fixed amount of money buys more shares when the price is low and fewer when it's high.", correctIsTrue: true,
                            explanation: "Because your dollars are fixed, a lower price stretches further and buys more shares — automatically leaning into cheap prices."),
                        .numeric(id: "u5l4q3", prompt: "You invest $120 this month and the share price is $12. How many shares do you buy?", answer: 10, tolerance: 0, suffix: " shares",
                            explanation: "$120 ÷ $12 = 10 shares."),
                        .numeric(id: "u5l4q4", prompt: "Next month you invest another $120, but the price has dropped to $6. How many shares do you buy now?", answer: 20, tolerance: 0, suffix: " shares",
                            explanation: "$120 ÷ $6 = 20 shares. The same $120 bought twice as many shares because the price fell."),
                        .numeric(id: "u5l4q5", prompt: "Over those two months you invested $240 and now own 30 shares. What average price did you pay per share?", answer: 8, tolerance: 0, prefix: "$",
                            explanation: "$240 ÷ 30 shares = $8 per share — lower than the simple average of $12 and $6 ($9), because you bought more shares when cheap."),
                        .multiSelect(id: "u5l4q6", prompt: "Which are real benefits of dollar-cost averaging? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It takes the pressure off trying to time the market perfectly"),
                            AnswerChoice(id: 1, text: "It automatically buys more shares when prices are low"),
                            AnswerChoice(id: 2, text: "It builds a steady investing habit"),
                            AnswerChoice(id: 3, text: "It guarantees you'll never lose money")
                            ], correctIDs: [0, 1, 2],
                            explanation: "DCA removes timing stress, leans into low prices, and builds discipline — but no strategy guarantees a profit."),
                        .ordering(id: "u5l4q7", prompt: "Order the steps to set up a dollar-cost averaging plan.",
                            items: [
                            "Pick an amount you can invest regularly",
                            "Choose a fixed schedule, like every month",
                            "Invest that amount every period no matter the price",
                            "Keep it going through the ups and downs"
                            ],
                            explanation: "Decide the amount, set the schedule, invest on autopilot, and stay consistent — that's dollar-cost averaging.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit5-lesson5",
                    title: "Setting Financial Goals",
                    iconName: "target",
                    questions: [
                        .multipleChoice(id: "u5l5q1", prompt: "In a SMART goal, what does the 'M' stand for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Measurable"),
                            AnswerChoice(id: 1, text: "Money"),
                            AnswerChoice(id: 2, text: "Maximum"),
                            AnswerChoice(id: 3, text: "Mandatory")
                            ], correct: 0,
                            explanation: "Measurable means you can track progress with a number — like saving $1,200 — so you know when you've hit it."),
                        .matching(id: "u5l5q2", prompt: "Match each letter of SMART to what it stands for.",
                            pairs: [
                            MatchPair(id: 0, left: "S", right: "Specific"),
                            MatchPair(id: 1, left: "A", right: "Achievable"),
                            MatchPair(id: 2, left: "R", right: "Relevant"),
                            MatchPair(id: 3, left: "T", right: "Time-bound")
                            ],
                            explanation: "SMART goals are Specific, Measurable, Achievable, Relevant, and Time-bound — clear targets you can actually reach."),
                        .categorize(id: "u5l5q3", prompt: "Sort each goal by whether you'd keep the money safe in savings or invest it for growth.",
                            categories: ["Save (short-term)", "Invest (long-term)"],
                            items: [
                            CategoryItem(id: 0, text: "Spring break trip in 4 months", correctCategory: "Save (short-term)"),
                            CategoryItem(id: 1, text: "New laptop in 6 months", correctCategory: "Save (short-term)"),
                            CategoryItem(id: 2, text: "Holiday gifts this December", correctCategory: "Save (short-term)"),
                            CategoryItem(id: 3, text: "Retirement in 45 years", correctCategory: "Invest (long-term)"),
                            CategoryItem(id: 4, text: "House down payment in 15 years", correctCategory: "Invest (long-term)"),
                            CategoryItem(id: 5, text: "College fund for a baby born today", correctCategory: "Invest (long-term)")
                            ],
                            explanation: "Money you need soon should stay safe in savings; money you won't touch for years can be invested to grow and ride out the ups and downs."),
                        .trueFalse(id: "u5l5q4", prompt: "Money you'll need in just a few months is best put in stocks so it can grow as much as possible.", correctIsTrue: false,
                            explanation: "Stocks can drop right when you need the cash. Short-term money belongs somewhere safe, like a savings account."),
                        .multipleChoice(id: "u5l5q5", prompt: "Why invest rather than just save for a goal that's decades away?",
                            choices: [
                            AnswerChoice(id: 0, text: "You have time to ride out market dips and let compounding grow your money"),
                            AnswerChoice(id: 1, text: "Savings accounts are illegal for long goals"),
                            AnswerChoice(id: 2, text: "Investing has no risk over long periods"),
                            AnswerChoice(id: 3, text: "It's the only way to open an account")
                            ], correct: 0,
                            explanation: "A long time horizon lets you weather market ups and downs and gives compounding years to work — so growth investments make sense."),
                        .numeric(id: "u5l5q6", prompt: "Your SMART goal is to save $1,200 for a laptop in 12 months. How many dollars must you save each month?", answer: 100, tolerance: 0, prefix: "$",
                            explanation: "$1,200 ÷ 12 months = $100 a month. Breaking a goal into monthly steps makes it Achievable and Time-bound."),
                        .multiSelect(id: "u5l5q7", prompt: "Which of these make a goal 'SMART'? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It's specific and measurable"),
                            AnswerChoice(id: 1, text: "It has a clear deadline"),
                            AnswerChoice(id: 2, text: "It's realistic for your income"),
                            AnswerChoice(id: 3, text: "It's vague, like 'save more someday'")
                            ], correctIDs: [0, 1, 2],
                            explanation: "SMART goals are clear, have a deadline, and are realistic. 'Save more someday' is too fuzzy to act on or track.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit5-check",
                    title: "The Power of Time: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u5l1q2-kc", prompt: "Compound interest can also work against you when you carry a balance on a credit card.", correctIsTrue: true,
                            explanation: "Debt compounds too. Unpaid interest gets added to what you owe, so the balance you're charged interest on keeps growing."),
                        .multipleChoice(id: "u5l1q4-kc", prompt: "You put $1,000 in two accounts at the same 10% rate. Which ends up with more after several years?",
                            choices: [
                            AnswerChoice(id: 0, text: "The compound-interest account"),
                            AnswerChoice(id: 1, text: "The simple-interest account"),
                            AnswerChoice(id: 2, text: "They always tie exactly"),
                            AnswerChoice(id: 3, text: "Neither earns anything")
                            ], correct: 0,
                            explanation: "Simple interest pays only on your original $1,000 each year. Compound interest pays on the growing balance, so it pulls ahead and the gap widens over time."),
                        .multiSelect(id: "u5l1q6-kc", prompt: "Which of these make compound interest work harder for you? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Starting as early as you can"),
                            AnswerChoice(id: 1, text: "Leaving your earnings invested instead of spending them"),
                            AnswerChoice(id: 2, text: "A higher interest rate"),
                            AnswerChoice(id: 3, text: "Withdrawing your interest every year")
                            ], correctIDs: [0, 1, 2],
                            explanation: "More time, reinvested earnings, and a higher rate all feed the snowball. Cashing out your interest every year stops it from compounding."),
                        .numeric(id: "u5l2q2-kc", prompt: "At an 8% yearly return, about how many years does it take your money to double?", answer: 9, tolerance: 0, suffix: " years",
                            explanation: "72 ÷ 8 = 9. So money growing at 8% a year doubles in roughly 9 years."),
                        .numeric(id: "u5l2q4-kc", prompt: "You want your money to double in about 6 years. Roughly what yearly return do you need?", answer: 12, tolerance: 0, suffix: "%",
                            explanation: "Flip the rule around: 72 ÷ 6 years = 12%. You'd need about a 12% yearly return."),
                        .multipleChoice(id: "u5l2q6-kc", prompt: "At a 3% yearly return, about how long does it take money to double?",
                            choices: [
                            AnswerChoice(id: 0, text: "24 years"),
                            AnswerChoice(id: 1, text: "12 years"),
                            AnswerChoice(id: 2, text: "6 years"),
                            AnswerChoice(id: 3, text: "36 years")
                            ], correct: 0,
                            explanation: "72 ÷ 3 = 24. Low returns mean a long wait — about 24 years to double at 3%."),
                        .trueFalse(id: "u5l3q2-kc", prompt: "Someone who invests from age 18 to 28 and then stops can end up with more than someone who starts at 28 and invests for decades.", correctIsTrue: true,
                            explanation: "This is the classic early-saver surprise: the head start gives the early investor's money extra years to compound, which can beat a bigger total invested later."),
                        .numeric(id: "u5l3q4-kc", prompt: "Late Liam invests $200 a month from age 28 to 65 — that's 37 years. How many dollars does he personally put in?", answer: 88800, tolerance: 0, prefix: "$",
                            explanation: "$200 × 12 × 37 = $88,800. Liam contributes far more than Erin, yet her early start can still put her ahead."),
                        .multiSelect(id: "u5l3q6-kc", prompt: "Which habits help you take full advantage of time? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Start investing as early as possible"),
                            AnswerChoice(id: 1, text: "Invest consistently, even small amounts"),
                            AnswerChoice(id: 2, text: "Leave your money invested to keep compounding"),
                            AnswerChoice(id: 3, text: "Wait many years before you begin")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Start early, stay consistent, and let it ride — those three give compounding the years it needs. Waiting just throws that time away."),
                        .trueFalse(id: "u5l4q2-kc", prompt: "With dollar-cost averaging, a fixed amount of money buys more shares when the price is low and fewer when it's high.", correctIsTrue: true,
                            explanation: "Because your dollars are fixed, a lower price stretches further and buys more shares — automatically leaning into cheap prices."),
                        .numeric(id: "u5l4q4-kc", prompt: "Next month you invest another $120, but the price has dropped to $6. How many shares do you buy now?", answer: 20, tolerance: 0, suffix: " shares",
                            explanation: "$120 ÷ $6 = 20 shares. The same $120 bought twice as many shares because the price fell."),
                        .multiSelect(id: "u5l4q6-kc", prompt: "Which are real benefits of dollar-cost averaging? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It takes the pressure off trying to time the market perfectly"),
                            AnswerChoice(id: 1, text: "It automatically buys more shares when prices are low"),
                            AnswerChoice(id: 2, text: "It builds a steady investing habit"),
                            AnswerChoice(id: 3, text: "It guarantees you'll never lose money")
                            ], correctIDs: [0, 1, 2],
                            explanation: "DCA removes timing stress, leans into low prices, and builds discipline — but no strategy guarantees a profit."),
                        .matching(id: "u5l5q2-kc", prompt: "Match each letter of SMART to what it stands for.",
                            pairs: [
                            MatchPair(id: 0, left: "S", right: "Specific"),
                            MatchPair(id: 1, left: "A", right: "Achievable"),
                            MatchPair(id: 2, left: "R", right: "Relevant"),
                            MatchPair(id: 3, left: "T", right: "Time-bound")
                            ],
                            explanation: "SMART goals are Specific, Measurable, Achievable, Relevant, and Time-bound — clear targets you can actually reach."),
                        .trueFalse(id: "u5l5q4-kc", prompt: "Money you'll need in just a few months is best put in stocks so it can grow as much as possible.", correctIsTrue: false,
                            explanation: "Stocks can drop right when you need the cash. Short-term money belongs somewhere safe, like a savings account."),
                        .numeric(id: "u5l5q6-kc", prompt: "Your SMART goal is to save $1,200 for a laptop in 12 months. How many dollars must you save each month?", answer: 100, tolerance: 0, prefix: "$",
                            explanation: "$1,200 ÷ 12 months = $100 a month. Breaking a goal into monthly steps makes it Achievable and Time-bound.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let investingFoundations = LearningUnit(
            id: "unit2",
            title: "Unit 5: Investing Foundations",
            subtitle: "Stocks, bonds, risk, and portfolios",
            colorHex: "4361EE",
            lessons: [
                Lesson(
                    id: "unit2-lesson1",
                    title: "What Is a Stock?",
                    iconName: "chart.line.uptrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u2l1q1", prompt: "What does owning a share of stock represent?",
                            choices: [
                            AnswerChoice(id: 0, text: "A small piece of ownership in a company"),
                            AnswerChoice(id: 1, text: "A loan you made to a company"),
                            AnswerChoice(id: 2, text: "A guaranteed fixed payment every year"),
                            AnswerChoice(id: 3, text: "A membership fee to shop at a store")
                            ], correct: 0,
                            explanation: "A share makes you a part-owner, called a shareholder, of the company."),
                        .trueFalse(id: "u2l1q2", prompt: "People who own shares of a company are called shareholders.", correctIsTrue: true,
                            explanation: "Owning shares gives you a slice of the company, which is exactly what a shareholder is."),
                        .matching(id: "u2l1q3", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Share", right: "One unit of ownership in a company"),
                            MatchPair(id: 1, left: "Shareholder", right: "A person who owns shares"),
                            MatchPair(id: 2, left: "Stock exchange", right: "A marketplace where shares are bought and sold"),
                            MatchPair(id: 3, left: "Dividend", right: "A share of profits paid to shareholders")
                            ],
                            explanation: "These four terms are the building blocks of how stock ownership works."),
                        .multipleChoice(id: "u2l1q4", prompt: "Where are most public company stocks bought and sold?",
                            choices: [
                            AnswerChoice(id: 0, text: "On stock exchanges like the NYSE or Nasdaq"),
                            AnswerChoice(id: 1, text: "At the company's front desk"),
                            AnswerChoice(id: 2, text: "Only inside local banks"),
                            AnswerChoice(id: 3, text: "Through the post office")
                            ], correct: 0,
                            explanation: "Exchanges like the NYSE and Nasdaq match up buyers and sellers of shares."),
                        .multiSelect(id: "u2l1q5", prompt: "Which of these can happen when you own shares of a company? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "You may receive dividends"),
                            AnswerChoice(id: 1, text: "You may get voting rights on some decisions"),
                            AnswerChoice(id: 2, text: "Your share value can rise or fall"),
                            AnswerChoice(id: 3, text: "The company guarantees you can never lose money")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Ownership can bring dividends, votes, and price changes, but never a guarantee against loss."),
                        .numeric(id: "u2l1q6", prompt: "A company splits its ownership into 1,000 shares and you own 50 of them. What percent of the company do you own?", answer: 5, tolerance: 0, suffix: "%",
                            explanation: "50 out of 1,000 shares is 50 divided by 1,000, which equals 0.05, or 5%."),
                        .ordering(id: "u2l1q7", prompt: "Put the steps of buying your first stock in order.",
                            items: [
                            "Open a brokerage account",
                            "Add money to the account",
                            "Search for the company's ticker symbol",
                            "Place an order to buy shares"
                            ],
                            explanation: "You set up and fund an account, find the stock, then place your buy order.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit2-lesson2",
                    title: "Stocks vs Bonds",
                    iconName: "banknote.fill",
                    questions: [
                        .multipleChoice(id: "u2l2q1", prompt: "What is the key difference between a stock and a bond?",
                            choices: [
                            AnswerChoice(id: 0, text: "A stock is ownership; a bond is a loan you make"),
                            AnswerChoice(id: 1, text: "A stock is a loan; a bond is ownership"),
                            AnswerChoice(id: 2, text: "They are two words for the exact same thing"),
                            AnswerChoice(id: 3, text: "Bonds can only be issued by tech companies")
                            ], correct: 0,
                            explanation: "Stocks make you an owner, while bonds make you a lender who gets paid back with interest."),
                        .trueFalse(id: "u2l2q2", prompt: "When you buy a government bond, you are lending money to the government.", correctIsTrue: true,
                            explanation: "A bond is debt: the issuer borrows from you and pays you interest for the loan."),
                        .categorize(id: "u2l2q3", prompt: "Sort each feature under Stock or Bond.",
                            categories: ["Stock", "Bond"],
                            items: [
                            CategoryItem(id: 0, text: "Represents ownership", correctCategory: "Stock"),
                            CategoryItem(id: 1, text: "Represents a loan", correctCategory: "Bond"),
                            CategoryItem(id: 2, text: "Pays regular interest until it matures", correctCategory: "Bond"),
                            CategoryItem(id: 3, text: "May pay dividends and can grow a lot", correctCategory: "Stock"),
                            CategoryItem(id: 4, text: "Usually lower risk and steadier", correctCategory: "Bond"),
                            CategoryItem(id: 5, text: "Higher potential return with more ups and downs", correctCategory: "Stock")
                            ],
                            explanation: "Stocks are equity with more growth and risk; bonds are debt with steadier, smaller returns."),
                        .multipleChoice(id: "u2l2q4", prompt: "If a company goes bankrupt, who is generally paid first?",
                            choices: [
                            AnswerChoice(id: 0, text: "Bondholders, because they are lenders"),
                            AnswerChoice(id: 1, text: "Shareholders, because they are owners"),
                            AnswerChoice(id: 2, text: "Whoever bought most recently"),
                            AnswerChoice(id: 3, text: "Nobody is ever paid anything")
                            ], correct: 0,
                            explanation: "Bondholders are creditors, so they line up ahead of shareholders when assets are paid out."),
                        .trueFalse(id: "u2l2q5", prompt: "Bonds usually offer higher potential returns and bigger price swings than stocks.", correctIsTrue: false,
                            explanation: "It is the reverse: stocks usually have higher potential returns and more volatility than bonds."),
                        .numeric(id: "u2l2q6", prompt: "You buy a $1,000 bond that pays 4% interest per year. How many dollars of interest do you earn in one year?", answer: 40, tolerance: 0, prefix: "$",
                            explanation: "4% of $1,000 is 0.04 times 1,000, which equals $40 of interest."),
                        .multiSelect(id: "u2l2q7", prompt: "Which are generally TRUE of bonds compared with stocks? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "They tend to be lower risk"),
                            AnswerChoice(id: 1, text: "They pay interest to the holder"),
                            AnswerChoice(id: 2, text: "They make you a part-owner of the company"),
                            AnswerChoice(id: 3, text: "They usually have smaller potential returns")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Bonds are lower-risk loans that pay interest with smaller returns, and they do not give ownership.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit2-lesson3",
                    title: "Risk & Return",
                    iconName: "speedometer",
                    questions: [
                        .multipleChoice(id: "u2l3q1", prompt: "What is the general relationship between risk and potential return?",
                            choices: [
                            AnswerChoice(id: 0, text: "Higher potential returns usually come with higher risk"),
                            AnswerChoice(id: 1, text: "Higher returns always come with zero risk"),
                            AnswerChoice(id: 2, text: "Lower risk always means higher returns"),
                            AnswerChoice(id: 3, text: "Risk and return have nothing to do with each other")
                            ], correct: 0,
                            explanation: "To chase bigger gains you generally have to accept a bigger chance of loss. That is the risk-return tradeoff."),
                        .trueFalse(id: "u2l3q2", prompt: "Volatility describes how much an investment's price swings up and down.", correctIsTrue: true,
                            explanation: "High volatility means bigger, faster price swings in both directions."),
                        .categorize(id: "u2l3q3", prompt: "Sort each asset into Lower risk or Higher risk.",
                            categories: ["Lower risk", "Higher risk"],
                            items: [
                            CategoryItem(id: 0, text: "Federally insured savings account", correctCategory: "Lower risk"),
                            CategoryItem(id: 1, text: "U.S. Treasury bond", correctCategory: "Lower risk"),
                            CategoryItem(id: 2, text: "A single small company's stock", correctCategory: "Higher risk"),
                            CategoryItem(id: 3, text: "Cryptocurrency", correctCategory: "Higher risk"),
                            CategoryItem(id: 4, text: "Certificate of deposit (CD)", correctCategory: "Lower risk"),
                            CategoryItem(id: 5, text: "A trendy meme stock", correctCategory: "Higher risk")
                            ],
                            explanation: "Insured cash and government bonds are steady, while individual stocks and crypto swing much more."),
                        .ordering(id: "u2l3q4", prompt: "Order these assets from LOWEST to HIGHEST typical risk.",
                            items: [
                            "Savings account",
                            "Government bond",
                            "Diversified stock index fund",
                            "A single company's stock"
                            ],
                            explanation: "Cash is steadiest, then government bonds, then a broad stock fund, and a single stock is the riskiest."),
                        .multiSelect(id: "u2l3q5", prompt: "Which of these are ways to lower the risk in your investments? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Spread money across many different investments"),
                            AnswerChoice(id: 1, text: "Invest for a longer time horizon"),
                            AnswerChoice(id: 2, text: "Put all your money in one hot stock"),
                            AnswerChoice(id: 3, text: "Include some lower-risk assets like bonds")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Diversifying, staying invested longer, and mixing in steadier assets all cut risk; betting on one stock raises it."),
                        .multipleChoice(id: "u2l3q6", prompt: "Why might a young investor accept more risk than someone about to retire?",
                            choices: [
                            AnswerChoice(id: 0, text: "They have more time to recover from market drops"),
                            AnswerChoice(id: 1, text: "Young people never lose money"),
                            AnswerChoice(id: 2, text: "Risk disappears when you are young"),
                            AnswerChoice(id: 3, text: "Retirees automatically earn higher returns")
                            ], correct: 0,
                            explanation: "A longer time horizon gives markets more time to bounce back from downturns."),
                        .numeric(id: "u2l3q7", prompt: "An investment worth $200 grows to $230 in one year. What is the return, in percent?", answer: 15, tolerance: 0, suffix: "%",
                            explanation: "The $30 gain divided by the $200 you started with is 30 divided by 200, which equals 15%.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit2-lesson4",
                    title: "Diversification",
                    iconName: "chart.pie.fill",
                    questions: [
                        .multipleChoice(id: "u2l4q1", prompt: "What does diversification mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "Spreading your money across many different investments"),
                            AnswerChoice(id: 1, text: "Putting all your money in one stock"),
                            AnswerChoice(id: 2, text: "Only investing in a single industry"),
                            AnswerChoice(id: 3, text: "Keeping every dollar in cash")
                            ], correct: 0,
                            explanation: "Diversifying spreads risk so a single bad investment can't wipe you out."),
                        .trueFalse(id: "u2l4q2", prompt: "The saying 'don't put all your eggs in one basket' captures the idea of diversification.", correctIsTrue: true,
                            explanation: "If you drop one basket you don't lose every egg, which is exactly what diversification protects against."),
                        .multipleChoice(id: "u2l4q3", prompt: "How does an index fund make diversification easy?",
                            choices: [
                            AnswerChoice(id: 0, text: "One purchase gives you tiny pieces of many companies at once"),
                            AnswerChoice(id: 1, text: "It guarantees you can never lose money"),
                            AnswerChoice(id: 2, text: "It only ever holds a single company"),
                            AnswerChoice(id: 3, text: "It removes the need for a brokerage account")
                            ], correct: 0,
                            explanation: "An index fund like an S&P 500 fund bundles hundreds of companies into one investment."),
                        .multiSelect(id: "u2l4q4", prompt: "Which of these portfolios are well diversified? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A total-stock-market index fund"),
                            AnswerChoice(id: 1, text: "Shares of 500 companies across many industries"),
                            AnswerChoice(id: 2, text: "All your money in one airline stock"),
                            AnswerChoice(id: 3, text: "A mix of stocks and bonds from around the world")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Spreading across many companies, sectors, and asset types is diversified; one airline stock is not."),
                        .trueFalse(id: "u2l4q5", prompt: "Diversification can lower the risk of a single company doing badly, but it can't erase the risk of the whole market falling.", correctIsTrue: true,
                            explanation: "Spreading out reduces company-specific risk, yet a market-wide drop still affects almost everything."),
                        .numeric(id: "u2l4q6", prompt: "An S&P 500 index fund holds roughly how many companies? Enter the number.", answer: 500, tolerance: 0,
                            explanation: "The S&P 500 tracks about 500 of the largest U.S. companies inside a single fund."),
                        .matching(id: "u2l4q7", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Diversification", right: "Spreading money across many investments"),
                            MatchPair(id: 1, left: "Index fund", right: "A fund that holds all the companies in an index"),
                            MatchPair(id: 2, left: "S&P 500", right: "An index of about 500 large U.S. companies"),
                            MatchPair(id: 3, left: "Concentration", right: "Putting most of your money in one place")
                            ],
                            explanation: "Diversification and index funds lower risk, while concentration raises it.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit2-lesson5",
                    title: "Building a Portfolio",
                    iconName: "briefcase.fill",
                    questions: [
                        .multipleChoice(id: "u2l5q1", prompt: "What is a portfolio?",
                            choices: [
                            AnswerChoice(id: 0, text: "The full collection of investments a person owns"),
                            AnswerChoice(id: 1, text: "A single stock"),
                            AnswerChoice(id: 2, text: "A type of bank loan"),
                            AnswerChoice(id: 3, text: "A government bond and nothing else")
                            ], correct: 0,
                            explanation: "Your portfolio is everything you hold together: stocks, bonds, funds, and cash."),
                        .multipleChoice(id: "u2l5q2", prompt: "What does 'asset allocation' mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "How you divide your money among stocks, bonds, and cash"),
                            AnswerChoice(id: 1, text: "Choosing one single best stock"),
                            AnswerChoice(id: 2, text: "The fee a broker charges you"),
                            AnswerChoice(id: 3, text: "The tax you owe on your gains")
                            ], correct: 0,
                            explanation: "Asset allocation is the mix of asset types, and that mix shapes your risk and return."),
                        .numeric(id: "u2l5q3", prompt: "A common rule of thumb suggests putting about (110 minus your age)% in stocks. For a 20-year-old, what percent is that?", answer: 90, tolerance: 0, suffix: "%",
                            explanation: "110 minus 20 equals 90, so the rule suggests roughly 90% in stocks for a 20-year-old."),
                        .trueFalse(id: "u2l5q4", prompt: "Younger investors are often encouraged to hold a larger share of stocks than people near retirement.", correctIsTrue: true,
                            explanation: "With decades ahead, young investors can ride out market dips in exchange for higher long-run growth."),
                        .ordering(id: "u2l5q5", prompt: "Put these steps for building a beginner portfolio in order.",
                            items: [
                            "Set your goal and time horizon",
                            "Build an emergency fund of cash",
                            "Choose an asset allocation of stocks vs bonds",
                            "Buy diversified funds that match it",
                            "Rebalance about once a year"
                            ],
                            explanation: "Goal first, a safety cushion next, then pick a mix, invest in it, and check in yearly."),
                        .multipleChoice(id: "u2l5q6", prompt: "What is 'rebalancing' a portfolio?",
                            choices: [
                            AnswerChoice(id: 0, text: "Adjusting your holdings back to your target mix"),
                            AnswerChoice(id: 1, text: "Selling everything and starting over"),
                            AnswerChoice(id: 2, text: "Only ever buying and never selling"),
                            AnswerChoice(id: 3, text: "Moving your account to a new bank")
                            ], correct: 0,
                            explanation: "Over time winners grow and shift your mix, so rebalancing trims them back to your plan."),
                        .multiSelect(id: "u2l5q7", prompt: "Which factors should shape your asset allocation? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Your time horizon, meaning when you need the money"),
                            AnswerChoice(id: 1, text: "Your risk tolerance"),
                            AnswerChoice(id: 2, text: "Your goals"),
                            AnswerChoice(id: 3, text: "Your favorite color")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Time, comfort with risk, and goals drive your mix; your favorite color does not.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit2-check",
                    title: "Investing Foundations: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u2l1q2-kc", prompt: "People who own shares of a company are called shareholders.", correctIsTrue: true,
                            explanation: "Owning shares gives you a slice of the company, which is exactly what a shareholder is."),
                        .multipleChoice(id: "u2l1q4-kc", prompt: "Where are most public company stocks bought and sold?",
                            choices: [
                            AnswerChoice(id: 0, text: "On stock exchanges like the NYSE or Nasdaq"),
                            AnswerChoice(id: 1, text: "At the company's front desk"),
                            AnswerChoice(id: 2, text: "Only inside local banks"),
                            AnswerChoice(id: 3, text: "Through the post office")
                            ], correct: 0,
                            explanation: "Exchanges like the NYSE and Nasdaq match up buyers and sellers of shares."),
                        .numeric(id: "u2l1q6-kc", prompt: "A company splits its ownership into 1,000 shares and you own 50 of them. What percent of the company do you own?", answer: 5, tolerance: 0, suffix: "%",
                            explanation: "50 out of 1,000 shares is 50 divided by 1,000, which equals 0.05, or 5%."),
                        .trueFalse(id: "u2l2q2-kc", prompt: "When you buy a government bond, you are lending money to the government.", correctIsTrue: true,
                            explanation: "A bond is debt: the issuer borrows from you and pays you interest for the loan."),
                        .multipleChoice(id: "u2l2q4-kc", prompt: "If a company goes bankrupt, who is generally paid first?",
                            choices: [
                            AnswerChoice(id: 0, text: "Bondholders, because they are lenders"),
                            AnswerChoice(id: 1, text: "Shareholders, because they are owners"),
                            AnswerChoice(id: 2, text: "Whoever bought most recently"),
                            AnswerChoice(id: 3, text: "Nobody is ever paid anything")
                            ], correct: 0,
                            explanation: "Bondholders are creditors, so they line up ahead of shareholders when assets are paid out."),
                        .numeric(id: "u2l2q6-kc", prompt: "You buy a $1,000 bond that pays 4% interest per year. How many dollars of interest do you earn in one year?", answer: 40, tolerance: 0, prefix: "$",
                            explanation: "4% of $1,000 is 0.04 times 1,000, which equals $40 of interest."),
                        .trueFalse(id: "u2l3q2-kc", prompt: "Volatility describes how much an investment's price swings up and down.", correctIsTrue: true,
                            explanation: "High volatility means bigger, faster price swings in both directions."),
                        .ordering(id: "u2l3q4-kc", prompt: "Order these assets from LOWEST to HIGHEST typical risk.",
                            items: [
                            "Savings account",
                            "Government bond",
                            "Diversified stock index fund",
                            "A single company's stock"
                            ],
                            explanation: "Cash is steadiest, then government bonds, then a broad stock fund, and a single stock is the riskiest."),
                        .multipleChoice(id: "u2l3q6-kc", prompt: "Why might a young investor accept more risk than someone about to retire?",
                            choices: [
                            AnswerChoice(id: 0, text: "They have more time to recover from market drops"),
                            AnswerChoice(id: 1, text: "Young people never lose money"),
                            AnswerChoice(id: 2, text: "Risk disappears when you are young"),
                            AnswerChoice(id: 3, text: "Retirees automatically earn higher returns")
                            ], correct: 0,
                            explanation: "A longer time horizon gives markets more time to bounce back from downturns."),
                        .trueFalse(id: "u2l4q2-kc", prompt: "The saying 'don't put all your eggs in one basket' captures the idea of diversification.", correctIsTrue: true,
                            explanation: "If you drop one basket you don't lose every egg, which is exactly what diversification protects against."),
                        .multiSelect(id: "u2l4q4-kc", prompt: "Which of these portfolios are well diversified? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A total-stock-market index fund"),
                            AnswerChoice(id: 1, text: "Shares of 500 companies across many industries"),
                            AnswerChoice(id: 2, text: "All your money in one airline stock"),
                            AnswerChoice(id: 3, text: "A mix of stocks and bonds from around the world")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Spreading across many companies, sectors, and asset types is diversified; one airline stock is not."),
                        .numeric(id: "u2l4q6-kc", prompt: "An S&P 500 index fund holds roughly how many companies? Enter the number.", answer: 500, tolerance: 0,
                            explanation: "The S&P 500 tracks about 500 of the largest U.S. companies inside a single fund."),
                        .multipleChoice(id: "u2l5q2-kc", prompt: "What does 'asset allocation' mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "How you divide your money among stocks, bonds, and cash"),
                            AnswerChoice(id: 1, text: "Choosing one single best stock"),
                            AnswerChoice(id: 2, text: "The fee a broker charges you"),
                            AnswerChoice(id: 3, text: "The tax you owe on your gains")
                            ], correct: 0,
                            explanation: "Asset allocation is the mix of asset types, and that mix shapes your risk and return."),
                        .trueFalse(id: "u2l5q4-kc", prompt: "Younger investors are often encouraged to hold a larger share of stocks than people near retirement.", correctIsTrue: true,
                            explanation: "With decades ahead, young investors can ride out market dips in exchange for higher long-run growth."),
                        .multipleChoice(id: "u2l5q6-kc", prompt: "What is 'rebalancing' a portfolio?",
                            choices: [
                            AnswerChoice(id: 0, text: "Adjusting your holdings back to your target mix"),
                            AnswerChoice(id: 1, text: "Selling everything and starting over"),
                            AnswerChoice(id: 2, text: "Only ever buying and never selling"),
                            AnswerChoice(id: 3, text: "Moving your account to a new bank")
                            ], correct: 0,
                            explanation: "Over time winners grow and shift your mix, so rebalancing trims them back to your plan.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let stockMarket = LearningUnit(
            id: "unit3",
            title: "Unit 6: The Stock Market",
            subtitle: "Quotes, orders, cycles, and options",
            colorHex: "FFC93C",
            lessons: [
                Lesson(
                    id: "unit3-lesson1",
                    title: "Reading a Stock Quote",
                    iconName: "doc.text.magnifyingglass",
                    questions: [
                        .multipleChoice(id: "u3l1q1", prompt: "What does a stock's ticker symbol represent?",
                            choices: [
                            AnswerChoice(id: 0, text: "A short code that uniquely identifies a company's stock, like AAPL for Apple"),
                            AnswerChoice(id: 1, text: "The company's total yearly profit"),
                            AnswerChoice(id: 2, text: "The number of shares you personally own"),
                            AnswerChoice(id: 3, text: "The dividend the company pays")
                            ], correct: 0,
                            explanation: "A ticker is just a nickname code exchanges use to identify a stock quickly. AAPL means Apple, TSLA means Tesla."),
                        .trueFalse(id: "u3l1q2", prompt: "A stock's share price alone tells you how big the company is.", correctIsTrue: false,
                            explanation: "Price is per share. A $500 stock can be a smaller company than a $20 stock. Company size is measured by market cap, not price."),
                        .numeric(id: "u3l1q3", prompt: "A company has 10,000,000 shares priced at $50 each. What is its market cap, in dollars?", answer: 500000000, tolerance: 0, prefix: "$",
                            explanation: "Market cap = share price x shares outstanding. $50 x 10,000,000 = $500,000,000."),
                        .multipleChoice(id: "u3l1q4", prompt: "What does market capitalization (market cap) measure?",
                            choices: [
                            AnswerChoice(id: 0, text: "The total value of all a company's shares: share price x shares outstanding"),
                            AnswerChoice(id: 1, text: "The price of a single share"),
                            AnswerChoice(id: 2, text: "How many employees a company has"),
                            AnswerChoice(id: 3, text: "The company's yearly advertising budget")
                            ], correct: 0,
                            explanation: "Market cap adds up every share's value, so it reflects the company's true size far better than the price of one share."),
                        .matching(id: "u3l1q5", prompt: "Match each part of a stock quote to what it tells you.",
                            pairs: [
                            MatchPair(id: 0, left: "Ticker", right: "The stock's short ID code"),
                            MatchPair(id: 1, left: "Change %", right: "How much the price moved today"),
                            MatchPair(id: 2, left: "Market cap", right: "Total value of all the shares"),
                            MatchPair(id: 3, left: "Volume", right: "How many shares traded today")
                            ],
                            explanation: "Each field answers a different question: what it is, how it moved, how big the company is, and how actively it's trading."),
                        .numeric(id: "u3l1q6", prompt: "A stock opened at $200 and now trades at $210. What is its percent change today?", answer: 5, tolerance: 0, suffix: "%",
                            explanation: "Change % = (new - old) / old. ($210 - $200) / $200 = 0.05 = 5%."),
                        .multiSelect(id: "u3l1q7", prompt: "Which of these can you read straight from a stock quote? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "The current share price"),
                            AnswerChoice(id: 1, text: "Today's percent change"),
                            AnswerChoice(id: 2, text: "The market cap"),
                            AnswerChoice(id: 3, text: "Exactly what the price will be tomorrow")
                            ], correctIDs: [0, 1, 2],
                            explanation: "A quote shows today's price, move, and company size. No quote can tell you tomorrow's price.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit3-lesson2",
                    title: "Market vs Limit Orders",
                    iconName: "arrow.left.arrow.right",
                    questions: [
                        .multipleChoice(id: "u3l2q1", prompt: "What is a market order?",
                            choices: [
                            AnswerChoice(id: 0, text: "An order to buy or sell right away at the best price currently available"),
                            AnswerChoice(id: 1, text: "An order that only fills at a price you choose"),
                            AnswerChoice(id: 2, text: "A promise to hold a stock for one year"),
                            AnswerChoice(id: 3, text: "A fee charged by the exchange")
                            ], correct: 0,
                            explanation: "A market order says 'fill me now, whatever the going price is.' You get speed, but not a guaranteed price."),
                        .multipleChoice(id: "u3l2q2", prompt: "What is a limit order?",
                            choices: [
                            AnswerChoice(id: 0, text: "An order that only executes at your chosen price or better"),
                            AnswerChoice(id: 1, text: "An order that fills instantly at any price"),
                            AnswerChoice(id: 2, text: "An order to sell your entire portfolio"),
                            AnswerChoice(id: 3, text: "A type of savings account")
                            ], correct: 0,
                            explanation: "A limit order says 'only fill me at my price or better.' You control the price, but it might never fill."),
                        .trueFalse(id: "u3l2q3", prompt: "A market order prioritizes speed, while a limit order prioritizes price control.", correctIsTrue: true,
                            explanation: "That's the core trade-off: market = fast but price uncertain; limit = price certain but the fill isn't guaranteed."),
                        .matching(id: "u3l2q4", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Market order", right: "Fills fast, price not guaranteed"),
                            MatchPair(id: 1, left: "Limit order", right: "Price guaranteed, fill not guaranteed"),
                            MatchPair(id: 2, left: "Bid", right: "Highest price a buyer will pay"),
                            MatchPair(id: 3, left: "Ask", right: "Lowest price a seller will accept")
                            ],
                            explanation: "Buyers post bids, sellers post asks, and your order type decides whether you chase speed or hold out for a price."),
                        .categorize(id: "u3l2q5", prompt: "Sort each situation into the order type that fits best.",
                            categories: ["Market order", "Limit order"],
                            items: [
                            CategoryItem(id: 0, text: "Buy right now, the exact price doesn't matter much", correctCategory: "Market order"),
                            CategoryItem(id: 1, text: "Only buy if it drops to $50", correctCategory: "Limit order"),
                            CategoryItem(id: 2, text: "Sell instantly to exit a falling stock", correctCategory: "Market order"),
                            CategoryItem(id: 3, text: "Sell only if it climbs to $100", correctCategory: "Limit order")
                            ],
                            explanation: "Use a market order when getting in or out fast matters most, and a limit order when hitting a specific price matters most."),
                        .trueFalse(id: "u3l2q6", prompt: "A limit order guarantees your order will always be filled.", correctIsTrue: false,
                            explanation: "A limit order guarantees the price, not the fill. If the stock never reaches your price, the order simply waits or expires."),
                        .ordering(id: "u3l2q7", prompt: "Put the steps of placing a limit buy order in order.",
                            items: [
                            "Pick the stock and choose 'buy'",
                            "Select the 'limit' order type",
                            "Set your maximum price",
                            "Submit and wait for the price to reach it"
                            ],
                            explanation: "You choose the stock, pick 'limit,' set your price ceiling, then let it sit until the market comes to your price.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit3-lesson3",
                    title: "Bull vs Bear Markets",
                    iconName: "chart.line.uptrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u3l3q1", prompt: "What is a bull market?",
                            choices: [
                            AnswerChoice(id: 0, text: "A stretch when prices are generally rising and optimism is high"),
                            AnswerChoice(id: 1, text: "A stretch when prices are generally falling"),
                            AnswerChoice(id: 2, text: "A single day of heavy trading"),
                            AnswerChoice(id: 3, text: "A tax on stock gains")
                            ], correct: 0,
                            explanation: "Picture a bull charging with its horns up. A bull market is a rising, optimistic market."),
                        .multipleChoice(id: "u3l3q2", prompt: "What is a bear market?",
                            choices: [
                            AnswerChoice(id: 0, text: "A stretch when prices fall 20% or more from recent highs"),
                            AnswerChoice(id: 1, text: "A stretch when prices keep hitting new highs"),
                            AnswerChoice(id: 2, text: "A market that only trades bonds"),
                            AnswerChoice(id: 3, text: "A market with zero price movement")
                            ], correct: 0,
                            explanation: "Picture a bear swiping its paw down. A bear market is a falling market, officially a drop of 20% or more."),
                        .numeric(id: "u3l3q3", prompt: "A market is officially a 'bear market' once it falls at least what percent from its recent high?", answer: 20, tolerance: 0, suffix: "%",
                            explanation: "The widely used rule of thumb is a 20% drop from the recent peak."),
                        .numeric(id: "u3l3q4", prompt: "An index peaks at 5,000 and falls to 4,000. What percent has it dropped?", answer: 20, tolerance: 0, suffix: "%",
                            explanation: "(5,000 - 4,000) / 5,000 = 0.20 = 20% — exactly the bear-market threshold."),
                        .trueFalse(id: "u3l3q5", prompt: "The smartest move in a bear market is always to panic-sell everything.", correctIsTrue: false,
                            explanation: "Panic-selling locks in losses. Historically, markets have recovered over time, so staying calm and sticking to a plan usually beats panicking."),
                        .matching(id: "u3l3q6", prompt: "Match each market term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Bull market", right: "Prices rising, optimism high"),
                            MatchPair(id: 1, left: "Bear market", right: "Prices down 20%+ from highs"),
                            MatchPair(id: 2, left: "Correction", right: "A drop of about 10% from highs"),
                            MatchPair(id: 3, left: "Volatility", right: "How much prices swing up and down")
                            ],
                            explanation: "A correction is a milder dip than a bear market, and volatility just describes how jumpy prices are."),
                        .multiSelect(id: "u3l3q7", prompt: "Which are smart habits during a bear market? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Stay calm and stick to your long-term plan"),
                            AnswerChoice(id: 1, text: "Keep investing steadily if you can"),
                            AnswerChoice(id: 2, text: "Sell everything the moment prices dip"),
                            AnswerChoice(id: 3, text: "Remember markets have recovered from past crashes")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Calm, consistency, and perspective help. Reflexively selling on every dip is what turns temporary drops into permanent losses.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit3-lesson4",
                    title: "Intro to Options",
                    iconName: "function",
                    questions: [
                        .multipleChoice(id: "u3l4q1", prompt: "What is a call option?",
                            choices: [
                            AnswerChoice(id: 0, text: "The right to BUY a stock at a set price before a deadline"),
                            AnswerChoice(id: 1, text: "The right to SELL a stock at a set price"),
                            AnswerChoice(id: 2, text: "A guaranteed dividend payment"),
                            AnswerChoice(id: 3, text: "A loan from your broker")
                            ], correct: 0,
                            explanation: "Call = the right to Call the stock toward you (buy it) at a fixed price. Calls are a bullish bet."),
                        .multipleChoice(id: "u3l4q2", prompt: "What is a put option?",
                            choices: [
                            AnswerChoice(id: 0, text: "The right to SELL a stock at a set price before a deadline"),
                            AnswerChoice(id: 1, text: "The right to BUY a stock at a set price"),
                            AnswerChoice(id: 2, text: "A type of index fund"),
                            AnswerChoice(id: 3, text: "A savings bond")
                            ], correct: 0,
                            explanation: "Put = the right to Put the stock away from you (sell it) at a fixed price. Puts are a bearish bet."),
                        .trueFalse(id: "u3l4q3", prompt: "One standard options contract controls 100 shares of the stock.", correctIsTrue: true,
                            explanation: "Almost all equity options come in bundles of 100 shares per contract, so small price moves get magnified."),
                        .numeric(id: "u3l4q4", prompt: "You buy 2 call contracts. How many shares do they control in total?", answer: 200, tolerance: 0,
                            explanation: "Each contract is 100 shares, so 2 contracts control 2 x 100 = 200 shares."),
                        .multipleChoice(id: "u3l4q5", prompt: "What is the 'premium' on an option?",
                            choices: [
                            AnswerChoice(id: 0, text: "The price you pay to buy the option"),
                            AnswerChoice(id: 1, text: "The profit you're guaranteed to make"),
                            AnswerChoice(id: 2, text: "A special tax on options"),
                            AnswerChoice(id: 3, text: "The number of shares in one contract")
                            ], correct: 0,
                            explanation: "The premium is the cost of the option itself — the money you hand over to hold that right."),
                        .categorize(id: "u3l4q6", prompt: "Sort each idea into the view it expresses.",
                            categories: ["Bullish (calls)", "Bearish (puts)"],
                            items: [
                            CategoryItem(id: 0, text: "You think the stock will rise", correctCategory: "Bullish (calls)"),
                            CategoryItem(id: 1, text: "Buying a call", correctCategory: "Bullish (calls)"),
                            CategoryItem(id: 2, text: "You think the stock will fall", correctCategory: "Bearish (puts)"),
                            CategoryItem(id: 3, text: "Buying a put", correctCategory: "Bearish (puts)")
                            ],
                            explanation: "Calls profit when the stock climbs (bullish); puts profit when it drops (bearish)."),
                        .trueFalse(id: "u3l4q7", prompt: "When you BUY an option, the most you can lose is the premium you paid.", correctIsTrue: true,
                            explanation: "If the bet goes wrong, the option can expire worthless — but you can never lose more than the premium you spent to buy it.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit3-lesson5",
                    title: "Options Challenge",
                    iconName: "gamecontroller.fill",
                    questions: [
                        .multipleChoice(id: "u3l5q1", prompt: "You're bullish on a stock — you expect its price to climb. Which option matches that view?",
                            choices: [
                            AnswerChoice(id: 0, text: "Buy a call"),
                            AnswerChoice(id: 1, text: "Buy a put"),
                            AnswerChoice(id: 2, text: "Sell all your shares immediately"),
                            AnswerChoice(id: 3, text: "Options can't express this view")
                            ], correct: 0,
                            explanation: "Bullish means you expect a rise, and a call profits as the stock goes up. Call = bullish."),
                        .interactiveOption(id: "u3l5q2", prompt: "Build the position that fits Toro's view.",
                            challenge: OptionChallenge(symbol: "NVDA", companyName: "NVIDIA", spot: 130,
                                scenario: "You're convinced NVDA will jump after its earnings report next week.", requiredKind: .call, targetPrice: 150,
                                successNote: "A call profits when the stock climbs above your strike plus the premium you paid."),
                            explanation: "A bullish view calls for a call. It locks in the right to buy NVDA at $150 even if the stock rockets past it."),
                        .multipleChoice(id: "u3l5q3", prompt: "You're bearish on a stock — you expect its price to drop. Which option matches that view?",
                            choices: [
                            AnswerChoice(id: 0, text: "Buy a put"),
                            AnswerChoice(id: 1, text: "Buy a call"),
                            AnswerChoice(id: 2, text: "Buy more shares"),
                            AnswerChoice(id: 3, text: "Options can't express this view")
                            ], correct: 0,
                            explanation: "Bearish means you expect a fall, and a put profits as the stock goes down. Put = bearish."),
                        .interactiveOption(id: "u3l5q4", prompt: "Build the position that fits Toro's view.",
                            challenge: OptionChallenge(symbol: "TSLA", companyName: "Tesla", spot: 256,
                                scenario: "You think TSLA will slide after weak delivery numbers come out.", requiredKind: .put, targetPrice: 230,
                                successNote: "A put profits when the stock falls below your strike minus the premium paid."),
                            explanation: "A bearish view calls for a put. It locks in the right to sell TSLA at $230 even if the stock sinks far below."),
                        .numeric(id: "u3l5q5", prompt: "A call costs a $3.00 premium per share. Since 1 contract covers 100 shares, what does 1 contract cost in total, in dollars?", answer: 300, tolerance: 0, prefix: "$",
                            explanation: "Premium is quoted per share, so $3.00 x 100 shares = $300 for one contract."),
                        .interactiveOption(id: "u3l5q6", prompt: "Build the position that fits Toro's view.",
                            challenge: OptionChallenge(symbol: "AAPL", companyName: "Apple", spot: 212,
                                scenario: "You expect AAPL to rally into the holiday shopping season.", requiredKind: .call, targetPrice: 230,
                                successNote: "A call profits when the stock climbs above your strike plus the premium you paid."),
                            explanation: "Expecting a rise is bullish, so you buy a call — the right to buy AAPL at $230 no matter how high it goes."),
                        .trueFalse(id: "u3l5q7", prompt: "If you buy that call for a $300 premium, the most you can lose is $300.", correctIsTrue: true,
                            explanation: "When you buy an option, your entire risk is the premium. Worst case, it expires worthless and you're out $300 — no more.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit3-check",
                    title: "The Stock Market: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u3l1q2-kc", prompt: "A stock's share price alone tells you how big the company is.", correctIsTrue: false,
                            explanation: "Price is per share. A $500 stock can be a smaller company than a $20 stock. Company size is measured by market cap, not price."),
                        .multipleChoice(id: "u3l1q4-kc", prompt: "What does market capitalization (market cap) measure?",
                            choices: [
                            AnswerChoice(id: 0, text: "The total value of all a company's shares: share price x shares outstanding"),
                            AnswerChoice(id: 1, text: "The price of a single share"),
                            AnswerChoice(id: 2, text: "How many employees a company has"),
                            AnswerChoice(id: 3, text: "The company's yearly advertising budget")
                            ], correct: 0,
                            explanation: "Market cap adds up every share's value, so it reflects the company's true size far better than the price of one share."),
                        .numeric(id: "u3l1q6-kc", prompt: "A stock opened at $200 and now trades at $210. What is its percent change today?", answer: 5, tolerance: 0, suffix: "%",
                            explanation: "Change % = (new - old) / old. ($210 - $200) / $200 = 0.05 = 5%."),
                        .multipleChoice(id: "u3l2q2-kc", prompt: "What is a limit order?",
                            choices: [
                            AnswerChoice(id: 0, text: "An order that only executes at your chosen price or better"),
                            AnswerChoice(id: 1, text: "An order that fills instantly at any price"),
                            AnswerChoice(id: 2, text: "An order to sell your entire portfolio"),
                            AnswerChoice(id: 3, text: "A type of savings account")
                            ], correct: 0,
                            explanation: "A limit order says 'only fill me at my price or better.' You control the price, but it might never fill."),
                        .matching(id: "u3l2q4-kc", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Market order", right: "Fills fast, price not guaranteed"),
                            MatchPair(id: 1, left: "Limit order", right: "Price guaranteed, fill not guaranteed"),
                            MatchPair(id: 2, left: "Bid", right: "Highest price a buyer will pay"),
                            MatchPair(id: 3, left: "Ask", right: "Lowest price a seller will accept")
                            ],
                            explanation: "Buyers post bids, sellers post asks, and your order type decides whether you chase speed or hold out for a price."),
                        .trueFalse(id: "u3l2q6-kc", prompt: "A limit order guarantees your order will always be filled.", correctIsTrue: false,
                            explanation: "A limit order guarantees the price, not the fill. If the stock never reaches your price, the order simply waits or expires."),
                        .multipleChoice(id: "u3l3q2-kc", prompt: "What is a bear market?",
                            choices: [
                            AnswerChoice(id: 0, text: "A stretch when prices fall 20% or more from recent highs"),
                            AnswerChoice(id: 1, text: "A stretch when prices keep hitting new highs"),
                            AnswerChoice(id: 2, text: "A market that only trades bonds"),
                            AnswerChoice(id: 3, text: "A market with zero price movement")
                            ], correct: 0,
                            explanation: "Picture a bear swiping its paw down. A bear market is a falling market, officially a drop of 20% or more."),
                        .numeric(id: "u3l3q4-kc", prompt: "An index peaks at 5,000 and falls to 4,000. What percent has it dropped?", answer: 20, tolerance: 0, suffix: "%",
                            explanation: "(5,000 - 4,000) / 5,000 = 0.20 = 20% — exactly the bear-market threshold."),
                        .matching(id: "u3l3q6-kc", prompt: "Match each market term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Bull market", right: "Prices rising, optimism high"),
                            MatchPair(id: 1, left: "Bear market", right: "Prices down 20%+ from highs"),
                            MatchPair(id: 2, left: "Correction", right: "A drop of about 10% from highs"),
                            MatchPair(id: 3, left: "Volatility", right: "How much prices swing up and down")
                            ],
                            explanation: "A correction is a milder dip than a bear market, and volatility just describes how jumpy prices are."),
                        .multipleChoice(id: "u3l4q2-kc", prompt: "What is a put option?",
                            choices: [
                            AnswerChoice(id: 0, text: "The right to SELL a stock at a set price before a deadline"),
                            AnswerChoice(id: 1, text: "The right to BUY a stock at a set price"),
                            AnswerChoice(id: 2, text: "A type of index fund"),
                            AnswerChoice(id: 3, text: "A savings bond")
                            ], correct: 0,
                            explanation: "Put = the right to Put the stock away from you (sell it) at a fixed price. Puts are a bearish bet."),
                        .numeric(id: "u3l4q4-kc", prompt: "You buy 2 call contracts. How many shares do they control in total?", answer: 200, tolerance: 0,
                            explanation: "Each contract is 100 shares, so 2 contracts control 2 x 100 = 200 shares."),
                        .categorize(id: "u3l4q6-kc", prompt: "Sort each idea into the view it expresses.",
                            categories: ["Bullish (calls)", "Bearish (puts)"],
                            items: [
                            CategoryItem(id: 0, text: "You think the stock will rise", correctCategory: "Bullish (calls)"),
                            CategoryItem(id: 1, text: "Buying a call", correctCategory: "Bullish (calls)"),
                            CategoryItem(id: 2, text: "You think the stock will fall", correctCategory: "Bearish (puts)"),
                            CategoryItem(id: 3, text: "Buying a put", correctCategory: "Bearish (puts)")
                            ],
                            explanation: "Calls profit when the stock climbs (bullish); puts profit when it drops (bearish)."),
                        .interactiveOption(id: "u3l5q2-kc", prompt: "Build the position that fits Toro's view.",
                            challenge: OptionChallenge(symbol: "NVDA", companyName: "NVIDIA", spot: 130,
                                scenario: "You're convinced NVDA will jump after its earnings report next week.", requiredKind: .call, targetPrice: 150,
                                successNote: "A call profits when the stock climbs above your strike plus the premium you paid."),
                            explanation: "A bullish view calls for a call. It locks in the right to buy NVDA at $150 even if the stock rockets past it."),
                        .interactiveOption(id: "u3l5q4-kc", prompt: "Build the position that fits Toro's view.",
                            challenge: OptionChallenge(symbol: "TSLA", companyName: "Tesla", spot: 256,
                                scenario: "You think TSLA will slide after weak delivery numbers come out.", requiredKind: .put, targetPrice: 230,
                                successNote: "A put profits when the stock falls below your strike minus the premium paid."),
                            explanation: "A bearish view calls for a put. It locks in the right to sell TSLA at $230 even if the stock sinks far below."),
                        .interactiveOption(id: "u3l5q6-kc", prompt: "Build the position that fits Toro's view.",
                            challenge: OptionChallenge(symbol: "AAPL", companyName: "Apple", spot: 212,
                                scenario: "You expect AAPL to rally into the holiday shopping season.", requiredKind: .call, targetPrice: 230,
                                successNote: "A call profits when the stock climbs above your strike plus the premium you paid."),
                            explanation: "Expecting a rise is bullish, so you buy a call — the right to buy AAPL at $230 no matter how high it goes.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let fundsAndFees = LearningUnit(
            id: "unit6",
            title: "Unit 7: Funds & Fees",
            subtitle: "Index funds, ETFs, and keeping costs low",
            colorHex: "9B5DE5",
            lessons: [
                Lesson(
                    id: "unit6-lesson1",
                    title: "Index Funds",
                    iconName: "chart.line.uptrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u6l1q1", prompt: "What is an index fund?",
                            choices: [
                            AnswerChoice(id: 0, text: "A fund that buys all (or a representative sample of) the stocks in a market index"),
                            AnswerChoice(id: 1, text: "A fund where a manager hand-picks a few stocks hoping to beat the market"),
                            AnswerChoice(id: 2, text: "A savings account that tracks inflation"),
                            AnswerChoice(id: 3, text: "A single company's stock")
                            ], correct: 0,
                            explanation: "An index fund simply mirrors an index, like the S&P 500, so you own a little piece of everything in it."),
                        .trueFalse(id: "u6l1q2", prompt: "An index fund's goal is to match the market's return, not to beat it.", correctIsTrue: true,
                            explanation: "By copying the index instead of trying to outsmart it, index funds aim for the market's average return at very low cost."),
                        .multipleChoice(id: "u6l1q3", prompt: "The S&P 500 is an index made up of roughly what?",
                            choices: [
                            AnswerChoice(id: 0, text: "500 of the largest U.S. companies"),
                            AnswerChoice(id: 1, text: "500 cryptocurrencies"),
                            AnswerChoice(id: 2, text: "50 government bonds"),
                            AnswerChoice(id: 3, text: "5,000 global startups")
                            ], correct: 0,
                            explanation: "The S&P 500 tracks about 500 of the biggest U.S. companies, so an S&P 500 index fund spreads your money across all of them."),
                        .multiSelect(id: "u6l1q4", prompt: "Which of these are real advantages of index funds? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Instant diversification across many companies"),
                            AnswerChoice(id: 1, text: "Low costs because there's no expensive stock-picking team"),
                            AnswerChoice(id: 2, text: "A guarantee that you'll never lose money"),
                            AnswerChoice(id: 3, text: "They have historically beaten most active funds over the long run")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Index funds are cheap, diversified, and beat most active funds over time — but no investment can promise you'll never lose money."),
                        .numeric(id: "u6l1q5", prompt: "The S&P 500 index is built from 500 companies. Owning one share of a fund that tracks it gives you a slice of how many companies?", answer: 500, tolerance: 0,
                            explanation: "One share of an S&P 500 index fund spreads your money across all 500 companies at once — that's diversification in a single click."),
                        .trueFalse(id: "u6l1q6", prompt: "Because most active fund managers fail to beat their index over the long run, a low-cost index fund is often a smart default.", correctIsTrue: true,
                            explanation: "Study after study shows the large majority of active managers lag their benchmark after fees, which is why index funds are so popular."),
                        .ordering(id: "u6l1q7", prompt: "Order these from least diversified to most diversified.",
                            items: [
                            "A single company's stock",
                            "A fund holding 30 companies",
                            "An S&P 500 index fund (500 companies)",
                            "A total U.S. market index fund (thousands of companies)"
                            ],
                            explanation: "The more companies you hold, the more spread out your risk — going from one stock to a total-market fund steadily increases diversification.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit6-lesson2",
                    title: "ETFs vs Mutual Funds",
                    iconName: "arrow.left.arrow.right.circle.fill",
                    questions: [
                        .multipleChoice(id: "u6l2q1", prompt: "What's a key difference in how ETFs and mutual funds trade?",
                            choices: [
                            AnswerChoice(id: 0, text: "ETFs trade throughout the day like a stock; mutual funds price just once per day after the market closes"),
                            AnswerChoice(id: 1, text: "Mutual funds trade every second; ETFs trade only once a year"),
                            AnswerChoice(id: 2, text: "There is no difference between them"),
                            AnswerChoice(id: 3, text: "ETFs can only be bought by banks")
                            ], correct: 0,
                            explanation: "ETF (exchange-traded fund) prices move all day like a stock, while a mutual fund settles at one price after the close."),
                        .categorize(id: "u6l2q2", prompt: "Sort each trait into ETF or Mutual Fund.",
                            categories: ["ETF", "Mutual Fund"],
                            items: [
                            CategoryItem(id: 0, text: "You can buy or sell it anytime the market is open", correctCategory: "ETF"),
                            CategoryItem(id: 1, text: "Your order fills at the closing NAV price", correctCategory: "Mutual Fund"),
                            CategoryItem(id: 2, text: "Traded through a brokerage using a ticker symbol", correctCategory: "ETF"),
                            CategoryItem(id: 3, text: "Often has a minimum initial investment, like $1,000 or $3,000", correctCategory: "Mutual Fund")
                            ],
                            explanation: "ETFs act like stocks with live pricing and a ticker; mutual funds price once daily at NAV and frequently require a minimum to start."),
                        .trueFalse(id: "u6l2q3", prompt: "If you place a mutual fund order at 11 a.m., it is executed instantly at that moment's live price.", correctIsTrue: false,
                            explanation: "Mutual fund orders all fill at the same day-end NAV, no matter what time of day you place them."),
                        .multipleChoice(id: "u6l2q4", prompt: "What are fractional shares?",
                            choices: [
                            AnswerChoice(id: 0, text: "Buying a portion of a share, so you can invest a set dollar amount even when one whole share is expensive"),
                            AnswerChoice(id: 1, text: "Shares that are broken and can't be sold"),
                            AnswerChoice(id: 2, text: "A share that pays no dividends"),
                            AnswerChoice(id: 3, text: "Free shares handed out by the government")
                            ], correct: 0,
                            explanation: "Fractional shares let you invest, say, $50 in a fund even if one full share costs hundreds — great for starting small."),
                        .multiSelect(id: "u6l2q5", prompt: "Which statements about ETFs are TRUE? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "They trade throughout the day"),
                            AnswerChoice(id: 1, text: "Many track an index, just like index mutual funds"),
                            AnswerChoice(id: 2, text: "They usually have a ticker symbol you can look up"),
                            AnswerChoice(id: 3, text: "They can only be sold once a year")
                            ], correctIDs: [0, 1, 2],
                            explanation: "ETFs trade live all day, carry a ticker, and often track indexes — you're never locked in to selling just once a year."),
                        .trueFalse(id: "u6l2q6", prompt: "Both ETFs and mutual funds let you own a basket of many investments in a single purchase.", correctIsTrue: true,
                            explanation: "Whichever wrapper you pick, one purchase buys a whole basket of holdings — instant diversification."),
                        .numeric(id: "u6l2q7", prompt: "One share of a fund costs $250, but you only want to invest $50. How many shares do you buy? (Enter as a decimal.)", answer: 0.2, tolerance: 0,
                            explanation: "$50 divided by $250 is 0.2 — fractional shares let you put in exactly the dollar amount you want.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit6-lesson3",
                    title: "What's Inside a Fund",
                    iconName: "chart.pie.fill",
                    questions: [
                        .multipleChoice(id: "u6l3q1", prompt: "What are a fund's \"holdings\"?",
                            choices: [
                            AnswerChoice(id: 0, text: "The individual investments, like stocks, that the fund owns"),
                            AnswerChoice(id: 1, text: "The fees the fund charges you"),
                            AnswerChoice(id: 2, text: "The number of investors in the fund"),
                            AnswerChoice(id: 3, text: "The bank that stores the fund")
                            ], correct: 0,
                            explanation: "A fund's holdings are simply the list of companies (or bonds) it owns on your behalf."),
                        .matching(id: "u6l3q2", prompt: "Match each company to the sector it belongs to.",
                            pairs: [
                            MatchPair(id: 0, left: "Apple", right: "Technology"),
                            MatchPair(id: 1, left: "ExxonMobil", right: "Energy"),
                            MatchPair(id: 2, left: "Pfizer", right: "Health Care"),
                            MatchPair(id: 3, left: "JPMorgan Chase", right: "Financials")
                            ],
                            explanation: "Funds group their holdings into sectors so you can see how your money is spread across the economy."),
                        .trueFalse(id: "u6l3q3", prompt: "In a market-cap-weighted index fund, bigger companies make up a larger share of the fund.", correctIsTrue: true,
                            explanation: "Market-cap weighting means a giant like Apple takes up far more of the fund than a small company does."),
                        .numeric(id: "u6l3q4", prompt: "A fund puts 7% of its money into its largest holding. If you invest $1,000, how many dollars are in that one company?", answer: 70, tolerance: 0, prefix: "$",
                            explanation: "7% of $1,000 is $70 — the weighting tells you how much of your money sits in each holding."),
                        .multipleChoice(id: "u6l3q5", prompt: "Why does one share of a broad fund usually carry less risk than one single stock?",
                            choices: [
                            AnswerChoice(id: 0, text: "If one company does badly, the others can cushion the blow"),
                            AnswerChoice(id: 1, text: "Because funds can never fall in value"),
                            AnswerChoice(id: 2, text: "Because the government insures all funds"),
                            AnswerChoice(id: 3, text: "Because funds only ever hold winning stocks")
                            ], correct: 0,
                            explanation: "Spreading money across many companies means no single failure can wipe you out — that's the power of diversification."),
                        .multiSelect(id: "u6l3q6", prompt: "What can you typically learn from a fund's fact sheet? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Its top holdings"),
                            AnswerChoice(id: 1, text: "How it's split across sectors"),
                            AnswerChoice(id: 2, text: "Exactly what it will be worth next year"),
                            AnswerChoice(id: 3, text: "Its expense ratio")
                            ], correctIDs: [0, 1, 3],
                            explanation: "A fact sheet shows holdings, sector breakdown, and fees — but no one can promise a future price."),
                        .trueFalse(id: "u6l3q7", prompt: "Owning one share of a diversified fund means you indirectly own tiny slices of many different companies at once.", correctIsTrue: true,
                            explanation: "That single share represents a sliver of every company in the fund — one purchase, many businesses.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit6-lesson4",
                    title: "Why Fees Matter",
                    iconName: "percent",
                    questions: [
                        .multipleChoice(id: "u6l4q1", prompt: "What is an expense ratio?",
                            choices: [
                            AnswerChoice(id: 0, text: "A fund's yearly fee, shown as a percent of the money you have invested"),
                            AnswerChoice(id: 1, text: "The return the fund guarantees you"),
                            AnswerChoice(id: 2, text: "A one-time fee just to open an account"),
                            AnswerChoice(id: 3, text: "The tax you owe on your gains")
                            ], correct: 0,
                            explanation: "The expense ratio is the slice the fund quietly takes each year — a 0.10% ratio means $1 per $1,000 invested."),
                        .numeric(id: "u6l4q2", prompt: "A fund has a 0.50% expense ratio. On a $10,000 investment, how many dollars does that fee cost you in one year?", answer: 50, tolerance: 0, prefix: "$",
                            explanation: "0.50% of $10,000 is $50 — that's what comes out of your pocket each year for holding the fund."),
                        .numeric(id: "u6l4q3", prompt: "Fund A charges 0.05% and Fund B charges 1.05% on a $10,000 balance. How many MORE dollars per year does Fund B cost?", answer: 100, tolerance: 0, prefix: "$",
                            explanation: "The 1.00% gap on $10,000 is $100 a year — and that difference compounds against you for as long as you invest."),
                        .trueFalse(id: "u6l4q4", prompt: "A 1% annual fee sounds tiny, but over decades it can quietly cost you tens of thousands of dollars in lost growth.", correctIsTrue: true,
                            explanation: "Every dollar taken in fees is also a dollar that never compounds for you, so small fees snowball over a lifetime."),
                        .ordering(id: "u6l4q5", prompt: "Order these funds from cheapest to most expensive by expense ratio.",
                            items: [
                            "0.03%",
                            "0.20%",
                            "0.75%",
                            "1.25%"
                            ],
                            explanation: "Lower expense ratios keep more of your money invested and compounding — cheaper is usually better."),
                        .multipleChoice(id: "u6l4q6", prompt: "Why do fees hurt more the longer you invest?",
                            choices: [
                            AnswerChoice(id: 0, text: "You lose the fee AND all the future growth that money could have earned — year after year"),
                            AnswerChoice(id: 1, text: "Fees only apply during the first year"),
                            AnswerChoice(id: 2, text: "Fees make the market go up"),
                            AnswerChoice(id: 3, text: "Fees are fully refunded at retirement")
                            ], correct: 0,
                            explanation: "Fees don't just take money once; they steal the compounding that money would have produced for decades."),
                        .multiSelect(id: "u6l4q7", prompt: "Which habits help you keep investing costs low? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Choosing low-expense-ratio index funds"),
                            AnswerChoice(id: 1, text: "Avoiding funds with high sales loads or commissions"),
                            AnswerChoice(id: 2, text: "Trading in and out constantly to chase hot funds"),
                            AnswerChoice(id: 3, text: "Comparing expense ratios before you buy")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Low ratios, avoiding loads, and comparing costs all help; constant trading usually adds fees and taxes.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit6-lesson5",
                    title: "Automated Investing",
                    iconName: "gearshape.2.fill",
                    questions: [
                        .multipleChoice(id: "u6l5q1", prompt: "What is a robo-advisor?",
                            choices: [
                            AnswerChoice(id: 0, text: "An online service that automatically builds and manages a diversified portfolio for you, usually for a low fee"),
                            AnswerChoice(id: 1, text: "A robot that visits your house to give advice"),
                            AnswerChoice(id: 2, text: "A stock that only trades on weekends"),
                            AnswerChoice(id: 3, text: "A government retirement program")
                            ], correct: 0,
                            explanation: "Robo-advisors use software to pick low-cost funds, rebalance, and manage your mix so you don't have to do it by hand."),
                        .multipleChoice(id: "u6l5q2", prompt: "What is a target-date fund?",
                            choices: [
                            AnswerChoice(id: 0, text: "A fund that automatically shifts from riskier to safer investments as your target year approaches"),
                            AnswerChoice(id: 1, text: "A fund you're forced to sell on one specific date"),
                            AnswerChoice(id: 2, text: "A fund that holds just one stock"),
                            AnswerChoice(id: 3, text: "A fund that charges no fees ever")
                            ], correct: 0,
                            explanation: "A target-date fund starts aggressive and gradually turns conservative as your goal year — like retirement — nears."),
                        .trueFalse(id: "u6l5q3", prompt: "A target-date fund labeled '2065' is designed for someone planning to retire around the year 2065.", correctIsTrue: true,
                            explanation: "The year in the name is the rough target — the fund adjusts its risk on a glide path toward that date."),
                        .matching(id: "u6l5q4", prompt: "Match each tool to what it does for you.",
                            pairs: [
                            MatchPair(id: 0, left: "Robo-advisor", right: "Auto-manages a portfolio based on your goals"),
                            MatchPair(id: 1, left: "Target-date fund", right: "Gets more conservative as a set year nears"),
                            MatchPair(id: 2, left: "Index fund", right: "Tracks a whole market index at low cost"),
                            MatchPair(id: 3, left: "Automatic deposit", right: "Invests a set amount on a schedule for you")
                            ],
                            explanation: "Each of these takes a decision off your plate, making it easier to stay invested consistently."),
                        .trueFalse(id: "u6l5q5", prompt: "'Set and forget' investing works partly because automation keeps you consistent and reduces emotional buy and sell decisions.", correctIsTrue: true,
                            explanation: "Automating deposits removes the temptation to time the market or panic, which is where many investors trip up."),
                        .multiSelect(id: "u6l5q6", prompt: "Which are real benefits of automated investing? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It keeps you diversified without constant effort"),
                            AnswerChoice(id: 1, text: "It removes the temptation to panic-sell"),
                            AnswerChoice(id: 2, text: "It guarantees a profit every year"),
                            AnswerChoice(id: 3, text: "It can automatically rebalance your portfolio")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Automation helps with diversification, discipline, and rebalancing — but nothing can guarantee yearly profits."),
                        .numeric(id: "u6l5q7", prompt: "You set up an automatic investment of $50 every month. How many dollars will you have invested after one year (12 months)?", answer: 600, tolerance: 0, prefix: "$",
                            explanation: "$50 times 12 months is $600 — small automatic amounts quietly add up over time.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit6-check",
                    title: "Funds & Fees: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u6l1q2-kc", prompt: "An index fund's goal is to match the market's return, not to beat it.", correctIsTrue: true,
                            explanation: "By copying the index instead of trying to outsmart it, index funds aim for the market's average return at very low cost."),
                        .multiSelect(id: "u6l1q4-kc", prompt: "Which of these are real advantages of index funds? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Instant diversification across many companies"),
                            AnswerChoice(id: 1, text: "Low costs because there's no expensive stock-picking team"),
                            AnswerChoice(id: 2, text: "A guarantee that you'll never lose money"),
                            AnswerChoice(id: 3, text: "They have historically beaten most active funds over the long run")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Index funds are cheap, diversified, and beat most active funds over time — but no investment can promise you'll never lose money."),
                        .trueFalse(id: "u6l1q6-kc", prompt: "Because most active fund managers fail to beat their index over the long run, a low-cost index fund is often a smart default.", correctIsTrue: true,
                            explanation: "Study after study shows the large majority of active managers lag their benchmark after fees, which is why index funds are so popular."),
                        .categorize(id: "u6l2q2-kc", prompt: "Sort each trait into ETF or Mutual Fund.",
                            categories: ["ETF", "Mutual Fund"],
                            items: [
                            CategoryItem(id: 0, text: "You can buy or sell it anytime the market is open", correctCategory: "ETF"),
                            CategoryItem(id: 1, text: "Your order fills at the closing NAV price", correctCategory: "Mutual Fund"),
                            CategoryItem(id: 2, text: "Traded through a brokerage using a ticker symbol", correctCategory: "ETF"),
                            CategoryItem(id: 3, text: "Often has a minimum initial investment, like $1,000 or $3,000", correctCategory: "Mutual Fund")
                            ],
                            explanation: "ETFs act like stocks with live pricing and a ticker; mutual funds price once daily at NAV and frequently require a minimum to start."),
                        .multipleChoice(id: "u6l2q4-kc", prompt: "What are fractional shares?",
                            choices: [
                            AnswerChoice(id: 0, text: "Buying a portion of a share, so you can invest a set dollar amount even when one whole share is expensive"),
                            AnswerChoice(id: 1, text: "Shares that are broken and can't be sold"),
                            AnswerChoice(id: 2, text: "A share that pays no dividends"),
                            AnswerChoice(id: 3, text: "Free shares handed out by the government")
                            ], correct: 0,
                            explanation: "Fractional shares let you invest, say, $50 in a fund even if one full share costs hundreds — great for starting small."),
                        .trueFalse(id: "u6l2q6-kc", prompt: "Both ETFs and mutual funds let you own a basket of many investments in a single purchase.", correctIsTrue: true,
                            explanation: "Whichever wrapper you pick, one purchase buys a whole basket of holdings — instant diversification."),
                        .matching(id: "u6l3q2-kc", prompt: "Match each company to the sector it belongs to.",
                            pairs: [
                            MatchPair(id: 0, left: "Apple", right: "Technology"),
                            MatchPair(id: 1, left: "ExxonMobil", right: "Energy"),
                            MatchPair(id: 2, left: "Pfizer", right: "Health Care"),
                            MatchPair(id: 3, left: "JPMorgan Chase", right: "Financials")
                            ],
                            explanation: "Funds group their holdings into sectors so you can see how your money is spread across the economy."),
                        .numeric(id: "u6l3q4-kc", prompt: "A fund puts 7% of its money into its largest holding. If you invest $1,000, how many dollars are in that one company?", answer: 70, tolerance: 0, prefix: "$",
                            explanation: "7% of $1,000 is $70 — the weighting tells you how much of your money sits in each holding."),
                        .multiSelect(id: "u6l3q6-kc", prompt: "What can you typically learn from a fund's fact sheet? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Its top holdings"),
                            AnswerChoice(id: 1, text: "How it's split across sectors"),
                            AnswerChoice(id: 2, text: "Exactly what it will be worth next year"),
                            AnswerChoice(id: 3, text: "Its expense ratio")
                            ], correctIDs: [0, 1, 3],
                            explanation: "A fact sheet shows holdings, sector breakdown, and fees — but no one can promise a future price."),
                        .numeric(id: "u6l4q2-kc", prompt: "A fund has a 0.50% expense ratio. On a $10,000 investment, how many dollars does that fee cost you in one year?", answer: 50, tolerance: 0, prefix: "$",
                            explanation: "0.50% of $10,000 is $50 — that's what comes out of your pocket each year for holding the fund."),
                        .trueFalse(id: "u6l4q4-kc", prompt: "A 1% annual fee sounds tiny, but over decades it can quietly cost you tens of thousands of dollars in lost growth.", correctIsTrue: true,
                            explanation: "Every dollar taken in fees is also a dollar that never compounds for you, so small fees snowball over a lifetime."),
                        .multipleChoice(id: "u6l4q6-kc", prompt: "Why do fees hurt more the longer you invest?",
                            choices: [
                            AnswerChoice(id: 0, text: "You lose the fee AND all the future growth that money could have earned — year after year"),
                            AnswerChoice(id: 1, text: "Fees only apply during the first year"),
                            AnswerChoice(id: 2, text: "Fees make the market go up"),
                            AnswerChoice(id: 3, text: "Fees are fully refunded at retirement")
                            ], correct: 0,
                            explanation: "Fees don't just take money once; they steal the compounding that money would have produced for decades."),
                        .multipleChoice(id: "u6l5q2-kc", prompt: "What is a target-date fund?",
                            choices: [
                            AnswerChoice(id: 0, text: "A fund that automatically shifts from riskier to safer investments as your target year approaches"),
                            AnswerChoice(id: 1, text: "A fund you're forced to sell on one specific date"),
                            AnswerChoice(id: 2, text: "A fund that holds just one stock"),
                            AnswerChoice(id: 3, text: "A fund that charges no fees ever")
                            ], correct: 0,
                            explanation: "A target-date fund starts aggressive and gradually turns conservative as your goal year — like retirement — nears."),
                        .matching(id: "u6l5q4-kc", prompt: "Match each tool to what it does for you.",
                            pairs: [
                            MatchPair(id: 0, left: "Robo-advisor", right: "Auto-manages a portfolio based on your goals"),
                            MatchPair(id: 1, left: "Target-date fund", right: "Gets more conservative as a set year nears"),
                            MatchPair(id: 2, left: "Index fund", right: "Tracks a whole market index at low cost"),
                            MatchPair(id: 3, left: "Automatic deposit", right: "Invests a set amount on a schedule for you")
                            ],
                            explanation: "Each of these takes a decision off your plate, making it easier to stay invested consistently."),
                        .multiSelect(id: "u6l5q6-kc", prompt: "Which are real benefits of automated investing? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It keeps you diversified without constant effort"),
                            AnswerChoice(id: 1, text: "It removes the temptation to panic-sell"),
                            AnswerChoice(id: 2, text: "It guarantees a profit every year"),
                            AnswerChoice(id: 3, text: "It can automatically rebalance your portfolio")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Automation helps with diversification, discipline, and rebalancing — but nothing can guarantee yearly profits.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let macroEconOne = LearningUnit(
            id: "unit10",
            title: "Unit 8: Macro Economics I",
            subtitle: "The big picture and the business cycle",
            colorHex: "2EC4B6",
            lessons: [
                Lesson(
                    id: "unit10-lesson1",
                    title: "What Is Macroeconomics?",
                    iconName: "globe.americas.fill",
                    questions: [
                        .multipleChoice(id: "u10l1q1", prompt: "What does macroeconomics study?",
                            choices: [
                            AnswerChoice(id: 0, text: "The economy as a whole — things like a country's total output, inflation, and jobs"),
                            AnswerChoice(id: 1, text: "Only how one family budgets its monthly income"),
                            AnswerChoice(id: 2, text: "How to pick a single winning stock"),
                            AnswerChoice(id: 3, text: "The payroll rules inside one small company")
                            ], correct: 0,
                            explanation: "Macroeconomics zooms out to the whole economy — total production, prices, and employment — instead of one person or business."),
                        .trueFalse(id: "u10l1q2", prompt: "Microeconomics looks at individual choices (one person or business), while macroeconomics looks at the whole economy.", correctIsTrue: true,
                            explanation: "Micro means the small, individual scale; macro means the big, whole-economy scale."),
                        .matching(id: "u10l1q3", prompt: "Match each question to whether it is a micro or a macro question.",
                            pairs: [
                            MatchPair(id: 0, left: "Should I buy a $5 coffee or save it?", right: "Micro"),
                            MatchPair(id: 1, left: "Is the whole country's unemployment rising?", right: "Macro"),
                            MatchPair(id: 2, left: "Should this bakery raise its bread price?", right: "Micro"),
                            MatchPair(id: 3, left: "Is inflation across the nation speeding up?", right: "Macro")
                            ],
                            explanation: "Personal or single-business choices are micro; nationwide totals like inflation and unemployment are macro."),
                        .multiSelect(id: "u10l1q4", prompt: "Which of these are macroeconomic topics? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A nation's total economic output (GDP)"),
                            AnswerChoice(id: 1, text: "The country's overall inflation rate"),
                            AnswerChoice(id: 2, text: "Which sneakers you should buy this week"),
                            AnswerChoice(id: 3, text: "The national unemployment rate")
                            ], correctIDs: [0, 1, 3],
                            explanation: "GDP, inflation, and unemployment describe the whole economy. Your sneaker choice is a personal, micro decision."),
                        .categorize(id: "u10l1q5", prompt: "Sort each topic into microeconomics or macroeconomics.",
                            categories: ["Microeconomics", "Macroeconomics"],
                            items: [
                            CategoryItem(id: 0, text: "Your family's grocery budget", correctCategory: "Microeconomics"),
                            CategoryItem(id: 1, text: "The nation's total output", correctCategory: "Macroeconomics"),
                            CategoryItem(id: 2, text: "One coffee shop's pricing", correctCategory: "Microeconomics"),
                            CategoryItem(id: 3, text: "Countrywide inflation", correctCategory: "Macroeconomics"),
                            CategoryItem(id: 4, text: "A single store's hiring", correctCategory: "Microeconomics")
                            ],
                            explanation: "One person, family, or business is micro. Whole-country totals are macro."),
                        .multipleChoice(id: "u10l1q6", prompt: "Across a whole economy, what usually happens to prices when total demand for goods rises much faster than businesses can produce them?",
                            choices: [
                            AnswerChoice(id: 0, text: "Prices tend to rise (upward pressure on prices)"),
                            AnswerChoice(id: 1, text: "Prices fall all the way to zero"),
                            AnswerChoice(id: 2, text: "Prices can never change"),
                            AnswerChoice(id: 3, text: "The economy instantly shuts down")
                            ], correct: 0,
                            explanation: "Just like in a single market, when economy-wide demand outruns supply, prices get pushed up."),
                        .trueFalse(id: "u10l1q7", prompt: "Even though it studies the whole economy, macroeconomics still uses the ideas of supply and demand — just at a much larger scale.", correctIsTrue: true,
                            explanation: "Supply and demand work for one lemonade stand and for an entire country's economy alike.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit10-lesson2",
                    title: "GDP & Economic Growth",
                    iconName: "chart.line.uptrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u10l2q1", prompt: "What does GDP (Gross Domestic Product) measure?",
                            choices: [
                            AnswerChoice(id: 0, text: "The total value of all goods and services a country produces in a period"),
                            AnswerChoice(id: 1, text: "The total number of people living in a country"),
                            AnswerChoice(id: 2, text: "How much cash the government keeps in the bank"),
                            AnswerChoice(id: 3, text: "The price of a single company's stock")
                            ], correct: 0,
                            explanation: "GDP adds up the value of everything a country produces — it's the main scoreboard for the size of an economy."),
                        .trueFalse(id: "u10l2q2", prompt: "When GDP is growing, the economy is producing more goods and services than before.", correctIsTrue: true,
                            explanation: "Rising GDP means more output — usually a sign of an expanding, healthier economy."),
                        .multipleChoice(id: "u10l2q3", prompt: "An economy is said to be in a contraction (or recession) when...",
                            choices: [
                            AnswerChoice(id: 0, text: "Its GDP is shrinking — total output is falling"),
                            AnswerChoice(id: 1, text: "Its GDP is growing quickly"),
                            AnswerChoice(id: 2, text: "Prices become perfectly stable"),
                            AnswerChoice(id: 3, text: "Everyone suddenly gets a raise")
                            ], correct: 0,
                            explanation: "A contraction means the economy is shrinking — GDP falls instead of grows."),
                        .numeric(id: "u10l2q4", prompt: "A country's GDP grows from $1,000 billion to $1,030 billion in a year. What is the growth rate?", answer: 3, tolerance: 0, suffix: "%",
                            explanation: "The increase is $30 billion; $30 ÷ $1,000 = 0.03 = 3% growth."),
                        .categorize(id: "u10l2q5", prompt: "Sort each situation into growth or contraction.",
                            categories: ["Growth", "Contraction"],
                            items: [
                            CategoryItem(id: 0, text: "Factories produce more cars than last year", correctCategory: "Growth"),
                            CategoryItem(id: 1, text: "GDP falls for six months straight", correctCategory: "Contraction"),
                            CategoryItem(id: 2, text: "More new businesses open and hire", correctCategory: "Growth"),
                            CategoryItem(id: 3, text: "Output drops and shops cut back", correctCategory: "Contraction")
                            ],
                            explanation: "More output is growth; falling output is contraction."),
                        .multiSelect(id: "u10l2q6", prompt: "Which of these count toward this year's GDP? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A new car built and sold this year"),
                            AnswerChoice(id: 1, text: "A haircut you paid for this year"),
                            AnswerChoice(id: 2, text: "A used car resold from five years ago"),
                            AnswerChoice(id: 3, text: "A fresh loaf of bread baked and sold this year")
                            ], correctIDs: [0, 1, 3],
                            explanation: "GDP counts new goods and services produced this period. Reselling an old used car isn't new production, so it doesn't add to GDP."),
                        .numeric(id: "u10l2q7", prompt: "Using the Rule of 72, if GDP grows about 3% per year, roughly how many years does the economy take to double in size?", answer: 24, tolerance: 0, suffix: " years",
                            explanation: "72 ÷ 3 = 24, so at 3% annual growth an economy roughly doubles in about 24 years.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit10-lesson3",
                    title: "Inflation & Prices",
                    iconName: "dollarsign.arrow.circlepath",
                    questions: [
                        .multipleChoice(id: "u10l3q1", prompt: "What is inflation?",
                            choices: [
                            AnswerChoice(id: 0, text: "A general rise in the prices of goods and services over time"),
                            AnswerChoice(id: 1, text: "A drop in the price of everything"),
                            AnswerChoice(id: 2, text: "The total number of jobs in a country"),
                            AnswerChoice(id: 3, text: "The interest a bank pays you")
                            ], correct: 0,
                            explanation: "Inflation is the overall upward drift of prices — the same dollar buys a little less each year."),
                        .trueFalse(id: "u10l3q2", prompt: "During inflation, a dollar buys less than it used to — its purchasing power falls.", correctIsTrue: true,
                            explanation: "When prices rise, each dollar stretches less far, so your money's purchasing power shrinks."),
                        .multipleChoice(id: "u10l3q3", prompt: "What is the Consumer Price Index (CPI) used for?",
                            choices: [
                            AnswerChoice(id: 0, text: "Tracking the average price of a typical basket of goods and services over time"),
                            AnswerChoice(id: 1, text: "Counting how many people have jobs"),
                            AnswerChoice(id: 2, text: "Measuring a single company's profit"),
                            AnswerChoice(id: 3, text: "Setting the price of gold")
                            ], correct: 0,
                            explanation: "The CPI follows the cost of a common basket of everyday items, so it's a key gauge of inflation."),
                        .trueFalse(id: "u10l3q4", prompt: "In many countries, central banks aim for an inflation rate of about 2% per year.", correctIsTrue: true,
                            explanation: "A low, steady ~2% is seen as healthy — enough to keep the economy moving without eroding money too fast."),
                        .numeric(id: "u10l3q5", prompt: "Your savings earned a 5% nominal return this year, but inflation was 2%. What was your approximate real return?", answer: 3, tolerance: 0, suffix: "%",
                            explanation: "Real return is roughly nominal return minus inflation: 5% − 2% = 3%. That's your gain in actual buying power."),
                        .matching(id: "u10l3q6", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Inflation", right: "The general rise in prices over time"),
                            MatchPair(id: 1, left: "Purchasing power", right: "How much your money can actually buy"),
                            MatchPair(id: 2, left: "CPI", right: "An index tracking the price of a basket of goods"),
                            MatchPair(id: 3, left: "Real return", right: "Your return after subtracting inflation")
                            ],
                            explanation: "These four ideas explain how rising prices quietly shrink the value of money."),
                        .numeric(id: "u10l3q7", prompt: "A basket of goods cost $100 last year. With 2% inflation, what does that same basket cost this year?", answer: 102, tolerance: 0, prefix: "$",
                            explanation: "2% of $100 is $2, so the basket now costs $100 + $2 = $102.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit10-lesson4",
                    title: "Unemployment & Jobs",
                    iconName: "briefcase.fill",
                    questions: [
                        .multipleChoice(id: "u10l4q1", prompt: "What does the unemployment rate measure?",
                            choices: [
                            AnswerChoice(id: 0, text: "The percentage of the labor force who want a job but don't have one"),
                            AnswerChoice(id: 1, text: "The total number of people in the country"),
                            AnswerChoice(id: 2, text: "How much money workers earn"),
                            AnswerChoice(id: 3, text: "The number of companies that exist")
                            ], correct: 0,
                            explanation: "It's the share of people who are actively looking for work but can't find it, out of everyone in the labor force."),
                        .numeric(id: "u10l4q2", prompt: "In a labor force of 200 people, 10 are unemployed and looking for work. What is the unemployment rate?", answer: 5, tolerance: 0, suffix: "%",
                            explanation: "10 ÷ 200 = 0.05 = 5%. Unemployment rate is unemployed people divided by the labor force."),
                        .trueFalse(id: "u10l4q3", prompt: "A small amount of unemployment is normal, because people are always switching jobs or just entering the workforce.", correctIsTrue: true,
                            explanation: "Some 'frictional' unemployment is healthy — it just means people are moving between jobs. Zero unemployment almost never happens."),
                        .multiSelect(id: "u10l4q4", prompt: "When unemployment rises sharply, what tends to happen? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "People have less income to spend"),
                            AnswerChoice(id: 1, text: "Overall consumer spending tends to fall"),
                            AnswerChoice(id: 2, text: "Everyone instantly gets richer"),
                            AnswerChoice(id: 3, text: "Businesses may sell less and slow down")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Fewer paychecks means less spending, which can ripple out and slow the whole economy."),
                        .matching(id: "u10l4q5", prompt: "Match each type of unemployment to an example.",
                            pairs: [
                            MatchPair(id: 0, left: "Frictional", right: "Someone quit to search for a better job"),
                            MatchPair(id: 1, left: "Cyclical", right: "People laid off during a recession"),
                            MatchPair(id: 2, left: "Structural", right: "A worker's skills no longer match available jobs")
                            ],
                            explanation: "Frictional is between jobs; cyclical follows the business cycle; structural is a mismatch of skills or industries."),
                        .trueFalse(id: "u10l4q6", prompt: "An unemployment rate of exactly 0% is the normal, healthy goal for every economy.", correctIsTrue: false,
                            explanation: "Some unemployment is always expected as people switch jobs; economists aim for low unemployment, not zero."),
                        .multipleChoice(id: "u10l4q7", prompt: "A full-time student who is not looking for work is counted as...",
                            choices: [
                            AnswerChoice(id: 0, text: "Not in the labor force, so not counted as unemployed"),
                            AnswerChoice(id: 1, text: "Unemployed"),
                            AnswerChoice(id: 2, text: "Employed"),
                            AnswerChoice(id: 3, text: "The main cause of inflation")
                            ], correct: 0,
                            explanation: "To be 'unemployed' you must be actively looking for work. People not seeking a job aren't in the labor force at all.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit10-lesson5",
                    title: "The Business Cycle",
                    iconName: "arrow.triangle.2.circlepath",
                    questions: [
                        .ordering(id: "u10l5q1", prompt: "Put the four phases of the business cycle in order, starting from a growing economy.",
                            items: [
                            "Expansion",
                            "Peak",
                            "Contraction",
                            "Trough"
                            ],
                            explanation: "The economy grows (expansion), tops out (peak), shrinks (contraction), and bottoms out (trough) — then it starts over."),
                        .matching(id: "u10l5q2", prompt: "Match each business-cycle phase to its description.",
                            pairs: [
                            MatchPair(id: 0, left: "Expansion", right: "The economy is growing and jobs are rising"),
                            MatchPair(id: 1, left: "Peak", right: "Growth tops out at its highest point"),
                            MatchPair(id: 2, left: "Contraction", right: "The economy shrinks and output falls"),
                            MatchPair(id: 3, left: "Trough", right: "The low point before growth begins again")
                            ],
                            explanation: "These four phases repeat over and over — that's why it's called a cycle."),
                        .trueFalse(id: "u10l5q3", prompt: "The business cycle always turns — no expansion lasts forever, and no contraction lasts forever either.", correctIsTrue: true,
                            explanation: "Booms eventually cool and downturns eventually recover — the cycle keeps turning."),
                        .multipleChoice(id: "u10l5q4", prompt: "A recession is another name for which phase of the business cycle?",
                            choices: [
                            AnswerChoice(id: 0, text: "A contraction, when the economy is shrinking"),
                            AnswerChoice(id: 1, text: "A peak, when growth is highest"),
                            AnswerChoice(id: 2, text: "An expansion, when the economy is growing"),
                            AnswerChoice(id: 3, text: "A trough that lasts only one day")
                            ], correct: 0,
                            explanation: "A recession is a significant, sustained contraction — falling output across the economy."),
                        .multiSelect(id: "u10l5q5", prompt: "Which are typical signs of an economic expansion? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Rising GDP"),
                            AnswerChoice(id: 1, text: "Falling unemployment"),
                            AnswerChoice(id: 2, text: "Widespread layoffs and shrinking output"),
                            AnswerChoice(id: 3, text: "Growing consumer spending")
                            ], correctIDs: [0, 1, 3],
                            explanation: "During an expansion, output, jobs, and spending all tend to rise. Widespread layoffs signal a contraction instead."),
                        .categorize(id: "u10l5q6", prompt: "Sort each event into the expansion or contraction phase.",
                            categories: ["Expansion", "Contraction"],
                            items: [
                            CategoryItem(id: 0, text: "Companies hire more workers", correctCategory: "Expansion"),
                            CategoryItem(id: 1, text: "GDP falls for months", correctCategory: "Contraction"),
                            CategoryItem(id: 2, text: "Consumer spending climbs", correctCategory: "Expansion"),
                            CategoryItem(id: 3, text: "Layoffs spread across industries", correctCategory: "Contraction")
                            ],
                            explanation: "Growth, hiring, and rising spending mark an expansion; falling output and layoffs mark a contraction."),
                        .multipleChoice(id: "u10l5q7", prompt: "The lowest point of the business cycle, just before the economy starts to recover, is called the...",
                            choices: [
                            AnswerChoice(id: 0, text: "Trough"),
                            AnswerChoice(id: 1, text: "Peak"),
                            AnswerChoice(id: 2, text: "Expansion"),
                            AnswerChoice(id: 3, text: "Boom")
                            ], correct: 0,
                            explanation: "The trough is the bottom — the turning point where a contraction ends and a new expansion begins.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit10-check",
                    title: "Macro Economics I: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u10l1q2-kc", prompt: "Microeconomics looks at individual choices (one person or business), while macroeconomics looks at the whole economy.", correctIsTrue: true,
                            explanation: "Micro means the small, individual scale; macro means the big, whole-economy scale."),
                        .multiSelect(id: "u10l1q4-kc", prompt: "Which of these are macroeconomic topics? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A nation's total economic output (GDP)"),
                            AnswerChoice(id: 1, text: "The country's overall inflation rate"),
                            AnswerChoice(id: 2, text: "Which sneakers you should buy this week"),
                            AnswerChoice(id: 3, text: "The national unemployment rate")
                            ], correctIDs: [0, 1, 3],
                            explanation: "GDP, inflation, and unemployment describe the whole economy. Your sneaker choice is a personal, micro decision."),
                        .multipleChoice(id: "u10l1q6-kc", prompt: "Across a whole economy, what usually happens to prices when total demand for goods rises much faster than businesses can produce them?",
                            choices: [
                            AnswerChoice(id: 0, text: "Prices tend to rise (upward pressure on prices)"),
                            AnswerChoice(id: 1, text: "Prices fall all the way to zero"),
                            AnswerChoice(id: 2, text: "Prices can never change"),
                            AnswerChoice(id: 3, text: "The economy instantly shuts down")
                            ], correct: 0,
                            explanation: "Just like in a single market, when economy-wide demand outruns supply, prices get pushed up."),
                        .trueFalse(id: "u10l2q2-kc", prompt: "When GDP is growing, the economy is producing more goods and services than before.", correctIsTrue: true,
                            explanation: "Rising GDP means more output — usually a sign of an expanding, healthier economy."),
                        .numeric(id: "u10l2q4-kc", prompt: "A country's GDP grows from $1,000 billion to $1,030 billion in a year. What is the growth rate?", answer: 3, tolerance: 0, suffix: "%",
                            explanation: "The increase is $30 billion; $30 ÷ $1,000 = 0.03 = 3% growth."),
                        .multiSelect(id: "u10l2q6-kc", prompt: "Which of these count toward this year's GDP? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A new car built and sold this year"),
                            AnswerChoice(id: 1, text: "A haircut you paid for this year"),
                            AnswerChoice(id: 2, text: "A used car resold from five years ago"),
                            AnswerChoice(id: 3, text: "A fresh loaf of bread baked and sold this year")
                            ], correctIDs: [0, 1, 3],
                            explanation: "GDP counts new goods and services produced this period. Reselling an old used car isn't new production, so it doesn't add to GDP."),
                        .trueFalse(id: "u10l3q2-kc", prompt: "During inflation, a dollar buys less than it used to — its purchasing power falls.", correctIsTrue: true,
                            explanation: "When prices rise, each dollar stretches less far, so your money's purchasing power shrinks."),
                        .trueFalse(id: "u10l3q4-kc", prompt: "In many countries, central banks aim for an inflation rate of about 2% per year.", correctIsTrue: true,
                            explanation: "A low, steady ~2% is seen as healthy — enough to keep the economy moving without eroding money too fast."),
                        .matching(id: "u10l3q6-kc", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Inflation", right: "The general rise in prices over time"),
                            MatchPair(id: 1, left: "Purchasing power", right: "How much your money can actually buy"),
                            MatchPair(id: 2, left: "CPI", right: "An index tracking the price of a basket of goods"),
                            MatchPair(id: 3, left: "Real return", right: "Your return after subtracting inflation")
                            ],
                            explanation: "These four ideas explain how rising prices quietly shrink the value of money."),
                        .numeric(id: "u10l4q2-kc", prompt: "In a labor force of 200 people, 10 are unemployed and looking for work. What is the unemployment rate?", answer: 5, tolerance: 0, suffix: "%",
                            explanation: "10 ÷ 200 = 0.05 = 5%. Unemployment rate is unemployed people divided by the labor force."),
                        .multiSelect(id: "u10l4q4-kc", prompt: "When unemployment rises sharply, what tends to happen? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "People have less income to spend"),
                            AnswerChoice(id: 1, text: "Overall consumer spending tends to fall"),
                            AnswerChoice(id: 2, text: "Everyone instantly gets richer"),
                            AnswerChoice(id: 3, text: "Businesses may sell less and slow down")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Fewer paychecks means less spending, which can ripple out and slow the whole economy."),
                        .trueFalse(id: "u10l4q6-kc", prompt: "An unemployment rate of exactly 0% is the normal, healthy goal for every economy.", correctIsTrue: false,
                            explanation: "Some unemployment is always expected as people switch jobs; economists aim for low unemployment, not zero."),
                        .matching(id: "u10l5q2-kc", prompt: "Match each business-cycle phase to its description.",
                            pairs: [
                            MatchPair(id: 0, left: "Expansion", right: "The economy is growing and jobs are rising"),
                            MatchPair(id: 1, left: "Peak", right: "Growth tops out at its highest point"),
                            MatchPair(id: 2, left: "Contraction", right: "The economy shrinks and output falls"),
                            MatchPair(id: 3, left: "Trough", right: "The low point before growth begins again")
                            ],
                            explanation: "These four phases repeat over and over — that's why it's called a cycle."),
                        .multipleChoice(id: "u10l5q4-kc", prompt: "A recession is another name for which phase of the business cycle?",
                            choices: [
                            AnswerChoice(id: 0, text: "A contraction, when the economy is shrinking"),
                            AnswerChoice(id: 1, text: "A peak, when growth is highest"),
                            AnswerChoice(id: 2, text: "An expansion, when the economy is growing"),
                            AnswerChoice(id: 3, text: "A trough that lasts only one day")
                            ], correct: 0,
                            explanation: "A recession is a significant, sustained contraction — falling output across the economy."),
                        .categorize(id: "u10l5q6-kc", prompt: "Sort each event into the expansion or contraction phase.",
                            categories: ["Expansion", "Contraction"],
                            items: [
                            CategoryItem(id: 0, text: "Companies hire more workers", correctCategory: "Expansion"),
                            CategoryItem(id: 1, text: "GDP falls for months", correctCategory: "Contraction"),
                            CategoryItem(id: 2, text: "Consumer spending climbs", correctCategory: "Expansion"),
                            CategoryItem(id: 3, text: "Layoffs spread across industries", correctCategory: "Contraction")
                            ],
                            explanation: "Growth, hiring, and rising spending mark an expansion; falling output and layoffs mark a contraction.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let macroEconTwo = LearningUnit(
            id: "unit12",
            title: "Unit 9: Macro Economics II",
            subtitle: "Policy, trade, and the wider world",
            colorHex: "0077B6",
            lessons: [
                Lesson(
                    id: "unit12-lesson1",
                    title: "The Federal Reserve & Interest Rates",
                    iconName: "building.columns.fill",
                    questions: [
                        .multipleChoice(id: "u12l1q1", prompt: "What is the Federal Reserve (the 'Fed')?",
                            choices: [
                            AnswerChoice(id: 0, text: "The central bank of the United States"),
                            AnswerChoice(id: 1, text: "A regular bank where you open a checking account"),
                            AnswerChoice(id: 2, text: "The New York Stock Exchange"),
                            AnswerChoice(id: 3, text: "The agency that collects your taxes")
                            ], correct: 0,
                            explanation: "The Fed is the U.S. central bank. It manages the nation's money and steers interest rates rather than serving everyday customers."),
                        .multipleChoice(id: "u12l1q2", prompt: "The Fed's 'dual mandate' is to pursue which TWO goals?",
                            choices: [
                            AnswerChoice(id: 0, text: "Maximum employment and stable prices"),
                            AnswerChoice(id: 1, text: "Higher stock prices and more exports"),
                            AnswerChoice(id: 2, text: "Lower taxes and less regulation"),
                            AnswerChoice(id: 3, text: "A balanced budget and free trade")
                            ], correct: 0,
                            explanation: "Congress gave the Fed two jobs: keep as many people employed as possible while keeping prices (inflation) stable."),
                        .trueFalse(id: "u12l1q3", prompt: "The Federal Reserve is often called the 'central bank' of the United States.", correctIsTrue: true,
                            explanation: "A central bank manages a nation's currency and interest rates, and the Fed is exactly that for the U.S."),
                        .multipleChoice(id: "u12l1q4", prompt: "The main interest rate the Fed targets is the...",
                            choices: [
                            AnswerChoice(id: 0, text: "Federal funds rate"),
                            AnswerChoice(id: 1, text: "Mortgage rate"),
                            AnswerChoice(id: 2, text: "Credit card APR"),
                            AnswerChoice(id: 3, text: "Savings account rate")
                            ], correct: 0,
                            explanation: "The federal funds rate is what banks charge each other for overnight loans. When the Fed moves it, other rates across the economy tend to follow."),
                        .multiSelect(id: "u12l1q5", prompt: "Which of these are part of the Fed's job? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Setting key interest rates"),
                            AnswerChoice(id: 1, text: "Trying to keep inflation low and stable"),
                            AnswerChoice(id: 2, text: "Aiming for maximum employment"),
                            AnswerChoice(id: 3, text: "Setting the income tax rates you pay")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Interest rates, stable prices, and employment are the Fed's turf. Setting taxes belongs to Congress, not the Fed."),
                        .matching(id: "u12l1q6", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Central bank", right: "The institution that manages a nation's money and interest rates"),
                            MatchPair(id: 1, left: "Dual mandate", right: "The Fed's twin goals of stable prices and max employment"),
                            MatchPair(id: 2, left: "Federal funds rate", right: "The key overnight rate the Fed targets"),
                            MatchPair(id: 3, left: "Inflation", right: "A general rise in prices over time")
                            ],
                            explanation: "These four ideas are the backbone of how the Fed operates and why it exists."),
                        .trueFalse(id: "u12l1q7", prompt: "The Federal Reserve sets the income tax rates that citizens pay each year.", correctIsTrue: false,
                            explanation: "Taxes are set by Congress (that's fiscal policy). The Fed handles monetary policy, like interest rates.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit12-lesson2",
                    title: "Monetary Policy",
                    iconName: "percent",
                    questions: [
                        .multipleChoice(id: "u12l2q1", prompt: "When the economy is overheating and inflation is high, what does the Fed usually do?",
                            choices: [
                            AnswerChoice(id: 0, text: "Raise interest rates to cool it down"),
                            AnswerChoice(id: 1, text: "Cut interest rates to speed it up"),
                            AnswerChoice(id: 2, text: "Nothing at all"),
                            AnswerChoice(id: 3, text: "Print more tax forms")
                            ], correct: 0,
                            explanation: "Higher rates make borrowing pricier, which cools spending and demand, helping bring inflation back down."),
                        .multipleChoice(id: "u12l2q2", prompt: "When the Fed LOWERS interest rates, borrowing money generally becomes...",
                            choices: [
                            AnswerChoice(id: 0, text: "Cheaper, encouraging spending and investment"),
                            AnswerChoice(id: 1, text: "More expensive, discouraging spending"),
                            AnswerChoice(id: 2, text: "Illegal"),
                            AnswerChoice(id: 3, text: "Completely unchanged")
                            ], correct: 0,
                            explanation: "Lower rates mean cheaper loans, so people and businesses tend to borrow, spend, and invest more."),
                        .ordering(id: "u12l2q3", prompt: "Put the steps in order for how a Fed rate HIKE cools the economy.",
                            items: [
                            "The Fed raises its key interest rate",
                            "Loans and credit become more expensive",
                            "People and businesses borrow and spend less",
                            "Demand cools and inflation eases"
                            ],
                            explanation: "A hike raises borrowing costs, which slows spending, which cools demand and inflation. That's the chain reaction."),
                        .trueFalse(id: "u12l2q4", prompt: "Lowering interest rates is often called 'loosening' or 'easing' monetary policy.", correctIsTrue: true,
                            explanation: "Cutting rates 'loosens' or 'eases' conditions to give the economy more room to grow. Raising them is 'tightening.'"),
                        .numeric(id: "u12l2q5", prompt: "The Fed raises its target rate from 4.5% to 5.25%. By how many percentage points did it hike?", answer: 0.75, tolerance: 0, suffix: "%",
                            explanation: "5.25% minus 4.5% is 0.75 points, which traders also call a '75 basis point' hike."),
                        .multipleChoice(id: "u12l2q6", prompt: "Higher interest rates tend to do what to stock prices, all else equal?",
                            choices: [
                            AnswerChoice(id: 0, text: "Put downward pressure on them"),
                            AnswerChoice(id: 1, text: "Guarantee they rise"),
                            AnswerChoice(id: 2, text: "Have zero effect ever"),
                            AnswerChoice(id: 3, text: "Only affect crypto")
                            ], correct: 0,
                            explanation: "Higher rates make borrowing costlier for companies and make safe bonds more attractive, which often weighs on stocks."),
                        .multiSelect(id: "u12l2q7", prompt: "Which of these are goals of RAISING interest rates? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Slow down high inflation"),
                            AnswerChoice(id: 1, text: "Cool an overheating economy"),
                            AnswerChoice(id: 2, text: "Make borrowing more expensive on purpose"),
                            AnswerChoice(id: 3, text: "Instantly eliminate all unemployment")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Hikes are meant to cool demand and tame inflation. They don't fix employment instantly and can even raise unemployment short term.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit12-lesson3",
                    title: "Fiscal Policy",
                    iconName: "banknote.fill",
                    questions: [
                        .multipleChoice(id: "u12l3q1", prompt: "Fiscal policy refers to a government's use of...",
                            choices: [
                            AnswerChoice(id: 0, text: "Spending and taxes to influence the economy"),
                            AnswerChoice(id: 1, text: "Interest rates set by the central bank"),
                            AnswerChoice(id: 2, text: "Stock market trading"),
                            AnswerChoice(id: 3, text: "Foreign exchange reserves only")
                            ], correct: 0,
                            explanation: "Fiscal policy is the government's budget toolkit: how much it taxes and how much it spends."),
                        .categorize(id: "u12l3q2", prompt: "Sort each tool by who controls it.",
                            categories: ["Fiscal (Congress/Govt)", "Monetary (Fed)"],
                            items: [
                            CategoryItem(id: 0, text: "Setting income tax rates", correctCategory: "Fiscal (Congress/Govt)"),
                            CategoryItem(id: 1, text: "Government spending on roads", correctCategory: "Fiscal (Congress/Govt)"),
                            CategoryItem(id: 2, text: "Setting the federal funds rate", correctCategory: "Monetary (Fed)"),
                            CategoryItem(id: 3, text: "Sending stimulus checks", correctCategory: "Fiscal (Congress/Govt)"),
                            CategoryItem(id: 4, text: "Adjusting the money supply", correctCategory: "Monetary (Fed)")
                            ],
                            explanation: "Taxes and spending are fiscal (government); interest rates and money supply are monetary (Fed). Keeping them straight is key."),
                        .trueFalse(id: "u12l3q3", prompt: "A budget deficit happens when a government spends more than it collects in taxes.", correctIsTrue: true,
                            explanation: "Spend more than you take in and you run a deficit, covering the gap by borrowing."),
                        .numeric(id: "u12l3q4", prompt: "A government collects $3 trillion in taxes but spends $4 trillion in a year. What is its deficit? (Answer in trillions.)", answer: 1, tolerance: 0, suffix: " trillion",
                            explanation: "$4 trillion spent minus $3 trillion collected leaves a $1 trillion deficit for the year."),
                        .multipleChoice(id: "u12l3q5", prompt: "'Stimulus' spending is designed to...",
                            choices: [
                            AnswerChoice(id: 0, text: "Boost economic activity, often during a slowdown"),
                            AnswerChoice(id: 1, text: "Slow the economy on purpose"),
                            AnswerChoice(id: 2, text: "Pay off all national debt instantly"),
                            AnswerChoice(id: 3, text: "Set interest rates")
                            ], correct: 0,
                            explanation: "Stimulus pumps money into the economy (through spending or tax cuts) to lift demand when growth is weak."),
                        .trueFalse(id: "u12l3q6", prompt: "The national debt is the total of all past deficits (minus any surpluses) a government has piled up over time.", correctIsTrue: true,
                            explanation: "Each year's deficit adds to a running total. That accumulated total is the national debt."),
                        .multiSelect(id: "u12l3q7", prompt: "Which of these are examples of fiscal policy? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Cutting taxes to boost spending"),
                            AnswerChoice(id: 1, text: "Increasing government spending on infrastructure"),
                            AnswerChoice(id: 2, text: "Sending stimulus payments"),
                            AnswerChoice(id: 3, text: "The Fed cutting interest rates")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Taxes, spending, and stimulus are fiscal. A Fed rate cut is monetary policy, run by the central bank.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit12-lesson4",
                    title: "Trade & Currencies",
                    iconName: "globe.americas.fill",
                    questions: [
                        .matching(id: "u12l4q1", prompt: "Match each trade term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Imports", right: "Goods and services a country buys from abroad"),
                            MatchPair(id: 1, left: "Exports", right: "Goods and services a country sells to other countries"),
                            MatchPair(id: 2, left: "Trade deficit", right: "When a country imports more than it exports"),
                            MatchPair(id: 3, left: "Exchange rate", right: "How much one currency is worth in another")
                            ],
                            explanation: "Imports come in, exports go out, and the exchange rate is the price tag that links two currencies."),
                        .multipleChoice(id: "u12l4q2", prompt: "An 'exchange rate' tells you...",
                            choices: [
                            AnswerChoice(id: 0, text: "How much one currency is worth in terms of another"),
                            AnswerChoice(id: 1, text: "The interest rate on a loan"),
                            AnswerChoice(id: 2, text: "A country's tax rate"),
                            AnswerChoice(id: 3, text: "The price of a single stock")
                            ], correct: 0,
                            explanation: "For example, if 1 euro = $1.10, the exchange rate tells you how many dollars one euro buys."),
                        .trueFalse(id: "u12l4q3", prompt: "A 'strong dollar' means the U.S. dollar buys MORE foreign currency than before.", correctIsTrue: true,
                            explanation: "A strong dollar has extra buying power abroad, so each dollar swaps for more euros, yen, or pounds."),
                        .categorize(id: "u12l4q4", prompt: "Sort each person by which situation helps them.",
                            categories: ["Helped by a STRONG dollar", "Helped by a WEAK dollar"],
                            items: [
                            CategoryItem(id: 0, text: "A U.S. tourist traveling in Europe", correctCategory: "Helped by a STRONG dollar"),
                            CategoryItem(id: 1, text: "A U.S. company exporting goods abroad", correctCategory: "Helped by a WEAK dollar"),
                            CategoryItem(id: 2, text: "An American buying imported electronics", correctCategory: "Helped by a STRONG dollar"),
                            CategoryItem(id: 3, text: "A foreign tourist visiting the U.S.", correctCategory: "Helped by a WEAK dollar")
                            ],
                            explanation: "A strong dollar makes foreign goods and travel cheaper for Americans. A weak dollar makes U.S. exports and visits cheaper for foreigners."),
                        .multipleChoice(id: "u12l4q5", prompt: "If a country exports MORE than it imports, it has a...",
                            choices: [
                            AnswerChoice(id: 0, text: "Trade surplus"),
                            AnswerChoice(id: 1, text: "Trade deficit"),
                            AnswerChoice(id: 2, text: "Budget deficit"),
                            AnswerChoice(id: 3, text: "Recession")
                            ], correct: 0,
                            explanation: "Selling more abroad than you buy is a trade surplus. The reverse is a trade deficit."),
                        .numeric(id: "u12l4q6", prompt: "1 euro = 1.10 U.S. dollars. How many dollars would you need to buy 50 euros?", answer: 55, tolerance: 0, prefix: "$",
                            explanation: "50 euros times $1.10 each equals $55."),
                        .trueFalse(id: "u12l4q7", prompt: "A weaker dollar tends to make American-made exports cheaper and more attractive to foreign buyers.", correctIsTrue: true,
                            explanation: "When the dollar is weak, foreign buyers can afford more U.S. goods, which can boost exports.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit12-lesson5",
                    title: "Recessions & Reading the News",
                    iconName: "chart.line.downtrend.xyaxis",
                    questions: [
                        .multipleChoice(id: "u12l5q1", prompt: "A recession is best described as...",
                            choices: [
                            AnswerChoice(id: 0, text: "A significant, widespread decline in economic activity lasting months"),
                            AnswerChoice(id: 1, text: "A single bad day in the stock market"),
                            AnswerChoice(id: 2, text: "Any drop in one company's stock"),
                            AnswerChoice(id: 3, text: "A tax increase")
                            ], correct: 0,
                            explanation: "A recession is a broad, lasting slump across the economy, not just one rough day or one falling stock."),
                        .trueFalse(id: "u12l5q2", prompt: "A common rule of thumb defines a recession as two consecutive quarters of shrinking GDP.", correctIsTrue: true,
                            explanation: "It's a handy shortcut. The official U.S. call is broader, but 'two down quarters' is the popular rule of thumb."),
                        .multipleChoice(id: "u12l5q3", prompt: "Why do news headlines about the economy often feel scarier than reality?",
                            choices: [
                            AnswerChoice(id: 0, text: "Dramatic, fearful headlines attract more clicks and attention"),
                            AnswerChoice(id: 1, text: "They are legally required to exaggerate"),
                            AnswerChoice(id: 2, text: "Journalists never use any data"),
                            AnswerChoice(id: 3, text: "Reporting good news is illegal")
                            ], correct: 0,
                            explanation: "Fear and drama grab attention, so headlines lean sensational. Read past them to the actual data before reacting."),
                        .numeric(id: "u12l5q4", prompt: "Experts suggest an emergency fund of 3 to 6 months of expenses. If your expenses are $1,500 a month, how much is a 3-month fund?", answer: 4500, tolerance: 0, prefix: "$",
                            explanation: "3 months times $1,500 equals $4,500 of cushion."),
                        .multiSelect(id: "u12l5q5", prompt: "Why does an emergency fund matter during a recession? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Job losses are more common, so income can stop"),
                            AnswerChoice(id: 1, text: "It lets you avoid selling investments at a low point"),
                            AnswerChoice(id: 2, text: "It covers surprise expenses without new debt"),
                            AnswerChoice(id: 3, text: "It guarantees the stock market will go up")
                            ], correctIDs: [0, 1, 2],
                            explanation: "A cash cushion buys you time and options when income drops. Nothing, though, guarantees which way markets move."),
                        .ordering(id: "u12l5q6", prompt: "Order these calm, smart responses to a scary economic headline.",
                            items: [
                            "Take a breath instead of panic-selling",
                            "Read past the headline to the real numbers",
                            "Revisit your long-term plan and goals",
                            "Top up your emergency fund if needed"
                            ],
                            explanation: "Pause, check the data, stick to your plan, and shore up your safety net. That beats reacting on emotion."),
                        .trueFalse(id: "u12l5q7", prompt: "Selling all your investments in a panic every time a scary headline appears is a proven path to wealth.", correctIsTrue: false,
                            explanation: "Panic-selling usually means selling low. Long-term investors who stay the course tend to do far better.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit12-check",
                    title: "Macro Economics II: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .multipleChoice(id: "u12l1q2-kc", prompt: "The Fed's 'dual mandate' is to pursue which TWO goals?",
                            choices: [
                            AnswerChoice(id: 0, text: "Maximum employment and stable prices"),
                            AnswerChoice(id: 1, text: "Higher stock prices and more exports"),
                            AnswerChoice(id: 2, text: "Lower taxes and less regulation"),
                            AnswerChoice(id: 3, text: "A balanced budget and free trade")
                            ], correct: 0,
                            explanation: "Congress gave the Fed two jobs: keep as many people employed as possible while keeping prices (inflation) stable."),
                        .multipleChoice(id: "u12l1q4-kc", prompt: "The main interest rate the Fed targets is the...",
                            choices: [
                            AnswerChoice(id: 0, text: "Federal funds rate"),
                            AnswerChoice(id: 1, text: "Mortgage rate"),
                            AnswerChoice(id: 2, text: "Credit card APR"),
                            AnswerChoice(id: 3, text: "Savings account rate")
                            ], correct: 0,
                            explanation: "The federal funds rate is what banks charge each other for overnight loans. When the Fed moves it, other rates across the economy tend to follow."),
                        .matching(id: "u12l1q6-kc", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Central bank", right: "The institution that manages a nation's money and interest rates"),
                            MatchPair(id: 1, left: "Dual mandate", right: "The Fed's twin goals of stable prices and max employment"),
                            MatchPair(id: 2, left: "Federal funds rate", right: "The key overnight rate the Fed targets"),
                            MatchPair(id: 3, left: "Inflation", right: "A general rise in prices over time")
                            ],
                            explanation: "These four ideas are the backbone of how the Fed operates and why it exists."),
                        .multipleChoice(id: "u12l2q2-kc", prompt: "When the Fed LOWERS interest rates, borrowing money generally becomes...",
                            choices: [
                            AnswerChoice(id: 0, text: "Cheaper, encouraging spending and investment"),
                            AnswerChoice(id: 1, text: "More expensive, discouraging spending"),
                            AnswerChoice(id: 2, text: "Illegal"),
                            AnswerChoice(id: 3, text: "Completely unchanged")
                            ], correct: 0,
                            explanation: "Lower rates mean cheaper loans, so people and businesses tend to borrow, spend, and invest more."),
                        .trueFalse(id: "u12l2q4-kc", prompt: "Lowering interest rates is often called 'loosening' or 'easing' monetary policy.", correctIsTrue: true,
                            explanation: "Cutting rates 'loosens' or 'eases' conditions to give the economy more room to grow. Raising them is 'tightening.'"),
                        .multipleChoice(id: "u12l2q6-kc", prompt: "Higher interest rates tend to do what to stock prices, all else equal?",
                            choices: [
                            AnswerChoice(id: 0, text: "Put downward pressure on them"),
                            AnswerChoice(id: 1, text: "Guarantee they rise"),
                            AnswerChoice(id: 2, text: "Have zero effect ever"),
                            AnswerChoice(id: 3, text: "Only affect crypto")
                            ], correct: 0,
                            explanation: "Higher rates make borrowing costlier for companies and make safe bonds more attractive, which often weighs on stocks."),
                        .categorize(id: "u12l3q2-kc", prompt: "Sort each tool by who controls it.",
                            categories: ["Fiscal (Congress/Govt)", "Monetary (Fed)"],
                            items: [
                            CategoryItem(id: 0, text: "Setting income tax rates", correctCategory: "Fiscal (Congress/Govt)"),
                            CategoryItem(id: 1, text: "Government spending on roads", correctCategory: "Fiscal (Congress/Govt)"),
                            CategoryItem(id: 2, text: "Setting the federal funds rate", correctCategory: "Monetary (Fed)"),
                            CategoryItem(id: 3, text: "Sending stimulus checks", correctCategory: "Fiscal (Congress/Govt)"),
                            CategoryItem(id: 4, text: "Adjusting the money supply", correctCategory: "Monetary (Fed)")
                            ],
                            explanation: "Taxes and spending are fiscal (government); interest rates and money supply are monetary (Fed). Keeping them straight is key."),
                        .numeric(id: "u12l3q4-kc", prompt: "A government collects $3 trillion in taxes but spends $4 trillion in a year. What is its deficit? (Answer in trillions.)", answer: 1, tolerance: 0, suffix: " trillion",
                            explanation: "$4 trillion spent minus $3 trillion collected leaves a $1 trillion deficit for the year."),
                        .trueFalse(id: "u12l3q6-kc", prompt: "The national debt is the total of all past deficits (minus any surpluses) a government has piled up over time.", correctIsTrue: true,
                            explanation: "Each year's deficit adds to a running total. That accumulated total is the national debt."),
                        .multipleChoice(id: "u12l4q2-kc", prompt: "An 'exchange rate' tells you...",
                            choices: [
                            AnswerChoice(id: 0, text: "How much one currency is worth in terms of another"),
                            AnswerChoice(id: 1, text: "The interest rate on a loan"),
                            AnswerChoice(id: 2, text: "A country's tax rate"),
                            AnswerChoice(id: 3, text: "The price of a single stock")
                            ], correct: 0,
                            explanation: "For example, if 1 euro = $1.10, the exchange rate tells you how many dollars one euro buys."),
                        .categorize(id: "u12l4q4-kc", prompt: "Sort each person by which situation helps them.",
                            categories: ["Helped by a STRONG dollar", "Helped by a WEAK dollar"],
                            items: [
                            CategoryItem(id: 0, text: "A U.S. tourist traveling in Europe", correctCategory: "Helped by a STRONG dollar"),
                            CategoryItem(id: 1, text: "A U.S. company exporting goods abroad", correctCategory: "Helped by a WEAK dollar"),
                            CategoryItem(id: 2, text: "An American buying imported electronics", correctCategory: "Helped by a STRONG dollar"),
                            CategoryItem(id: 3, text: "A foreign tourist visiting the U.S.", correctCategory: "Helped by a WEAK dollar")
                            ],
                            explanation: "A strong dollar makes foreign goods and travel cheaper for Americans. A weak dollar makes U.S. exports and visits cheaper for foreigners."),
                        .numeric(id: "u12l4q6-kc", prompt: "1 euro = 1.10 U.S. dollars. How many dollars would you need to buy 50 euros?", answer: 55, tolerance: 0, prefix: "$",
                            explanation: "50 euros times $1.10 each equals $55."),
                        .trueFalse(id: "u12l5q2-kc", prompt: "A common rule of thumb defines a recession as two consecutive quarters of shrinking GDP.", correctIsTrue: true,
                            explanation: "It's a handy shortcut. The official U.S. call is broader, but 'two down quarters' is the popular rule of thumb."),
                        .numeric(id: "u12l5q4-kc", prompt: "Experts suggest an emergency fund of 3 to 6 months of expenses. If your expenses are $1,500 a month, how much is a 3-month fund?", answer: 4500, tolerance: 0, prefix: "$",
                            explanation: "3 months times $1,500 equals $4,500 of cushion."),
                        .ordering(id: "u12l5q6-kc", prompt: "Order these calm, smart responses to a scary economic headline.",
                            items: [
                            "Take a breath instead of panic-selling",
                            "Read past the headline to the real numbers",
                            "Revisit your long-term plan and goals",
                            "Top up your emergency fund if needed"
                            ],
                            explanation: "Pause, check the data, stick to your plan, and shore up your safety net. That beats reacting on emotion.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let investorPsychology = LearningUnit(
            id: "unit8",
            title: "Unit 10: Investor Psychology",
            subtitle: "Outsmarting your own brain",
            colorHex: "F15BB5",
            lessons: [
                Lesson(
                    id: "unit8-lesson1",
                    title: "Emotions & FOMO",
                    iconName: "flame.fill",
                    questions: [
                        .multipleChoice(id: "u8l1q1", prompt: "What does FOMO mean in investing?",
                            choices: [
                            AnswerChoice(id: 0, text: "Fear Of Missing Out — rushing to buy because everyone else seems to be getting rich"),
                            AnswerChoice(id: 1, text: "A low-fee index fund"),
                            AnswerChoice(id: 2, text: "A government program that insures your losses"),
                            AnswerChoice(id: 3, text: "The fee a broker charges to sell a stock")
                            ], correct: 0,
                            explanation: "FOMO pushes people to buy after a price has already soared, often right near the top."),
                        .trueFalse(id: "u8l1q2", prompt: "Panic-selling during a market drop turns a temporary paper loss into a permanent, real one.", correctIsTrue: true,
                            explanation: "A loss on paper only becomes real when you sell — holding gives prices a chance to recover."),
                        .multiSelect(id: "u8l1q3", prompt: "Which are signs that FOMO — not real analysis — is driving your decision? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A stock is all over your feed and 'everyone' seems to own it"),
                            AnswerChoice(id: 1, text: "You feel a rush of urgency to buy right now before you miss out"),
                            AnswerChoice(id: 2, text: "You read the company's financials and decided the price was fair"),
                            AnswerChoice(id: 3, text: "You're scared of being the only one left out of the gains")
                            ], correctIDs: [0, 1, 3],
                            explanation: "FOMO feels urgent and social; real analysis is calm and based on facts, not on the crowd."),
                        .ordering(id: "u8l1q4", prompt: "Put the classic FOMO trap in order, from start to painful finish.",
                            items: [
                            "A stock's price skyrockets and fills your feed",
                            "You feel you're missing out and buy near the peak",
                            "The hype fades and the price falls",
                            "You panic-sell at a loss"
                            ],
                            explanation: "Buying on hype and selling on fear is the buy-high, sell-low trap in action."),
                        .multipleChoice(id: "u8l1q5", prompt: "A stock you own drops 20% on scary headlines, but nothing about the actual business changed. The emotionally-smart move is usually to:",
                            choices: [
                            AnswerChoice(id: 0, text: "Stick to your plan and avoid selling out of fear"),
                            AnswerChoice(id: 1, text: "Immediately sell everything to stop the pain"),
                            AnswerChoice(id: 2, text: "Borrow money to buy a huge amount right now"),
                            AnswerChoice(id: 3, text: "Refresh the price every five minutes all day")
                            ], correct: 0,
                            explanation: "Reacting to fear locks in losses; a plan keeps emotion from making the decision for you."),
                        .trueFalse(id: "u8l1q6", prompt: "The best time to decide how you'll react to a crash is before it happens, while you're calm.", correctIsTrue: true,
                            explanation: "Deciding your rules in advance keeps panic from choosing for you in the moment."),
                        .multipleChoice(id: "u8l1q7", prompt: "'Buy high, sell low' is the opposite of good investing. Which emotions most often cause it?",
                            choices: [
                            AnswerChoice(id: 0, text: "Greed/FOMO when buying, and fear/panic when selling"),
                            AnswerChoice(id: 1, text: "Boredom when buying, and pride when selling"),
                            AnswerChoice(id: 2, text: "Curiosity when buying, and gratitude when selling"),
                            AnswerChoice(id: 3, text: "Patience when buying, and calm when selling")
                            ], correct: 0,
                            explanation: "Greed tempts you to buy at the top; fear tempts you to sell at the bottom.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit8-lesson2",
                    title: "Cognitive Biases",
                    iconName: "brain.head.profile",
                    questions: [
                        .matching(id: "u8l2q1", prompt: "Match each bias to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Loss aversion", right: "Losses hurt about twice as much as equal gains feel good"),
                            MatchPair(id: 1, left: "Anchoring", right: "Fixating on one number, like the price you paid, when judging value"),
                            MatchPair(id: 2, left: "Confirmation bias", right: "Only seeking out information that agrees with what you already believe"),
                            MatchPair(id: 3, left: "Herd mentality", right: "Doing what the crowd does instead of thinking for yourself")
                            ],
                            explanation: "Naming a bias is the first step to catching yourself doing it."),
                        .multipleChoice(id: "u8l2q2", prompt: "You refuse to sell a losing stock 'until it gets back to what I paid for it.' Which bias is this?",
                            choices: [
                            AnswerChoice(id: 0, text: "Anchoring to your purchase price"),
                            AnswerChoice(id: 1, text: "Herd mentality"),
                            AnswerChoice(id: 2, text: "Confirmation bias"),
                            AnswerChoice(id: 3, text: "Diversification")
                            ], correct: 0,
                            explanation: "The market doesn't care what you paid; anchoring to that number clouds your judgment."),
                        .trueFalse(id: "u8l2q3", prompt: "Loss aversion means the pain of losing $100 usually feels stronger than the joy of gaining $100.", correctIsTrue: true,
                            explanation: "Because losses sting more, people often sell winners too early and cling to losers too long."),
                        .categorize(id: "u8l2q4", prompt: "Sort each behavior into the bias it shows.",
                            categories: ["Confirmation bias", "Herd mentality"],
                            items: [
                            CategoryItem(id: 0, text: "Only reading articles that praise a stock you own", correctCategory: "Confirmation bias"),
                            CategoryItem(id: 1, text: "Buying a coin because your whole group chat is buying it", correctCategory: "Herd mentality"),
                            CategoryItem(id: 2, text: "Ignoring a report that lists risks you'd rather not see", correctCategory: "Confirmation bias"),
                            CategoryItem(id: 3, text: "Selling in a panic just because everyone else is selling", correctCategory: "Herd mentality")
                            ],
                            explanation: "Confirmation bias filters your information; herd mentality copies the crowd."),
                        .multipleChoice(id: "u8l2q5", prompt: "The best defense against confirmation bias is to:",
                            choices: [
                            AnswerChoice(id: 0, text: "Actively look for solid arguments against your own idea"),
                            AnswerChoice(id: 1, text: "Only follow people who already agree with you"),
                            AnswerChoice(id: 2, text: "Avoid reading anything at all"),
                            AnswerChoice(id: 3, text: "Buy more of a stock every time it drops")
                            ], correct: 0,
                            explanation: "Seeking out the other side stress-tests your idea before your money has to."),
                        .multiSelect(id: "u8l2q6", prompt: "Which of these show herd mentality? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Buying a stock only because it's trending and everyone's talking about it"),
                            AnswerChoice(id: 1, text: "Selling because you see everyone else panic-selling"),
                            AnswerChoice(id: 2, text: "Buying after researching the company and deciding it's a fair price"),
                            AnswerChoice(id: 3, text: "Piling into a meme coin so you won't feel left out")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Herd mentality is letting the crowd — not your own analysis — make the call."),
                        .trueFalse(id: "u8l2q7", prompt: "Anchoring can trick you into thinking a stock is 'cheap' just because it's lower than its all-time high.", correctIsTrue: true,
                            explanation: "A lower price isn't automatically a bargain; the business's actual value is what matters.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit8-lesson3",
                    title: "Scams & Red Flags",
                    iconName: "exclamationmark.triangle.fill",
                    questions: [
                        .multipleChoice(id: "u8l3q1", prompt: "An investment 'guarantees' you'll double your money in a month with 'zero risk.' This is:",
                            choices: [
                            AnswerChoice(id: 0, text: "A major red flag — real investments never guarantee high returns with no risk"),
                            AnswerChoice(id: 1, text: "A normal, safe opportunity you should jump on"),
                            AnswerChoice(id: 2, text: "Proof the investment is government-regulated"),
                            AnswerChoice(id: 3, text: "A sign of a well-diversified portfolio")
                            ], correct: 0,
                            explanation: "Higher returns always come with higher risk, so 'guaranteed' big returns are a classic scam signal."),
                        .trueFalse(id: "u8l3q2", prompt: "In a Ponzi scheme, early investors are paid with money from new investors — not from real profits.", correctIsTrue: true,
                            explanation: "It collapses the moment new money slows, and most people end up losing everything."),
                        .multipleChoice(id: "u8l3q3", prompt: "In a 'pump-and-dump,' scammers hype a cheap stock or coin to push the price up, and then:",
                            choices: [
                            AnswerChoice(id: 0, text: "Sell their own shares at the top, crashing the price for everyone else"),
                            AnswerChoice(id: 1, text: "Donate all the profits to charity"),
                            AnswerChoice(id: 2, text: "Hold forever and never sell"),
                            AnswerChoice(id: 3, text: "Report themselves to regulators")
                            ], correct: 0,
                            explanation: "The organizers dump their shares on the hype, leaving latecomers holding the losses."),
                        .multiSelect(id: "u8l3q4", prompt: "Which are red flags of a likely scam? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Promises of guaranteed, unusually high returns"),
                            AnswerChoice(id: 1, text: "High pressure to 'act now' before you can think or research"),
                            AnswerChoice(id: 2, text: "A boring, low-cost index fund with clear disclosures"),
                            AnswerChoice(id: 3, text: "Being told to recruit friends to earn bigger payouts")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Guarantees, urgency, and recruit-your-friends schemes are classic warning signs."),
                        .categorize(id: "u8l3q5", prompt: "Sort each into a scam red flag or a healthy sign.",
                            categories: ["Red flag", "Healthy sign"],
                            items: [
                            CategoryItem(id: 0, text: "'Guaranteed' 500% returns", correctCategory: "Red flag"),
                            CategoryItem(id: 1, text: "Clear, public financial statements", correctCategory: "Healthy sign"),
                            CategoryItem(id: 2, text: "Pressure to invest before you can research", correctCategory: "Red flag"),
                            CategoryItem(id: 3, text: "A regulated fund with transparent fees", correctCategory: "Healthy sign")
                            ],
                            explanation: "Transparency is healthy; secrecy, guarantees, and pressure are red flags."),
                        .trueFalse(id: "u8l3q6", prompt: "A paid promotion from an influencer counts as solid financial research.", correctIsTrue: false,
                            explanation: "Paid promos are advertising, not analysis — the promoter is being paid to say nice things."),
                        .multipleChoice(id: "u8l3q7", prompt: "A celebrity you follow is paid to promote a new crypto token. Before buying, you should:",
                            choices: [
                            AnswerChoice(id: 0, text: "Do your own research — a paid endorsement isn't evidence the token is good"),
                            AnswerChoice(id: 1, text: "Buy immediately because they're famous and trustworthy"),
                            AnswerChoice(id: 2, text: "Invest your whole savings to show support"),
                            AnswerChoice(id: 3, text: "Assume it's guaranteed to rise because a celebrity likes it")
                            ], correct: 0,
                            explanation: "Fame isn't expertise, and paid promos come with a built-in conflict of interest.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit8-lesson4",
                    title: "Building Good Habits",
                    iconName: "checklist",
                    questions: [
                        .multipleChoice(id: "u8l4q1", prompt: "Automating a set investment every payday (dollar-cost averaging) helps you:",
                            choices: [
                            AnswerChoice(id: 0, text: "Invest consistently without letting emotions or timing get in the way"),
                            AnswerChoice(id: 1, text: "Guarantee you always buy at the lowest possible price"),
                            AnswerChoice(id: 2, text: "Avoid ever paying any taxes"),
                            AnswerChoice(id: 3, text: "Beat the market every single year")
                            ], correct: 0,
                            explanation: "Automatic, regular investing removes the temptation to time the market on emotion."),
                        .numeric(id: "u8l4q2", prompt: "You automate investing $150 every month. How many dollars is that over one year?", answer: 1800, tolerance: 0, prefix: "$",
                            explanation: "$150 x 12 months = $1,800 invested automatically."),
                        .ordering(id: "u8l4q3", prompt: "Put the steps of a healthy 'rules before you invest' habit in order.",
                            items: [
                            "Write down your goal and your rules while calm",
                            "Automate regular contributions",
                            "Check your portfolio on a set schedule, not constantly",
                            "Follow your written rules instead of your mood"
                            ],
                            explanation: "Deciding rules in advance and automating them keeps emotion out of the driver's seat."),
                        .trueFalse(id: "u8l4q4", prompt: "Checking your portfolio every few minutes tends to increase stress and lead to worse decisions.", correctIsTrue: true,
                            explanation: "Constant checking amplifies emotion; a calm, scheduled review is healthier and usually smarter."),
                        .multipleChoice(id: "u8l4q5", prompt: "Writing an 'investing rulebook' before you buy is helpful mainly because:",
                            choices: [
                            AnswerChoice(id: 0, text: "Calm, pre-set rules protect you from emotional decisions later"),
                            AnswerChoice(id: 1, text: "It guarantees you'll never lose money"),
                            AnswerChoice(id: 2, text: "It lets you skip doing any research"),
                            AnswerChoice(id: 3, text: "It makes your returns tax-free")
                            ], correct: 0,
                            explanation: "Rules written in a calm moment act as guardrails when fear or greed hit later."),
                        .multiSelect(id: "u8l4q6", prompt: "Which of these are good investing habits? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Automating contributions so you invest before you can spend it"),
                            AnswerChoice(id: 1, text: "Reviewing your portfolio on a set schedule, like quarterly"),
                            AnswerChoice(id: 2, text: "Writing down your plan and rules ahead of time"),
                            AnswerChoice(id: 3, text: "Trading impulsively every time you see a scary headline")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Automation, scheduled reviews, and written rules build discipline; impulsive trading breaks it."),
                        .numeric(id: "u8l4q7", prompt: "If you review your portfolio once every 3 months, how many times do you check it in a year?", answer: 4, tolerance: 0,
                            explanation: "12 months / 3 = 4 scheduled reviews per year — calm and consistent.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit8-lesson5",
                    title: "The Long Game",
                    iconName: "hourglass",
                    questions: [
                        .multipleChoice(id: "u8l5q1", prompt: "The saying 'time in the market beats timing the market' means:",
                            choices: [
                            AnswerChoice(id: 0, text: "Staying invested over the long run usually beats jumping in and out"),
                            AnswerChoice(id: 1, text: "You should only invest for a single day at a time"),
                            AnswerChoice(id: 2, text: "The best investors trade many times per hour"),
                            AnswerChoice(id: 3, text: "You must predict every crash to succeed")
                            ], correct: 0,
                            explanation: "Since no one reliably times the market, patient long-term investing tends to win."),
                        .trueFalse(id: "u8l5q2", prompt: "Missing just a handful of the market's best days can drastically lower your long-term returns.", correctIsTrue: true,
                            explanation: "The biggest up-days often come right after big drops, so jumping out risks missing the rebound."),
                        .multipleChoice(id: "u8l5q3", prompt: "'Buy-and-hold' investing means:",
                            choices: [
                            AnswerChoice(id: 0, text: "Buying quality investments and holding them for years through the ups and downs"),
                            AnswerChoice(id: 1, text: "Selling everything the moment prices dip"),
                            AnswerChoice(id: 2, text: "Buying and selling the same stock every day"),
                            AnswerChoice(id: 3, text: "Only holding cash and never investing")
                            ], correct: 0,
                            explanation: "Buy-and-hold lets compounding work and cuts down on emotional, costly trading."),
                        .numeric(id: "u8l5q4", prompt: "An investor's money grows about 10% per year. Using the Rule of 72, roughly how many years until it doubles?", answer: 7, tolerance: 1, suffix: " years",
                            explanation: "The Rule of 72 says 72 / 10 is about 7.2 years to double."),
                        .matching(id: "u8l5q5", prompt: "Match each mindset to the investor it describes.",
                            pairs: [
                            MatchPair(id: 0, left: "Patient long-term investor", right: "Buys quality and holds for years, ignoring daily noise"),
                            MatchPair(id: 1, left: "Panic trader", right: "Sells in fear every time the market dips"),
                            MatchPair(id: 2, left: "Market timer", right: "Tries (and usually fails) to guess the perfect moment to buy and sell"),
                            MatchPair(id: 3, left: "FOMO chaser", right: "Piles into whatever is hot right now, near its peak")
                            ],
                            explanation: "The calm, patient approach is the one that most reliably builds wealth over time."),
                        .trueFalse(id: "u8l5q6", prompt: "Because the stock market has trended upward over the long run, staying invested has historically rewarded patience.", correctIsTrue: true,
                            explanation: "Despite crashes along the way, long-term investors have historically been rewarded for holding."),
                        .multipleChoice(id: "u8l5q7", prompt: "Compounding rewards long-term investors most because:",
                            choices: [
                            AnswerChoice(id: 0, text: "Your gains start earning their own gains, snowballing over many years"),
                            AnswerChoice(id: 1, text: "The government adds free money each year"),
                            AnswerChoice(id: 2, text: "Stocks can only ever go up"),
                            AnswerChoice(id: 3, text: "Short-term trading always earns more")
                            ], correct: 0,
                            explanation: "Given time, compounding turns steady growth into a snowball — the longer you wait, the bigger it gets.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit8-check",
                    title: "Investor Psychology: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u8l1q2-kc", prompt: "Panic-selling during a market drop turns a temporary paper loss into a permanent, real one.", correctIsTrue: true,
                            explanation: "A loss on paper only becomes real when you sell — holding gives prices a chance to recover."),
                        .ordering(id: "u8l1q4-kc", prompt: "Put the classic FOMO trap in order, from start to painful finish.",
                            items: [
                            "A stock's price skyrockets and fills your feed",
                            "You feel you're missing out and buy near the peak",
                            "The hype fades and the price falls",
                            "You panic-sell at a loss"
                            ],
                            explanation: "Buying on hype and selling on fear is the buy-high, sell-low trap in action."),
                        .trueFalse(id: "u8l1q6-kc", prompt: "The best time to decide how you'll react to a crash is before it happens, while you're calm.", correctIsTrue: true,
                            explanation: "Deciding your rules in advance keeps panic from choosing for you in the moment."),
                        .multipleChoice(id: "u8l2q2-kc", prompt: "You refuse to sell a losing stock 'until it gets back to what I paid for it.' Which bias is this?",
                            choices: [
                            AnswerChoice(id: 0, text: "Anchoring to your purchase price"),
                            AnswerChoice(id: 1, text: "Herd mentality"),
                            AnswerChoice(id: 2, text: "Confirmation bias"),
                            AnswerChoice(id: 3, text: "Diversification")
                            ], correct: 0,
                            explanation: "The market doesn't care what you paid; anchoring to that number clouds your judgment."),
                        .categorize(id: "u8l2q4-kc", prompt: "Sort each behavior into the bias it shows.",
                            categories: ["Confirmation bias", "Herd mentality"],
                            items: [
                            CategoryItem(id: 0, text: "Only reading articles that praise a stock you own", correctCategory: "Confirmation bias"),
                            CategoryItem(id: 1, text: "Buying a coin because your whole group chat is buying it", correctCategory: "Herd mentality"),
                            CategoryItem(id: 2, text: "Ignoring a report that lists risks you'd rather not see", correctCategory: "Confirmation bias"),
                            CategoryItem(id: 3, text: "Selling in a panic just because everyone else is selling", correctCategory: "Herd mentality")
                            ],
                            explanation: "Confirmation bias filters your information; herd mentality copies the crowd."),
                        .multiSelect(id: "u8l2q6-kc", prompt: "Which of these show herd mentality? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Buying a stock only because it's trending and everyone's talking about it"),
                            AnswerChoice(id: 1, text: "Selling because you see everyone else panic-selling"),
                            AnswerChoice(id: 2, text: "Buying after researching the company and deciding it's a fair price"),
                            AnswerChoice(id: 3, text: "Piling into a meme coin so you won't feel left out")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Herd mentality is letting the crowd — not your own analysis — make the call."),
                        .trueFalse(id: "u8l3q2-kc", prompt: "In a Ponzi scheme, early investors are paid with money from new investors — not from real profits.", correctIsTrue: true,
                            explanation: "It collapses the moment new money slows, and most people end up losing everything."),
                        .multiSelect(id: "u8l3q4-kc", prompt: "Which are red flags of a likely scam? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Promises of guaranteed, unusually high returns"),
                            AnswerChoice(id: 1, text: "High pressure to 'act now' before you can think or research"),
                            AnswerChoice(id: 2, text: "A boring, low-cost index fund with clear disclosures"),
                            AnswerChoice(id: 3, text: "Being told to recruit friends to earn bigger payouts")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Guarantees, urgency, and recruit-your-friends schemes are classic warning signs."),
                        .trueFalse(id: "u8l3q6-kc", prompt: "A paid promotion from an influencer counts as solid financial research.", correctIsTrue: false,
                            explanation: "Paid promos are advertising, not analysis — the promoter is being paid to say nice things."),
                        .numeric(id: "u8l4q2-kc", prompt: "You automate investing $150 every month. How many dollars is that over one year?", answer: 1800, tolerance: 0, prefix: "$",
                            explanation: "$150 x 12 months = $1,800 invested automatically."),
                        .trueFalse(id: "u8l4q4-kc", prompt: "Checking your portfolio every few minutes tends to increase stress and lead to worse decisions.", correctIsTrue: true,
                            explanation: "Constant checking amplifies emotion; a calm, scheduled review is healthier and usually smarter."),
                        .multiSelect(id: "u8l4q6-kc", prompt: "Which of these are good investing habits? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Automating contributions so you invest before you can spend it"),
                            AnswerChoice(id: 1, text: "Reviewing your portfolio on a set schedule, like quarterly"),
                            AnswerChoice(id: 2, text: "Writing down your plan and rules ahead of time"),
                            AnswerChoice(id: 3, text: "Trading impulsively every time you see a scary headline")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Automation, scheduled reviews, and written rules build discipline; impulsive trading breaks it."),
                        .trueFalse(id: "u8l5q2-kc", prompt: "Missing just a handful of the market's best days can drastically lower your long-term returns.", correctIsTrue: true,
                            explanation: "The biggest up-days often come right after big drops, so jumping out risks missing the rebound."),
                        .numeric(id: "u8l5q4-kc", prompt: "An investor's money grows about 10% per year. Using the Rule of 72, roughly how many years until it doubles?", answer: 7, tolerance: 1, suffix: " years",
                            explanation: "The Rule of 72 says 72 / 10 is about 7.2 years to double."),
                        .trueFalse(id: "u8l5q6-kc", prompt: "Because the stock market has trended upward over the long run, staying invested has historically rewarded patience.", correctIsTrue: true,
                            explanation: "Despite crashes along the way, long-term investors have historically been rewarded for holding.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let cryptoAndDigitalAssets = LearningUnit(
            id: "unit9",
            title: "Unit 11: Crypto & Digital Assets",
            subtitle: "Bitcoin, blockchains, and staying safe",
            colorHex: "F7931A",
            lessons: [
                Lesson(
                    id: "unit9-lesson1",
                    title: "What Is Cryptocurrency?",
                    iconName: "bitcoinsign.circle.fill",
                    questions: [
                        .multipleChoice(id: "u9l1q1", prompt: "Which best describes cryptocurrency?",
                            choices: [
                            AnswerChoice(id: 0, text: "Digital money that runs on a decentralized network"),
                            AnswerChoice(id: 1, text: "A coin minted by the U.S. Treasury"),
                            AnswerChoice(id: 2, text: "A type of government savings bond"),
                            AnswerChoice(id: 3, text: "A physical gold coin you hold in your hand")
                            ], correct: 0,
                            explanation: "Crypto is digital-only money that lives on a computer network no single company or government controls."),
                        .trueFalse(id: "u9l1q2", prompt: "Cryptocurrency is issued and guaranteed by a national government.", correctIsTrue: false,
                            explanation: "Unlike dollars or euros, most crypto has no government behind it promising its value."),
                        .multipleChoice(id: "u9l1q3", prompt: "What does it mean that crypto is 'decentralized'?",
                            choices: [
                            AnswerChoice(id: 0, text: "No single company or government is in control"),
                            AnswerChoice(id: 1, text: "One big bank runs the whole thing"),
                            AnswerChoice(id: 2, text: "The United Nations approves every payment"),
                            AnswerChoice(id: 3, text: "It only works when you are offline")
                            ], correct: 0,
                            explanation: "Decentralized means power is spread across many computers instead of one central boss."),
                        .multiSelect(id: "u9l1q4", prompt: "Which are true of most cryptocurrencies? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "They are digital-only"),
                            AnswerChoice(id: 1, text: "They run on a decentralized network"),
                            AnswerChoice(id: 2, text: "Their prices can swing sharply"),
                            AnswerChoice(id: 3, text: "They are insured by the FDIC")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Crypto is digital, decentralized, and volatile, but it is NOT FDIC-insured like a bank deposit."),
                        .categorize(id: "u9l1q5", prompt: "Sort each item into cryptocurrency or government money.",
                            categories: ["Cryptocurrency", "Government money"],
                            items: [
                            CategoryItem(id: 0, text: "Bitcoin", correctCategory: "Cryptocurrency"),
                            CategoryItem(id: 1, text: "The US dollar", correctCategory: "Government money"),
                            CategoryItem(id: 2, text: "Runs on a public blockchain", correctCategory: "Cryptocurrency"),
                            CategoryItem(id: 3, text: "Printed by a central bank", correctCategory: "Government money")
                            ],
                            explanation: "Crypto lives on blockchains with no central issuer; government money is printed and backed by a nation."),
                        .trueFalse(id: "u9l1q6", prompt: "Crypto prices can be very volatile, sometimes moving 10% or more in a single day.", correctIsTrue: true,
                            explanation: "Big, fast price swings are normal in crypto, which makes it risky for money you might need soon."),
                        .multipleChoice(id: "u9l1q7", prompt: "Why is it called 'crypto'?",
                            choices: [
                            AnswerChoice(id: 0, text: "It uses cryptography to secure transactions"),
                            AnswerChoice(id: 1, text: "It must be kept in a crypt"),
                            AnswerChoice(id: 2, text: "It is completely invisible"),
                            AnswerChoice(id: 3, text: "It is always illegal")
                            ], correct: 0,
                            explanation: "The name comes from cryptography, the math that keeps transactions secure and hard to fake.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit9-lesson2",
                    title: "Blockchain Basics",
                    iconName: "square.stack.3d.up.fill",
                    questions: [
                        .multipleChoice(id: "u9l2q1", prompt: "What is a blockchain?",
                            choices: [
                            AnswerChoice(id: 0, text: "A shared digital ledger that records transactions"),
                            AnswerChoice(id: 1, text: "A single Excel file on one laptop"),
                            AnswerChoice(id: 2, text: "A physical stack of coins"),
                            AnswerChoice(id: 3, text: "A private government database")
                            ], correct: 0,
                            explanation: "A blockchain is a shared record of transactions, copied across many computers at once."),
                        .trueFalse(id: "u9l2q2", prompt: "Once data is confirmed on a blockchain, it is extremely hard to change.", correctIsTrue: true,
                            explanation: "Blocks are locked together with cryptography, so altering old records is nearly impossible."),
                        .ordering(id: "u9l2q3", prompt: "Put the steps of a blockchain transaction in order.",
                            items: [
                            "You send crypto to someone",
                            "The transaction is broadcast to the network",
                            "Miners or validators verify it",
                            "It is bundled into a new block",
                            "The block is linked onto the chain"
                            ],
                            explanation: "Send, broadcast, verify, bundle into a block, then link the block to the chain."),
                        .multipleChoice(id: "u9l2q4", prompt: "What do miners or validators do?",
                            choices: [
                            AnswerChoice(id: 0, text: "Verify transactions and add new blocks"),
                            AnswerChoice(id: 1, text: "Print new dollar bills"),
                            AnswerChoice(id: 2, text: "Delete old transactions for fun"),
                            AnswerChoice(id: 3, text: "Set the country's interest rates")
                            ], correct: 0,
                            explanation: "Miners and validators do the work of checking transactions and adding them to the chain."),
                        .multiSelect(id: "u9l2q5", prompt: "Why is a blockchain hard to tamper with? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Copies are stored across many computers"),
                            AnswerChoice(id: 1, text: "Blocks are cryptographically linked together"),
                            AnswerChoice(id: 2, text: "One person can quietly edit it alone"),
                            AnswerChoice(id: 3, text: "Changing one block breaks the whole chain")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Many copies plus linked blocks mean no single person can secretly rewrite history."),
                        .matching(id: "u9l2q6", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Ledger", right: "A record of all transactions"),
                            MatchPair(id: 1, left: "Node", right: "A computer that helps run the network"),
                            MatchPair(id: 2, left: "Block", right: "A batch of confirmed transactions"),
                            MatchPair(id: 3, left: "Decentralized", right: "No single central authority in charge")
                            ],
                            explanation: "These are the core building blocks: a ledger of blocks, kept by nodes, with no central boss."),
                        .trueFalse(id: "u9l2q7", prompt: "A blockchain is stored on a single central computer owned by a bank.", correctIsTrue: false,
                            explanation: "The opposite is true: it is copied across many independent computers, which is what makes it decentralized.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit9-lesson3",
                    title: "Coins & Tokens",
                    iconName: "key.fill",
                    questions: [
                        .multipleChoice(id: "u9l3q1", prompt: "Bitcoin is often nicknamed...",
                            choices: [
                            AnswerChoice(id: 0, text: "Digital gold"),
                            AnswerChoice(id: 1, text: "A digital cash printer"),
                            AnswerChoice(id: 2, text: "The internet dollar"),
                            AnswerChoice(id: 3, text: "A stablecoin")
                            ], correct: 0,
                            explanation: "Bitcoin has a limited supply and is seen mainly as a store of value, like gold."),
                        .multipleChoice(id: "u9l3q2", prompt: "Ethereum is best described as...",
                            choices: [
                            AnswerChoice(id: 0, text: "A platform for apps and smart contracts"),
                            AnswerChoice(id: 1, text: "A currency printed by a government"),
                            AnswerChoice(id: 2, text: "A physical hardware wallet"),
                            AnswerChoice(id: 3, text: "A savings bank")
                            ], correct: 0,
                            explanation: "Ethereum is a programmable platform where developers build apps, not just a simple coin."),
                        .matching(id: "u9l3q3", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Bitcoin", right: "Often called digital gold"),
                            MatchPair(id: 1, left: "Ethereum", right: "A platform for apps and smart contracts"),
                            MatchPair(id: 2, left: "Wallet", right: "Where you store your crypto keys"),
                            MatchPair(id: 3, left: "Private key", right: "The secret code that controls your crypto")
                            ],
                            explanation: "Coins and platforms differ, and your wallet holds the keys that prove ownership."),
                        .trueFalse(id: "u9l3q4", prompt: "Your private key is like a password that lets you spend your crypto, so you must keep it secret.", correctIsTrue: true,
                            explanation: "Anyone who has your private key can move your crypto, so never share it."),
                        .multiSelect(id: "u9l3q5", prompt: "Which are true about crypto wallets and keys? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Your public address can be shared to receive funds"),
                            AnswerChoice(id: 1, text: "Your private key must stay secret"),
                            AnswerChoice(id: 2, text: "A wallet stores your keys"),
                            AnswerChoice(id: 3, text: "Sharing your private key with others is perfectly safe")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Share your public address freely, but guard your private key like a password."),
                        .multipleChoice(id: "u9l3q6", prompt: "What is the difference between a coin and a token?",
                            choices: [
                            AnswerChoice(id: 0, text: "A coin has its own blockchain; a token is built on another blockchain"),
                            AnswerChoice(id: 1, text: "A coin is physical; a token is digital"),
                            AnswerChoice(id: 2, text: "They are exactly the same thing"),
                            AnswerChoice(id: 3, text: "A token is always worth more than a coin")
                            ], correct: 0,
                            explanation: "Coins like Bitcoin run their own chain, while tokens ride on top of a chain like Ethereum."),
                        .trueFalse(id: "u9l3q7", prompt: "If you lose your private key, there is usually a 'forgot password' button to recover your crypto.", correctIsTrue: false,
                            explanation: "There is no reset button in crypto, so losing your key usually means losing your coins forever.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit9-lesson4",
                    title: "Crypto Risks & Safety",
                    iconName: "exclamationmark.shield.fill",
                    questions: [
                        .multipleChoice(id: "u9l4q1", prompt: "What is the golden rule of crypto investing?",
                            choices: [
                            AnswerChoice(id: 0, text: "Only invest what you can afford to lose"),
                            AnswerChoice(id: 1, text: "Always borrow money to buy more"),
                            AnswerChoice(id: 2, text: "Put all of your savings into one coin"),
                            AnswerChoice(id: 3, text: "Never do any research first")
                            ], correct: 0,
                            explanation: "Because crypto is so volatile, only risk money you could lose without wrecking your life."),
                        .trueFalse(id: "u9l4q2", prompt: "Crypto held on an exchange or in a wallet is insured by the FDIC like a bank deposit.", correctIsTrue: false,
                            explanation: "There is no FDIC protection for crypto, so if it is lost or stolen, no one guarantees it back."),
                        .numeric(id: "u9l4q3", prompt: "You invest $500 in a coin and it drops 80%. How many dollars is your holding worth now?", answer: 100, tolerance: 0, prefix: "$",
                            explanation: "An 80% drop leaves 20%, and 20% of $500 is $100."),
                        .multipleChoice(id: "u9l4q4", prompt: "What is a 'rug pull'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Creators hype a project, take investors' money, then vanish"),
                            AnswerChoice(id: 1, text: "A way to earn guaranteed interest"),
                            AnswerChoice(id: 2, text: "A type of extra-secure wallet"),
                            AnswerChoice(id: 3, text: "A government tax on crypto gains")
                            ], correct: 0,
                            explanation: "In a rug pull, the founders disappear with the money, leaving investors with worthless coins."),
                        .multiSelect(id: "u9l4q5", prompt: "Which are smart crypto safety habits? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Only invest what you can afford to lose"),
                            AnswerChoice(id: 1, text: "Back up your keys somewhere safe"),
                            AnswerChoice(id: 2, text: "Share your private key with helpful strangers"),
                            AnswerChoice(id: 3, text: "Be skeptical of promises of guaranteed returns")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Protect your keys and your money, and never hand your private key to anyone."),
                        .matching(id: "u9l4q6", prompt: "Match each risk to its description.",
                            pairs: [
                            MatchPair(id: 0, left: "Lost keys", right: "No way to recover access to your coins"),
                            MatchPair(id: 1, left: "Rug pull", right: "Founders take the money and disappear"),
                            MatchPair(id: 2, left: "Volatility", right: "Prices can crash quickly"),
                            MatchPair(id: 3, left: "No FDIC", right: "Losses are not insured by the government")
                            ],
                            explanation: "Knowing the main risks helps you spot trouble before it costs you."),
                        .trueFalse(id: "u9l4q7", prompt: "A project promising guaranteed high returns with no risk is a classic warning sign of a scam.", correctIsTrue: true,
                            explanation: "No real investment guarantees big returns with zero risk, so that promise is a red flag.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit9-lesson5",
                    title: "The Wider Crypto World",
                    iconName: "network",
                    questions: [
                        .multipleChoice(id: "u9l5q1", prompt: "What is a stablecoin?",
                            choices: [
                            AnswerChoice(id: 0, text: "A crypto designed to hold a steady value, often pegged to $1"),
                            AnswerChoice(id: 1, text: "A coin that always doubles in price"),
                            AnswerChoice(id: 2, text: "A physical silver coin"),
                            AnswerChoice(id: 3, text: "A government savings bond")
                            ], correct: 0,
                            explanation: "Stablecoins aim to stay near a fixed value like $1, so they swing far less than Bitcoin."),
                        .multipleChoice(id: "u9l5q2", prompt: "What is an NFT?",
                            choices: [
                            AnswerChoice(id: 0, text: "A unique digital token that proves ownership of a specific item"),
                            AnswerChoice(id: 1, text: "A stablecoin pegged to gold"),
                            AnswerChoice(id: 2, text: "A type of credit card"),
                            AnswerChoice(id: 3, text: "A bank account for crypto")
                            ], correct: 0,
                            explanation: "NFT means non-fungible token, a one-of-a-kind digital certificate of ownership."),
                        .multipleChoice(id: "u9l5q3", prompt: "What does DeFi (decentralized finance) mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "Financial services like lending and trading built on blockchains without traditional banks"),
                            AnswerChoice(id: 1, text: "A government finance department"),
                            AnswerChoice(id: 2, text: "A savings account at a normal bank"),
                            AnswerChoice(id: 3, text: "A crypto exchange owned by a bank")
                            ], correct: 0,
                            explanation: "DeFi recreates banking-style services using code on a blockchain instead of a bank."),
                        .categorize(id: "u9l5q4", prompt: "Sort each description into stablecoin, NFT, or DeFi.",
                            categories: ["Stablecoin", "NFT", "DeFi"],
                            items: [
                            CategoryItem(id: 0, text: "Aims to stay pinned near $1", correctCategory: "Stablecoin"),
                            CategoryItem(id: 1, text: "A one-of-a-kind digital collectible", correctCategory: "NFT"),
                            CategoryItem(id: 2, text: "Lending or trading crypto without a bank", correctCategory: "DeFi"),
                            CategoryItem(id: 3, text: "Often pegged to the US dollar", correctCategory: "Stablecoin"),
                            CategoryItem(id: 4, text: "Proves you own a unique piece of digital art", correctCategory: "NFT"),
                            CategoryItem(id: 5, text: "A decentralized exchange app", correctCategory: "DeFi")
                            ],
                            explanation: "Stablecoins hold value, NFTs prove ownership, and DeFi offers bank-like services on-chain."),
                        .trueFalse(id: "u9l5q5", prompt: "A stranger DMs you promising to double any crypto you send them. This is a scam.", correctIsTrue: true,
                            explanation: "'Send me crypto and I'll send back double' is one of the oldest scams around."),
                        .multiSelect(id: "u9l5q6", prompt: "Which are common crypto scam red flags? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Promises of guaranteed profit"),
                            AnswerChoice(id: 1, text: "Pressure to act fast right now"),
                            AnswerChoice(id: 2, text: "Requests for your private key or seed phrase"),
                            AnswerChoice(id: 3, text: "Using a well-known regulated exchange")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Guarantees, urgency, and key requests scream scam; a reputable exchange is not itself a red flag."),
                        .trueFalse(id: "u9l5q7", prompt: "NFTs and DeFi carry no risk because they use blockchain technology.", correctIsTrue: false,
                            explanation: "Blockchain does not remove risk; NFTs and DeFi can still lose value or be exploited by hackers.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit9-check",
                    title: "Crypto & Digital Assets: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .trueFalse(id: "u9l1q2-kc", prompt: "Cryptocurrency is issued and guaranteed by a national government.", correctIsTrue: false,
                            explanation: "Unlike dollars or euros, most crypto has no government behind it promising its value."),
                        .multiSelect(id: "u9l1q4-kc", prompt: "Which are true of most cryptocurrencies? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "They are digital-only"),
                            AnswerChoice(id: 1, text: "They run on a decentralized network"),
                            AnswerChoice(id: 2, text: "Their prices can swing sharply"),
                            AnswerChoice(id: 3, text: "They are insured by the FDIC")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Crypto is digital, decentralized, and volatile, but it is NOT FDIC-insured like a bank deposit."),
                        .trueFalse(id: "u9l1q6-kc", prompt: "Crypto prices can be very volatile, sometimes moving 10% or more in a single day.", correctIsTrue: true,
                            explanation: "Big, fast price swings are normal in crypto, which makes it risky for money you might need soon."),
                        .trueFalse(id: "u9l2q2-kc", prompt: "Once data is confirmed on a blockchain, it is extremely hard to change.", correctIsTrue: true,
                            explanation: "Blocks are locked together with cryptography, so altering old records is nearly impossible."),
                        .multipleChoice(id: "u9l2q4-kc", prompt: "What do miners or validators do?",
                            choices: [
                            AnswerChoice(id: 0, text: "Verify transactions and add new blocks"),
                            AnswerChoice(id: 1, text: "Print new dollar bills"),
                            AnswerChoice(id: 2, text: "Delete old transactions for fun"),
                            AnswerChoice(id: 3, text: "Set the country's interest rates")
                            ], correct: 0,
                            explanation: "Miners and validators do the work of checking transactions and adding them to the chain."),
                        .matching(id: "u9l2q6-kc", prompt: "Match each term to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Ledger", right: "A record of all transactions"),
                            MatchPair(id: 1, left: "Node", right: "A computer that helps run the network"),
                            MatchPair(id: 2, left: "Block", right: "A batch of confirmed transactions"),
                            MatchPair(id: 3, left: "Decentralized", right: "No single central authority in charge")
                            ],
                            explanation: "These are the core building blocks: a ledger of blocks, kept by nodes, with no central boss."),
                        .multipleChoice(id: "u9l3q2-kc", prompt: "Ethereum is best described as...",
                            choices: [
                            AnswerChoice(id: 0, text: "A platform for apps and smart contracts"),
                            AnswerChoice(id: 1, text: "A currency printed by a government"),
                            AnswerChoice(id: 2, text: "A physical hardware wallet"),
                            AnswerChoice(id: 3, text: "A savings bank")
                            ], correct: 0,
                            explanation: "Ethereum is a programmable platform where developers build apps, not just a simple coin."),
                        .trueFalse(id: "u9l3q4-kc", prompt: "Your private key is like a password that lets you spend your crypto, so you must keep it secret.", correctIsTrue: true,
                            explanation: "Anyone who has your private key can move your crypto, so never share it."),
                        .multipleChoice(id: "u9l3q6-kc", prompt: "What is the difference between a coin and a token?",
                            choices: [
                            AnswerChoice(id: 0, text: "A coin has its own blockchain; a token is built on another blockchain"),
                            AnswerChoice(id: 1, text: "A coin is physical; a token is digital"),
                            AnswerChoice(id: 2, text: "They are exactly the same thing"),
                            AnswerChoice(id: 3, text: "A token is always worth more than a coin")
                            ], correct: 0,
                            explanation: "Coins like Bitcoin run their own chain, while tokens ride on top of a chain like Ethereum."),
                        .trueFalse(id: "u9l4q2-kc", prompt: "Crypto held on an exchange or in a wallet is insured by the FDIC like a bank deposit.", correctIsTrue: false,
                            explanation: "There is no FDIC protection for crypto, so if it is lost or stolen, no one guarantees it back."),
                        .multipleChoice(id: "u9l4q4-kc", prompt: "What is a 'rug pull'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Creators hype a project, take investors' money, then vanish"),
                            AnswerChoice(id: 1, text: "A way to earn guaranteed interest"),
                            AnswerChoice(id: 2, text: "A type of extra-secure wallet"),
                            AnswerChoice(id: 3, text: "A government tax on crypto gains")
                            ], correct: 0,
                            explanation: "In a rug pull, the founders disappear with the money, leaving investors with worthless coins."),
                        .matching(id: "u9l4q6-kc", prompt: "Match each risk to its description.",
                            pairs: [
                            MatchPair(id: 0, left: "Lost keys", right: "No way to recover access to your coins"),
                            MatchPair(id: 1, left: "Rug pull", right: "Founders take the money and disappear"),
                            MatchPair(id: 2, left: "Volatility", right: "Prices can crash quickly"),
                            MatchPair(id: 3, left: "No FDIC", right: "Losses are not insured by the government")
                            ],
                            explanation: "Knowing the main risks helps you spot trouble before it costs you."),
                        .multipleChoice(id: "u9l5q2-kc", prompt: "What is an NFT?",
                            choices: [
                            AnswerChoice(id: 0, text: "A unique digital token that proves ownership of a specific item"),
                            AnswerChoice(id: 1, text: "A stablecoin pegged to gold"),
                            AnswerChoice(id: 2, text: "A type of credit card"),
                            AnswerChoice(id: 3, text: "A bank account for crypto")
                            ], correct: 0,
                            explanation: "NFT means non-fungible token, a one-of-a-kind digital certificate of ownership."),
                        .categorize(id: "u9l5q4-kc", prompt: "Sort each description into stablecoin, NFT, or DeFi.",
                            categories: ["Stablecoin", "NFT", "DeFi"],
                            items: [
                            CategoryItem(id: 0, text: "Aims to stay pinned near $1", correctCategory: "Stablecoin"),
                            CategoryItem(id: 1, text: "A one-of-a-kind digital collectible", correctCategory: "NFT"),
                            CategoryItem(id: 2, text: "Lending or trading crypto without a bank", correctCategory: "DeFi"),
                            CategoryItem(id: 3, text: "Often pegged to the US dollar", correctCategory: "Stablecoin"),
                            CategoryItem(id: 4, text: "Proves you own a unique piece of digital art", correctCategory: "NFT"),
                            CategoryItem(id: 5, text: "A decentralized exchange app", correctCategory: "DeFi")
                            ],
                            explanation: "Stablecoins hold value, NFTs prove ownership, and DeFi offers bank-like services on-chain."),
                        .multiSelect(id: "u9l5q6-kc", prompt: "Which are common crypto scam red flags? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Promises of guaranteed profit"),
                            AnswerChoice(id: 1, text: "Pressure to act fast right now"),
                            AnswerChoice(id: 2, text: "Requests for your private key or seed phrase"),
                            AnswerChoice(id: 3, text: "Using a well-known regulated exchange")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Guarantees, urgency, and key requests scream scam; a reputable exchange is not itself a red flag.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )

    private static let quantCorner = LearningUnit(
            id: "unit11",
            title: "Unit 12: Quant Corner",
            subtitle: "Probability, data, and the math of markets",
            colorHex: "3D5A80",
            lessons: [
                Lesson(
                    id: "unit11-lesson1",
                    title: "Probability & Expected Value",
                    iconName: "die.face.5.fill",
                    questions: [
                        .multipleChoice(id: "u11l1q1", prompt: "What does 'expected value' (EV) mean?",
                            choices: [
                            AnswerChoice(id: 0, text: "The long-run average outcome, found by adding each outcome times its probability"),
                            AnswerChoice(id: 1, text: "The result you personally hope will happen"),
                            AnswerChoice(id: 2, text: "The single biggest amount you could win"),
                            AnswerChoice(id: 3, text: "A payout you are guaranteed to receive")
                            ], correct: 0,
                            explanation: "EV is the probability-weighted average of every outcome, so it tells you what a bet is worth over many tries, not on any one try."),
                        .numeric(id: "u11l1q2", prompt: "A game gives a 30% chance to win $10 and a 70% chance to win nothing. What is its expected value, in dollars?", answer: 3, tolerance: 0, prefix: "$",
                            explanation: "(0.30 x $10) + (0.70 x $0) = $3. On average each play is worth $3, even though most plays win $0."),
                        .trueFalse(id: "u11l1q3", prompt: "A bet can have positive expected value and still lose on any single try.", correctIsTrue: true,
                            explanation: "Positive EV means it pays off on average over many tries, but luck still decides a single outcome."),
                        .multipleChoice(id: "u11l1q4", prompt: "Why do casinos reliably make money over time?",
                            choices: [
                            AnswerChoice(id: 0, text: "Every game is tilted slightly in the house's favor, and that tiny edge repeats over millions of bets"),
                            AnswerChoice(id: 1, text: "They cheat at every single table"),
                            AnswerChoice(id: 2, text: "Players always run out of luck at midnight"),
                            AnswerChoice(id: 3, text: "They don't actually profit; casinos usually lose")
                            ], correct: 0,
                            explanation: "A small 'house edge' per bet, multiplied by a huge number of bets, turns into steady profit. Edge plus repetition wins."),
                        .categorize(id: "u11l1q5", prompt: "Sort each bet into positive or negative expected value.",
                            categories: ["Positive EV", "Negative EV"],
                            items: [
                            CategoryItem(id: 0, text: "Costs $1; 50% chance to win $5", correctCategory: "Positive EV"),
                            CategoryItem(id: 1, text: "A lottery that returns 60 cents on average per $1 ticket", correctCategory: "Negative EV"),
                            CategoryItem(id: 2, text: "Costs $2; 50% chance to win $3", correctCategory: "Negative EV"),
                            CategoryItem(id: 3, text: "Costs $5; 25% chance to win $30", correctCategory: "Positive EV")
                            ],
                            explanation: "Compare the average payout to the cost: $1 for a $2.50 average is positive, but $2 for a $1.50 average is negative. Most lottery tickets are negative EV."),
                        .multiSelect(id: "u11l1q6", prompt: "Which statements about expected value are true? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It weights each outcome by how likely it is"),
                            AnswerChoice(id: 1, text: "A positive-EV bet can still lose on a single try"),
                            AnswerChoice(id: 2, text: "It promises you a profit every single time"),
                            AnswerChoice(id: 3, text: "Negative-EV bets tend to lose money if repeated many times")
                            ], correctIDs: [0, 1, 3],
                            explanation: "EV is a long-run average, not a guarantee. Positive EV wins over many tries; negative EV bleeds money over many tries."),
                        .trueFalse(id: "u11l1q7", prompt: "The house edge is the reason that, over enough spins, the casino comes out ahead of the player.", correctIsTrue: true,
                            explanation: "Each game keeps a little more than it pays back, so the more you play, the more that edge grows in the house's favor.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit11-lesson2",
                    title: "Reading the Data",
                    iconName: "chart.bar.xaxis",
                    questions: [
                        .multipleChoice(id: "u11l2q1", prompt: "What is 'backtesting'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Checking how a strategy would have performed on historical data before risking real money"),
                            AnswerChoice(id: 1, text: "Testing your posture while you trade"),
                            AnswerChoice(id: 2, text: "Selling stocks you bought last week"),
                            AnswerChoice(id: 3, text: "Reviewing your monthly bank statement")
                            ], correct: 0,
                            explanation: "Quants replay history to ask 'would this rule have worked?' It is a cheap way to throw out bad ideas before betting real cash."),
                        .trueFalse(id: "u11l2q2", prompt: "A strategy that made money in the past is guaranteed to make money in the future.", correctIsTrue: false,
                            explanation: "Markets change and patterns fade once everyone spots them. Past performance never guarantees future results."),
                        .multipleChoice(id: "u11l2q3", prompt: "Your friend's one stock pick doubled. What would a quant say about copying them?",
                            choices: [
                            AnswerChoice(id: 0, text: "One result is far too small a sample; luck and skill look identical after a single trade"),
                            AnswerChoice(id: 1, text: "One win proves they are a genius"),
                            AnswerChoice(id: 2, text: "Always copy whoever won most recently"),
                            AnswerChoice(id: 3, text: "Sample size never matters")
                            ], correct: 0,
                            explanation: "Flip enough coins and someone gets five heads in a row. You need many results to tell real skill from a lucky streak."),
                        .multipleChoice(id: "u11l2q4", prompt: "Ice cream sales and sunburns both rise every summer. What does this show?",
                            choices: [
                            AnswerChoice(id: 0, text: "Correlation isn't causation; a third factor (hot, sunny weather) drives both"),
                            AnswerChoice(id: 1, text: "Ice cream causes sunburn"),
                            AnswerChoice(id: 2, text: "Sunburn makes people crave ice cream"),
                            AnswerChoice(id: 3, text: "The data must be wrong")
                            ], correct: 0,
                            explanation: "Two things moving together doesn't mean one causes the other. A hidden third cause is a classic trap in market data too."),
                        .matching(id: "u11l2q5", prompt: "Match each data idea to its meaning.",
                            pairs: [
                            MatchPair(id: 0, left: "Backtest", right: "Testing a rule on past data"),
                            MatchPair(id: 1, left: "Sample size", right: "How many data points you have"),
                            MatchPair(id: 2, left: "Correlation", right: "Two things moving together"),
                            MatchPair(id: 3, left: "Overfitting", right: "A rule tuned so tightly to old data it fails on new data")
                            ],
                            explanation: "These four ideas are the backbone of thinking with data instead of gut feelings."),
                        .numeric(id: "u11l2q6", prompt: "You flip a fair coin 10 times. How many heads would you EXPECT on average? (Whole number.)", answer: 5, tolerance: 0,
                            explanation: "Expected heads = 10 flips x 50% = 5. Any single run of 10 flips can differ, but 5 is the long-run average."),
                        .ordering(id: "u11l2q7", prompt: "Order these sample sizes from LEAST to MOST trustworthy for spotting a real pattern.",
                            items: [
                            "1 coin flip",
                            "10 coin flips",
                            "100 coin flips",
                            "10,000 coin flips"
                            ],
                            explanation: "The bigger the sample, the more luck averages out and the clearer any real pattern becomes.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit11-lesson3",
                    title: "Charts & Trends",
                    iconName: "chart.xyaxis.line",
                    questions: [
                        .multipleChoice(id: "u11l3q1", prompt: "What is a 'trend' on a price chart?",
                            choices: [
                            AnswerChoice(id: 0, text: "The general direction prices are moving over time: up, down, or sideways"),
                            AnswerChoice(id: 1, text: "The exact price at this second"),
                            AnswerChoice(id: 2, text: "A guarantee of tomorrow's price"),
                            AnswerChoice(id: 3, text: "The number of shares traded today")
                            ], correct: 0,
                            explanation: "A trend is the overall drift of prices across many days, not any single day's move."),
                        .multipleChoice(id: "u11l3q2", prompt: "What is a 'moving average'?",
                            choices: [
                            AnswerChoice(id: 0, text: "The average price over a recent window that slides forward, smoothing out day-to-day jumps"),
                            AnswerChoice(id: 1, text: "The fastest price change of the day"),
                            AnswerChoice(id: 2, text: "The all-time highest price of a stock"),
                            AnswerChoice(id: 3, text: "A fee charged for each trade")
                            ], correct: 0,
                            explanation: "It averages the last few prices and updates each day, drawing a smoother line that makes the trend easier to see."),
                        .trueFalse(id: "u11l3q3", prompt: "A moving average smooths out short-term noise to make the underlying trend easier to see.", correctIsTrue: true,
                            explanation: "By averaging recent prices, it flattens random wiggles so the bigger direction stands out."),
                        .numeric(id: "u11l3q4", prompt: "The last 3 closing prices were $8, $10, and $12. What is the 3-day moving average, in dollars?", answer: 10, tolerance: 0, prefix: "$",
                            explanation: "($8 + $10 + $12) / 3 = $30 / 3 = $10. You add the recent prices and divide by how many there are."),
                        .matching(id: "u11l3q5", prompt: "Match each chart term to what it means.",
                            pairs: [
                            MatchPair(id: 0, left: "Signal", right: "The real underlying trend"),
                            MatchPair(id: 1, left: "Noise", right: "Random day-to-day wiggles"),
                            MatchPair(id: 2, left: "Uptrend", right: "Prices generally rising over time"),
                            MatchPair(id: 3, left: "Moving average", right: "A smoothed line of recent prices")
                            ],
                            explanation: "Reading charts is mostly about separating the signal (the trend) from the noise (the random jitter)."),
                        .ordering(id: "u11l3q6", prompt: "Order these time frames from shortest to longest.",
                            items: [
                            "One minute",
                            "One hour",
                            "One day",
                            "One month"
                            ],
                            explanation: "Zooming out from minutes to months is how analysts tell short-term noise apart from the long-term trend."),
                        .multiSelect(id: "u11l3q7", prompt: "Which statements about reading charts are true? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "A moving average lags a bit because it is built from past prices"),
                            AnswerChoice(id: 1, text: "Short-term price wiggles are often just noise"),
                            AnswerChoice(id: 2, text: "A chart pattern guarantees what happens next"),
                            AnswerChoice(id: 3, text: "Longer time frames help reveal the bigger trend")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Charts describe the past and hint at direction, but no pattern can promise the future.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit11-lesson4",
                    title: "Risk, Reward & Position Sizing",
                    iconName: "scalemass.fill",
                    questions: [
                        .multipleChoice(id: "u11l4q1", prompt: "Why should you never put all your money into one trade?",
                            choices: [
                            AnswerChoice(id: 0, text: "A single loss could wipe you out, and you can't recover from zero"),
                            AnswerChoice(id: 1, text: "One trade is always illegal"),
                            AnswerChoice(id: 2, text: "It makes your taxes higher"),
                            AnswerChoice(id: 3, text: "Brokers ban large trades")
                            ], correct: 0,
                            explanation: "If everything rides on one bet and it fails, you have nothing left to bounce back with. Surviving losses is rule one."),
                        .multipleChoice(id: "u11l4q2", prompt: "What is diversification?",
                            choices: [
                            AnswerChoice(id: 0, text: "Spreading money across many different investments so one loss can't sink you"),
                            AnswerChoice(id: 1, text: "Buying as much of one hot stock as possible"),
                            AnswerChoice(id: 2, text: "Keeping all your cash under a mattress"),
                            AnswerChoice(id: 3, text: "Trading only on Fridays")
                            ], correct: 0,
                            explanation: "When your money is spread out, a single bad investment is only a small dent, not a disaster."),
                        .trueFalse(id: "u11l4q3", prompt: "Position sizing means deciding how much money to put into a single trade.", correctIsTrue: true,
                            explanation: "Choosing the size of each bet is how you control how much a loss can hurt you."),
                        .numeric(id: "u11l4q4", prompt: "You have $1,000 and follow a rule to risk at most 2% on any single trade. What is the most you'd risk, in dollars?", answer: 20, tolerance: 0, prefix: "$",
                            explanation: "2% of $1,000 = $20. Keeping each risk tiny means a losing streak can't blow up your whole account."),
                        .trueFalse(id: "u11l4q5", prompt: "After a 50% loss, you need a 100% gain just to get back to where you started.", correctIsTrue: true,
                            explanation: "Drop from $100 to $50, and you must double that $50 back to $100, which is a 100% gain. Losses hurt more than they look."),
                        .categorize(id: "u11l4q6", prompt: "Sort each action into whether it manages or increases your risk.",
                            categories: ["Manages risk", "Increases risk"],
                            items: [
                            CategoryItem(id: 0, text: "Putting your entire savings into one stock", correctCategory: "Increases risk"),
                            CategoryItem(id: 1, text: "Spreading money across many companies", correctCategory: "Manages risk"),
                            CategoryItem(id: 2, text: "Risking only a small percent per trade", correctCategory: "Manages risk"),
                            CategoryItem(id: 3, text: "Borrowing money to bet bigger (leverage)", correctCategory: "Increases risk"),
                            CategoryItem(id: 4, text: "Keeping some cash on the sidelines", correctCategory: "Manages risk")
                            ],
                            explanation: "Diversifying, sizing small, and holding cash cushion you; concentrating everything or using borrowed money amplifies the danger."),
                        .multiSelect(id: "u11l4q7", prompt: "Which are smart risk and position-sizing rules? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Never put all your money in one bet"),
                            AnswerChoice(id: 1, text: "Diversify across different investments"),
                            AnswerChoice(id: 2, text: "Size trades so a losing streak won't ruin you"),
                            AnswerChoice(id: 3, text: "Bet bigger after every loss to win it back")
                            ], correctIDs: [0, 1, 2],
                            explanation: "Doubling down to chase losses is how people blow up accounts. Staying diversified and sized to survive is the pro move.")
                    ],
                    xpReward: 20
                ),
                Lesson(
                    id: "unit11-lesson5",
                    title: "Meet the Quants",
                    iconName: "function",
                    questions: [
                        .multipleChoice(id: "u11l5q1", prompt: "What is a 'quant'?",
                            choices: [
                            AnswerChoice(id: 0, text: "Someone who uses math, statistics, and code to find and trade patterns in markets"),
                            AnswerChoice(id: 1, text: "A person who only trades gold coins"),
                            AnswerChoice(id: 2, text: "A banker who never touches computers"),
                            AnswerChoice(id: 3, text: "A news reporter who covers stocks")
                            ], correct: 0,
                            explanation: "Short for 'quantitative analyst', a quant turns market ideas into numbers, models, and code."),
                        .multipleChoice(id: "u11l5q2", prompt: "What is high-frequency trading (HFT)?",
                            choices: [
                            AnswerChoice(id: 0, text: "Computers making huge numbers of trades in fractions of a second"),
                            AnswerChoice(id: 1, text: "Trading once a year on your birthday"),
                            AnswerChoice(id: 2, text: "Buying a stock and holding it for decades"),
                            AnswerChoice(id: 3, text: "Trading only during lunch")
                            ], correct: 0,
                            explanation: "HFT firms use fast computers and code to place enormous numbers of tiny, split-second trades."),
                        .trueFalse(id: "u11l5q3", prompt: "Math and models can reduce and manage risk, but they can never delete it completely.", correctIsTrue: true,
                            explanation: "Even the best model is a simplification of a messy world, so surprises still happen. Risk is managed, never erased."),
                        .ordering(id: "u11l5q4", prompt: "Order how a quant typically builds a strategy.",
                            items: [
                            "Form an idea about the market",
                            "Turn it into a testable rule",
                            "Backtest it on historical data",
                            "Risk a small amount of real money"
                            ],
                            explanation: "Idea, rule, backtest, then a small live test: that careful loop is how quants avoid betting big on a hunch."),
                        .matching(id: "u11l5q5", prompt: "Match each quant tool or term to what it does.",
                            pairs: [
                            MatchPair(id: 0, left: "Algorithm", right: "A set of rules a computer follows to trade"),
                            MatchPair(id: 1, left: "Backtest", right: "Checking a strategy against past data"),
                            MatchPair(id: 2, left: "Diversification", right: "Spreading risk across many bets"),
                            MatchPair(id: 3, left: "Model", right: "A math simplification of how something works")
                            ],
                            explanation: "Quants combine these tools to test ideas and control risk instead of guessing."),
                        .multiSelect(id: "u11l5q6", prompt: "What do quants actually rely on? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Probability and statistics"),
                            AnswerChoice(id: 1, text: "Computer code and algorithms"),
                            AnswerChoice(id: 2, text: "A crystal ball that predicts prices perfectly"),
                            AnswerChoice(id: 3, text: "Careful risk management")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Quants lean on math, code, and risk control. Nobody, quant or not, can predict prices perfectly."),
                        .trueFalse(id: "u11l5q7", prompt: "Because models can be wrong, quants still use risk limits and position sizing to survive surprises.", correctIsTrue: true,
                            explanation: "Smart quants assume they'll be wrong sometimes, so they size bets to live through the losses.")
                    ],
                    xpReward: 20
                )
            ],
            finalTest:
                Lesson(
                    id: "unit11-check",
                    title: "Quant Corner: Knowledge Check",
                    iconName: "checkmark.seal.fill",
                    questions: [
                        .numeric(id: "u11l1q2-kc", prompt: "A game gives a 30% chance to win $10 and a 70% chance to win nothing. What is its expected value, in dollars?", answer: 3, tolerance: 0, prefix: "$",
                            explanation: "(0.30 x $10) + (0.70 x $0) = $3. On average each play is worth $3, even though most plays win $0."),
                        .multipleChoice(id: "u11l1q4-kc", prompt: "Why do casinos reliably make money over time?",
                            choices: [
                            AnswerChoice(id: 0, text: "Every game is tilted slightly in the house's favor, and that tiny edge repeats over millions of bets"),
                            AnswerChoice(id: 1, text: "They cheat at every single table"),
                            AnswerChoice(id: 2, text: "Players always run out of luck at midnight"),
                            AnswerChoice(id: 3, text: "They don't actually profit; casinos usually lose")
                            ], correct: 0,
                            explanation: "A small 'house edge' per bet, multiplied by a huge number of bets, turns into steady profit. Edge plus repetition wins."),
                        .multiSelect(id: "u11l1q6-kc", prompt: "Which statements about expected value are true? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "It weights each outcome by how likely it is"),
                            AnswerChoice(id: 1, text: "A positive-EV bet can still lose on a single try"),
                            AnswerChoice(id: 2, text: "It promises you a profit every single time"),
                            AnswerChoice(id: 3, text: "Negative-EV bets tend to lose money if repeated many times")
                            ], correctIDs: [0, 1, 3],
                            explanation: "EV is a long-run average, not a guarantee. Positive EV wins over many tries; negative EV bleeds money over many tries."),
                        .trueFalse(id: "u11l2q2-kc", prompt: "A strategy that made money in the past is guaranteed to make money in the future.", correctIsTrue: false,
                            explanation: "Markets change and patterns fade once everyone spots them. Past performance never guarantees future results."),
                        .multipleChoice(id: "u11l2q4-kc", prompt: "Ice cream sales and sunburns both rise every summer. What does this show?",
                            choices: [
                            AnswerChoice(id: 0, text: "Correlation isn't causation; a third factor (hot, sunny weather) drives both"),
                            AnswerChoice(id: 1, text: "Ice cream causes sunburn"),
                            AnswerChoice(id: 2, text: "Sunburn makes people crave ice cream"),
                            AnswerChoice(id: 3, text: "The data must be wrong")
                            ], correct: 0,
                            explanation: "Two things moving together doesn't mean one causes the other. A hidden third cause is a classic trap in market data too."),
                        .numeric(id: "u11l2q6-kc", prompt: "You flip a fair coin 10 times. How many heads would you EXPECT on average? (Whole number.)", answer: 5, tolerance: 0,
                            explanation: "Expected heads = 10 flips x 50% = 5. Any single run of 10 flips can differ, but 5 is the long-run average."),
                        .multipleChoice(id: "u11l3q2-kc", prompt: "What is a 'moving average'?",
                            choices: [
                            AnswerChoice(id: 0, text: "The average price over a recent window that slides forward, smoothing out day-to-day jumps"),
                            AnswerChoice(id: 1, text: "The fastest price change of the day"),
                            AnswerChoice(id: 2, text: "The all-time highest price of a stock"),
                            AnswerChoice(id: 3, text: "A fee charged for each trade")
                            ], correct: 0,
                            explanation: "It averages the last few prices and updates each day, drawing a smoother line that makes the trend easier to see."),
                        .numeric(id: "u11l3q4-kc", prompt: "The last 3 closing prices were $8, $10, and $12. What is the 3-day moving average, in dollars?", answer: 10, tolerance: 0, prefix: "$",
                            explanation: "($8 + $10 + $12) / 3 = $30 / 3 = $10. You add the recent prices and divide by how many there are."),
                        .ordering(id: "u11l3q6-kc", prompt: "Order these time frames from shortest to longest.",
                            items: [
                            "One minute",
                            "One hour",
                            "One day",
                            "One month"
                            ],
                            explanation: "Zooming out from minutes to months is how analysts tell short-term noise apart from the long-term trend."),
                        .multipleChoice(id: "u11l4q2-kc", prompt: "What is diversification?",
                            choices: [
                            AnswerChoice(id: 0, text: "Spreading money across many different investments so one loss can't sink you"),
                            AnswerChoice(id: 1, text: "Buying as much of one hot stock as possible"),
                            AnswerChoice(id: 2, text: "Keeping all your cash under a mattress"),
                            AnswerChoice(id: 3, text: "Trading only on Fridays")
                            ], correct: 0,
                            explanation: "When your money is spread out, a single bad investment is only a small dent, not a disaster."),
                        .numeric(id: "u11l4q4-kc", prompt: "You have $1,000 and follow a rule to risk at most 2% on any single trade. What is the most you'd risk, in dollars?", answer: 20, tolerance: 0, prefix: "$",
                            explanation: "2% of $1,000 = $20. Keeping each risk tiny means a losing streak can't blow up your whole account."),
                        .categorize(id: "u11l4q6-kc", prompt: "Sort each action into whether it manages or increases your risk.",
                            categories: ["Manages risk", "Increases risk"],
                            items: [
                            CategoryItem(id: 0, text: "Putting your entire savings into one stock", correctCategory: "Increases risk"),
                            CategoryItem(id: 1, text: "Spreading money across many companies", correctCategory: "Manages risk"),
                            CategoryItem(id: 2, text: "Risking only a small percent per trade", correctCategory: "Manages risk"),
                            CategoryItem(id: 3, text: "Borrowing money to bet bigger (leverage)", correctCategory: "Increases risk"),
                            CategoryItem(id: 4, text: "Keeping some cash on the sidelines", correctCategory: "Manages risk")
                            ],
                            explanation: "Diversifying, sizing small, and holding cash cushion you; concentrating everything or using borrowed money amplifies the danger."),
                        .multipleChoice(id: "u11l5q2-kc", prompt: "What is high-frequency trading (HFT)?",
                            choices: [
                            AnswerChoice(id: 0, text: "Computers making huge numbers of trades in fractions of a second"),
                            AnswerChoice(id: 1, text: "Trading once a year on your birthday"),
                            AnswerChoice(id: 2, text: "Buying a stock and holding it for decades"),
                            AnswerChoice(id: 3, text: "Trading only during lunch")
                            ], correct: 0,
                            explanation: "HFT firms use fast computers and code to place enormous numbers of tiny, split-second trades."),
                        .ordering(id: "u11l5q4-kc", prompt: "Order how a quant typically builds a strategy.",
                            items: [
                            "Form an idea about the market",
                            "Turn it into a testable rule",
                            "Backtest it on historical data",
                            "Risk a small amount of real money"
                            ],
                            explanation: "Idea, rule, backtest, then a small live test: that careful loop is how quants avoid betting big on a hunch."),
                        .multiSelect(id: "u11l5q6-kc", prompt: "What do quants actually rely on? (Choose all that apply.)",
                            choices: [
                            AnswerChoice(id: 0, text: "Probability and statistics"),
                            AnswerChoice(id: 1, text: "Computer code and algorithms"),
                            AnswerChoice(id: 2, text: "A crystal ball that predicts prices perfectly"),
                            AnswerChoice(id: 3, text: "Careful risk management")
                            ], correctIDs: [0, 1, 3],
                            explanation: "Quants lean on math, code, and risk control. Nobody, quant or not, can predict prices perfectly.")
                    ],
                    xpReward: 60, isFinalTest: true
                )
        )
}
