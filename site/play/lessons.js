// Lesson content exported from content_src/units (units 1-3).
// Question types: mc (multiple choice), tf (true/false), num (number), ms (select all).
const UNITS = [
 {
  "id": "unit1",
  "title": "Unit 1: Money Basics",
  "subtitle": "Budgeting, saving, and everyday money habits",
  "color": "#1E6B4F",
  "lessons": [
   {
    "id": "unit1-lesson1",
    "title": "Budgeting 101",
    "icon": "chart.pie.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u1l1q1",
      "prompt": "What is a budget?",
      "choices": [
       "A plan for how you'll spend and save your money",
       "A type of bank account",
       "A loan from the government",
       "A stock market index"
      ],
      "correct": 0,
      "explanation": "A budget is simply a plan that maps out your income and expenses so you know where your money is going."
     },
     {
      "type": "tf",
      "id": "u1l1q2",
      "prompt": "A budget should include both your income and your expenses.",
      "answer": true,
      "explanation": "A good budget tracks money coming in (income) and money going out (expenses)."
     },
     {
      "type": "num",
      "id": "u1l1q4",
      "prompt": "You earn $2,000 a month and spend $2,300. How many dollars over budget are you?",
      "answer": 300,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "Spending $2,300 on $2,000 of income is a $300 deficit. You're relying on savings or debt to cover the gap."
     },
     {
      "type": "tf",
      "id": "u1l1q5",
      "prompt": "The 50/30/20 rule suggests 50% needs, 30% wants, 20% savings.",
      "answer": true,
      "explanation": "It's a popular, simple guideline for splitting take-home pay across needs, wants, and savings."
     },
     {
      "type": "ms",
      "id": "u1l1q6",
      "prompt": "Which of these belong in the 'needs' bucket of a budget? (Choose all that apply.)",
      "choices": [
       "Rent",
       "Groceries",
       "Concert tickets",
       "Electricity bill"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Rent, groceries, and utilities are essentials. Concert tickets are a 'want': nice, but not required to live."
     }
    ]
   },
   {
    "id": "unit1-lesson2",
    "title": "Needs vs. Wants",
    "icon": "cart.fill",
    "questions": [
     {
      "type": "tf",
      "id": "u1l2q2",
      "prompt": "Streaming subscriptions are usually considered a 'want.'",
      "answer": true,
      "explanation": "Enjoyable, but not essential to survive, so streaming is generally a want."
     },
     {
      "type": "mc",
      "id": "u1l2q3",
      "prompt": "Why is it important to separate needs from wants?",
      "choices": [
       "It helps you cover essentials first and avoid debt",
       "It has no real impact on your finances",
       "It only matters for businesses",
       "It's required by law"
      ],
      "correct": 0,
      "explanation": "Knowing the difference makes sure essentials are paid for before extras. That's the core of not overspending."
     },
     {
      "type": "mc",
      "id": "u1l2q4",
      "prompt": "Which best describes a 'want'?",
      "choices": [
       "Something that improves life but isn't essential to survive",
       "Something you must have to survive",
       "A type of tax",
       "A government benefit"
      ],
      "correct": 0,
      "explanation": "Wants add comfort or fun; you could go without them if money got tight."
     },
     {
      "type": "tf",
      "id": "u1l2q6",
      "prompt": "Housing and basic utilities are usually considered needs.",
      "answer": true,
      "explanation": "Shelter, water, heat, and electricity are essentials. They're classic needs."
     },
     {
      "type": "num",
      "id": "u1l2q7",
      "prompt": "Using the 50/30/20 rule on $2,000 take-home pay, how many dollars go to 'wants'?",
      "answer": 600,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "30% of $2,000 is $600, the slice the rule sets aside for wants."
     }
    ]
   },
   {
    "id": "unit1-lesson3",
    "title": "Saving & Emergency Funds",
    "icon": "banknote.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u1l3q1",
      "prompt": "What is an emergency fund for?",
      "choices": [
       "Unexpected costs like medical bills or car repairs",
       "Buying stocks quickly",
       "Everyday grocery shopping",
       "Paying regular monthly rent"
      ],
      "correct": 0,
      "explanation": "It's a cushion for life's surprises, not for planned spending."
     },
     {
      "type": "num",
      "id": "u1l3q2",
      "prompt": "Experts often suggest saving how many months of expenses in an emergency fund? (Give the low end of the common 3–6 range.)",
      "answer": 3,
      "tolerance": 0,
      "suffix": " months",
      "explanation": "3–6 months of expenses is the usual target; 3 months is a solid starting goal."
     },
     {
      "type": "mc",
      "id": "u1l3q3",
      "prompt": "Where should you generally NOT keep your emergency fund?",
      "choices": [
       "In risky stocks that can drop fast",
       "In a high-yield savings account",
       "In a regular savings account",
       "Somewhere easy to access"
      ],
      "correct": 0,
      "explanation": "Emergency money must be safe and easy to reach, not tied up in something that could fall right when you need it."
     },
     {
      "type": "mc",
      "id": "u1l3q4",
      "prompt": "What does 'paying yourself first' mean?",
      "choices": [
       "Setting aside savings before spending on anything else",
       "Buying yourself gifts before bills",
       "Only paying bills you enjoy",
       "Investing all your income in stocks"
      ],
      "correct": 0,
      "explanation": "Automate savings before you can spend the money. It's gone before you miss it."
     },
     {
      "type": "tf",
      "id": "u1l3q5",
      "prompt": "An emergency fund should be easy to access quickly if needed.",
      "answer": true,
      "explanation": "Liquidity matters. In a real emergency you need the cash fast."
     },
     {
      "type": "num",
      "id": "u1l3q7",
      "prompt": "If your essential expenses are $1,500 a month, how big is a 3-month emergency fund?",
      "answer": 4500,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "$1,500 × 3 months = $4,500, enough to cover three months of essentials."
     }
    ]
   },
   {
    "id": "unit1-lesson4",
    "title": "Banking Basics",
    "icon": "building.columns.fill",
    "questions": [
     {
      "type": "tf",
      "id": "u1l4q2",
      "prompt": "A high-yield savings account usually pays more interest than a regular checking account.",
      "answer": true,
      "explanation": "High-yield savings accounts exist to grow your cash; checking is built for spending and pays little or nothing."
     },
     {
      "type": "mc",
      "id": "u1l4q3",
      "prompt": "In the U.S., what does FDIC insurance protect?",
      "choices": [
       "Your bank deposits (up to the limit) if the bank fails",
       "Your stocks if they lose value",
       "Your car in an accident",
       "Your credit score"
      ],
      "correct": 0,
      "explanation": "FDIC insurance covers bank deposits up to $250,000 per depositor, per bank. Crypto and stocks don't have that safety net."
     },
     {
      "type": "mc",
      "id": "u1l4q4",
      "prompt": "What is an overdraft fee?",
      "choices": [
       "A charge for spending more than your account balance",
       "A reward for saving",
       "A fee for checking your balance",
       "Interest you earn"
      ],
      "correct": 0,
      "explanation": "Spend past your balance and many banks charge an overdraft fee, often $30 or more each time."
     },
     {
      "type": "num",
      "id": "u1l4q5",
      "prompt": "You keep $2,000 in a savings account earning 4% APY. Roughly how many dollars of interest is that in one year?",
      "answer": 80,
      "tolerance": 5,
      "prefix": "$",
      "explanation": "4% of $2,000 is about $80 a year, free money for keeping your cash in the right account."
     },
     {
      "type": "ms",
      "id": "u1l4q6",
      "prompt": "Which habits help you avoid unnecessary bank fees? (Choose all that apply.)",
      "choices": [
       "Keep enough balance to avoid overdrafts",
       "Use in-network ATMs",
       "Ignore your account until payday",
       "Set up low-balance alerts"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Watching your balance, using in-network ATMs, and alerts all prevent fees. Ignoring the account is how fees sneak up on you."
     },
     {
      "type": "tf",
      "id": "u1l4q7",
      "prompt": "Money in a checking account is a good long-term investment for growing wealth.",
      "answer": false,
      "explanation": "Checking pays little to no interest, so inflation slowly erodes it. It's for spending; invest longer-term money elsewhere."
     }
    ]
   },
   {
    "id": "unit1-lesson5",
    "title": "Smart Spending",
    "icon": "tag.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u1l5q1",
      "prompt": "What is 'impulse spending'?",
      "choices": [
       "Buying on a whim without planning it",
       "Carefully comparing prices first",
       "Saving before you spend",
       "Paying a bill on time"
      ],
      "correct": 0,
      "explanation": "Impulse buys are unplanned purchases made in the moment, the enemy of a budget."
     },
     {
      "type": "mc",
      "id": "u1l5q2",
      "prompt": "The '24-hour rule' for shopping means…",
      "choices": [
       "Waiting a day before a non-essential purchase to see if you still want it",
       "Only shopping for 24 hours a year",
       "Returning everything within 24 hours",
       "Spending 24% of income on wants"
      ],
      "correct": 0,
      "explanation": "Sleeping on it filters out impulse buys. A lot of 'must-haves' feel optional the next day."
     },
     {
      "type": "num",
      "id": "u1l5q3",
      "prompt": "A $6 coffee bought every weekday. Roughly how many dollars is that over a 4-week month? (5 days × 4 weeks)",
      "answer": 120,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "$6 × 5 × 4 = $120 a month. Small daily buys add up fast. That's the 'latte factor.'"
     },
     {
      "type": "tf",
      "id": "u1l5q5",
      "prompt": "A sale is only a good deal if it's something you were already going to buy.",
      "answer": true,
      "explanation": "Spending $40 to 'save' $10 on something you didn't need still costs you $40. A deal only helps on real needs."
     },
     {
      "type": "mc",
      "id": "u1l5q6",
      "prompt": "Why are forgotten subscriptions a common money leak?",
      "choices": [
       "They quietly charge you every month whether you use them or not",
       "They're illegal",
       "They pay you interest",
       "They improve your credit score"
      ],
      "correct": 0,
      "explanation": "Auto-renewing subscriptions bill you on autopilot. Reviewing them a few times a year plugs the leak."
     }
    ]
   }
  ]
 },
 {
  "id": "unit7",
  "title": "Unit 2: Paychecks & Taxes",
  "subtitle": "Where your money goes before you see it",
  "color": "#1F5F7A",
  "lessons": [
   {
    "id": "unit7-lesson1",
    "title": "Reading a Paycheck",
    "icon": "banknote.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u7l1q1",
      "prompt": "What does 'gross pay' mean on a paycheck?",
      "choices": [
       "Your total earnings before any deductions",
       "The money you actually take home",
       "The tax you owe the government",
       "Your yearly bonus"
      ],
      "correct": 0,
      "explanation": "Gross pay is everything you earned before taxes and other deductions are taken out. It's always the bigger number."
     },
     {
      "type": "tf",
      "id": "u7l1q2",
      "prompt": "When deductions come out of your pay, your net (take-home) pay is smaller than your gross pay.",
      "answer": true,
      "explanation": "Net pay is what's left after taxes and deductions, so it's the smaller amount that lands in your bank account."
     },
     {
      "type": "num",
      "id": "u7l1q3",
      "prompt": "Your gross pay is $1,000 and total deductions are $250. What is your net (take-home) pay?",
      "answer": 750,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "$1,000 gross minus $250 in deductions leaves $750 of take-home pay."
     },
     {
      "type": "ms",
      "id": "u7l1q5",
      "prompt": "Which of these are common deductions taken out of a paycheck? (Choose all that apply.)",
      "choices": [
       "Federal income tax",
       "Social Security & Medicare (FICA)",
       "Your weekly grocery bill",
       "Health insurance premium"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Taxes, FICA, and benefits like health insurance come straight out of your pay. Your grocery bill is spending you handle yourself."
     },
     {
      "type": "mc",
      "id": "u7l1q6",
      "prompt": "What is a W-4 form used for?",
      "choices": [
       "Telling your employer how much federal tax to withhold from each paycheck",
       "Applying for a credit card",
       "Opening a savings account",
       "Filing for unemployment"
      ],
      "correct": 0,
      "explanation": "You fill out a W-4 when you start a job so your employer knows how much tax to hold back from each check."
     }
    ]
   },
   {
    "id": "unit7-lesson2",
    "title": "How Income Tax Works",
    "icon": "percent",
    "questions": [
     {
      "type": "mc",
      "id": "u7l2q1",
      "prompt": "What is your 'marginal tax rate'?",
      "choices": [
       "The rate applied to your last (highest) dollar of income",
       "The rate applied to every dollar you earn",
       "A tax only businesses pay",
       "A flat 10% on all income"
      ],
      "correct": 0,
      "explanation": "Your marginal rate is the rate on the top slice of your income, not on all of it. Different chunks of income get taxed at different rates."
     },
     {
      "type": "tf",
      "id": "u7l2q2",
      "prompt": "Moving into a higher tax bracket means your entire income is suddenly taxed at that higher rate.",
      "answer": false,
      "explanation": "This is the classic 'raise myth.' Only the income above the bracket's threshold is taxed at the higher rate, so a raise always leaves you with more money."
     },
     {
      "type": "tf",
      "id": "u7l2q3",
      "prompt": "A tax refund happens when you overpaid taxes during the year and the government returns the extra.",
      "answer": true,
      "explanation": "A refund isn't a bonus. It's your own money coming back because too much was withheld from your paychecks."
     },
     {
      "type": "num",
      "id": "u7l2q4",
      "prompt": "Say the first $10,000 you earn is taxed at 10%, and income above $10,000 is taxed at 20%. If you earn $30,000, how much tax do you owe in dollars?",
      "answer": 5000,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "10% of the first $10,000 is $1,000, and 20% of the remaining $20,000 is $4,000, for a total of $5,000."
     },
     {
      "type": "mc",
      "id": "u7l2q5",
      "prompt": "You get a raise that pushes part of your income into a higher bracket. What happens to your take-home pay?",
      "choices": [
       "Only the portion above the threshold is taxed higher, so you still take home more overall",
       "Your whole paycheck shrinks because you're now 'in' the higher bracket",
       "You take home exactly the same as before",
       "You now owe tax on money you earned in past years"
      ],
      "correct": 0,
      "explanation": "Brackets are marginal, so a raise always increases your take-home pay. Turning down a raise to 'avoid taxes' never makes sense."
     },
     {
      "type": "tf",
      "id": "u7l2q7",
      "prompt": "Your effective (average) tax rate is usually lower than your top marginal rate.",
      "answer": true,
      "explanation": "Because your lower income slices are taxed at lower rates, the average you actually pay comes out below your highest bracket rate."
     }
    ]
   },
   {
    "id": "unit7-lesson3",
    "title": "Types of Taxes",
    "icon": "building.columns.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u7l3q2",
      "prompt": "What are payroll taxes (FICA) used for?",
      "choices": [
       "Funding Social Security and Medicare",
       "Paying for your local library only",
       "Covering your health insurance directly",
       "Repaying your student loans"
      ],
      "correct": 0,
      "explanation": "FICA taxes come out of your wages to fund Social Security and Medicare, programs that support retirees and people needing care."
     },
     {
      "type": "tf",
      "id": "u7l3q3",
      "prompt": "Sales tax is a percentage added to the price of many goods and services when you buy them.",
      "answer": true,
      "explanation": "You pay sales tax at checkout, so a listed price often costs a bit more once tax is added on."
     },
     {
      "type": "ms",
      "id": "u7l3q5",
      "prompt": "Which taxes would a teen with a part-time job and no house realistically pay? (Choose all that apply.)",
      "choices": [
       "Payroll tax (FICA) from their paycheck",
       "Sales tax when they buy things",
       "State income tax in states that charge it",
       "Property tax on a house they don't own"
      ],
      "correct": [
       0,
       1,
       2
      ],
      "explanation": "FICA comes out of every paycheck, sales tax hits purchases, and many states tax wages too. Property tax only applies to real estate you own."
     },
     {
      "type": "num",
      "id": "u7l3q6",
      "prompt": "You buy a $50 item in a place with 8% sales tax. How much sales tax do you pay in dollars?",
      "answer": 4,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "8% of $50 is $4, so the total at the register would be $54."
     },
     {
      "type": "mc",
      "id": "u7l3q7",
      "prompt": "Property tax is mainly based on what?",
      "choices": [
       "The assessed value of real estate you own, like a house or land",
       "How much you spend at stores each year",
       "The number of hours you work",
       "Your streaming subscriptions"
      ],
      "correct": 0,
      "explanation": "Property tax is tied to the value of real estate you own, and it usually helps pay for local services like schools and roads."
     }
    ]
   },
   {
    "id": "unit7-lesson4",
    "title": "Retirement Accounts 101",
    "icon": "chart.line.uptrend.xyaxis",
    "questions": [
     {
      "type": "mc",
      "id": "u7l4q1",
      "prompt": "What is a 401(k)?",
      "choices": [
       "A retirement account offered through your employer, often funded straight from your paycheck",
       "A type of checking account for daily spending",
       "A short-term loan from your boss",
       "A government tax form"
      ],
      "correct": 0,
      "explanation": "A 401(k) is an employer-sponsored retirement account. Money can go in automatically from your paycheck, often before taxes."
     },
     {
      "type": "tf",
      "id": "u7l4q2",
      "prompt": "An employer 401(k) match is basically free money your employer adds when you contribute.",
      "answer": true,
      "explanation": "If your employer matches your contributions, that's extra money added to your retirement savings just for participating. Not grabbing it leaves free money on the table."
     },
     {
      "type": "num",
      "id": "u7l4q3",
      "prompt": "You contribute $2,000 to your 401(k) and your employer matches 50% of your contributions. How much free money does your employer add in dollars?",
      "answer": 1000,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "50% of your $2,000 contribution is $1,000 of employer match, bringing your total to $3,000."
     },
     {
      "type": "mc",
      "id": "u7l4q5",
      "prompt": "What's a key perk of a Roth IRA?",
      "choices": [
       "You pay taxes now, but qualified withdrawals in retirement are tax-free",
       "You never pay any taxes ever on any account",
       "Your employer is required to fund it for you",
       "You can withdraw all your earnings with no rules the day you open it"
      ],
      "correct": 0,
      "explanation": "With a Roth IRA you contribute after-tax money, and later your withdrawals (including all the growth) can come out tax-free."
     },
     {
      "type": "ms",
      "id": "u7l4q6",
      "prompt": "Which statements about tax-advantaged retirement accounts are true? (Choose all that apply.)",
      "choices": [
       "They let your money grow with tax benefits",
       "An employer match adds free money",
       "You should skip the match to keep more cash today",
       "Starting young gives compounding more time to work"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Tax perks, employer matches, and an early start all help. Skipping the match throws away free money."
     },
     {
      "type": "tf",
      "id": "u7l4q7",
      "prompt": "Thanks to compound growth, starting to invest at 22 instead of 32 can build a much bigger nest egg, even with the same monthly contribution.",
      "answer": true,
      "explanation": "Those extra years let your earnings pile up and earn even more, so time is one of your biggest advantages when investing."
     }
    ]
   },
   {
    "id": "unit7-lesson5",
    "title": "Your First Job Money Moves",
    "icon": "briefcase.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u7l5q1",
      "prompt": "What does 'pay yourself first' mean?",
      "choices": [
       "Set aside savings or investing money before you spend on anything else",
       "Buy yourself a treat every payday before paying bills",
       "Pay your rent before your savings",
       "Give yourself a raise whenever you want"
      ],
      "correct": 0,
      "explanation": "Paying yourself first means saving off the top of each paycheck, so saving happens automatically instead of with whatever's left over."
     },
     {
      "type": "tf",
      "id": "u7l5q2",
      "prompt": "'Lifestyle inflation' is when your spending rises as fast as your income, so you never really get ahead.",
      "answer": true,
      "explanation": "Also called lifestyle creep, it's why some people earn more but never save more. Keeping spending steady as income grows is how you build wealth."
     },
     {
      "type": "mc",
      "id": "u7l5q3",
      "prompt": "How can splitting your direct deposit help you save?",
      "choices": [
       "It automatically sends part of each paycheck to savings before you can spend it",
       "It makes your paycheck arrive faster",
       "It lowers your income tax rate",
       "It doubles your gross pay"
      ],
      "correct": 0,
      "explanation": "A direct deposit split routes some of every paycheck straight into savings, so you save without having to think about it."
     },
     {
      "type": "num",
      "id": "u7l5q4",
      "prompt": "You take home $1,500 per paycheck and pay yourself first by saving 20%. How many dollars go to savings?",
      "answer": 300,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "20% of $1,500 is $300, moved to savings before you spend the rest."
     },
     {
      "type": "ms",
      "id": "u7l5q6",
      "prompt": "Which are smart money moves at your first job? (Choose all that apply.)",
      "choices": [
       "Automate savings with a direct deposit split",
       "Grab the full employer 401(k) match",
       "Upgrade your lifestyle to match every raise",
       "Build an emergency fund"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Automating savings, taking the match, and building an emergency fund all set you up. Spending every raise is lifestyle inflation working against you."
     }
    ]
   }
  ]
 },
 {
  "id": "unit4",
  "title": "Unit 3: Credit & Debt",
  "subtitle": "Borrowing without getting bitten",
  "color": "#B04530",
  "lessons": [
   {
    "id": "unit4-lesson1",
    "title": "Credit Scores",
    "icon": "speedometer",
    "questions": [
     {
      "type": "mc",
      "id": "u4l1q1",
      "prompt": "What is a credit score?",
      "choices": [
       "A number that predicts how likely you are to repay borrowed money",
       "The amount of money in your bank account",
       "A tax the government charges on loans",
       "The interest rate on your savings account"
      ],
      "correct": 0,
      "explanation": "A credit score is a snapshot of your borrowing trustworthiness, so lenders can guess how risky it is to lend to you."
     },
     {
      "type": "num",
      "id": "u4l1q2",
      "prompt": "A FICO credit score ranges from a low of 300 up to a high of what number?",
      "answer": 850,
      "tolerance": 0,
      "explanation": "FICO scores run from 300 to 850. The higher you climb, the better the rates lenders offer you."
     },
     {
      "type": "tf",
      "id": "u4l1q3",
      "prompt": "Paying your bills on time is the single biggest factor in your credit score.",
      "answer": true,
      "explanation": "Payment history is about 35% of a FICO score. Nothing moves it more than paying on time."
     },
     {
      "type": "ms",
      "id": "u4l1q5",
      "prompt": "Which habits help you build a strong credit score? (Choose all that apply.)",
      "choices": [
       "Paying every bill on time",
       "Keeping credit card balances low",
       "Maxing out your cards every month",
       "Keeping older accounts open"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "On-time payments, low balances, and a long history all help. Maxing out cards spikes your utilization and drags your score down."
     },
     {
      "type": "tf",
      "id": "u4l1q7",
      "prompt": "A single hard inquiry usually only lowers your score by a few points.",
      "answer": true,
      "explanation": "One hard inquiry is a small, temporary dip. Missing payments does far more damage than a single application."
     }
    ]
   },
   {
    "id": "unit4-lesson2",
    "title": "Credit Cards",
    "icon": "creditcard.fill",
    "questions": [
     {
      "type": "mc",
      "id": "u4l2q1",
      "prompt": "What does APR stand for on a credit card?",
      "choices": [
       "Annual Percentage Rate",
       "Approved Payment Return",
       "Average Purchase Reward",
       "Automatic Payment Reminder"
      ],
      "correct": 0,
      "explanation": "APR is the Annual Percentage Rate: the yearly cost of carrying a balance on your card."
     },
     {
      "type": "tf",
      "id": "u4l2q2",
      "prompt": "If you pay your full statement balance by the due date, you typically pay no interest on your purchases.",
      "answer": true,
      "explanation": "That interest-free window is called the grace period. Pay in full and the card is basically free to use."
     },
     {
      "type": "mc",
      "id": "u4l2q3",
      "prompt": "What is the 'minimum payment trap'?",
      "choices": [
       "Paying only the minimum keeps you in debt for years because most of it goes to interest",
       "The bank forces you to pay extra fees each month",
       "You can never pay more than the minimum",
       "The minimum payment resets your credit score"
      ],
      "correct": 0,
      "explanation": "Paying just the minimum barely touches the balance. Most goes to interest, so the debt can linger for years."
     },
     {
      "type": "num",
      "id": "u4l2q4",
      "prompt": "Your card has a $2,000 limit and a $500 balance. What is your credit utilization, as a percent?",
      "answer": 25,
      "tolerance": 0,
      "suffix": "%",
      "explanation": "Utilization is balance ÷ limit: $500 ÷ $2,000 = 25%."
     },
     {
      "type": "num",
      "id": "u4l2q5",
      "prompt": "Experts suggest keeping your credit utilization below what percent to protect your score?",
      "answer": 30,
      "tolerance": 0,
      "suffix": "%",
      "explanation": "Staying under 30% utilization tells lenders you're not leaning too hard on your available credit."
     },
     {
      "type": "ms",
      "id": "u4l2q6",
      "prompt": "Which are smart credit card habits? (Choose all that apply.)",
      "choices": [
       "Pay the statement balance in full each month",
       "Keep your utilization low",
       "Only ever pay the minimum",
       "Set up autopay for at least the minimum"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Paying in full, keeping balances low, and automating payments keep you safe. Paying only the minimum is the trap to avoid."
     }
    ]
   },
   {
    "id": "unit4-lesson3",
    "title": "Loans & Interest",
    "icon": "percent",
    "questions": [
     {
      "type": "num",
      "id": "u4l3q2",
      "prompt": "You borrow $1,000 at 5% simple interest for 1 year. How much interest do you owe?",
      "answer": 50,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "Simple interest is principal × rate × time: $1,000 × 5% × 1 = $50."
     },
     {
      "type": "num",
      "id": "u4l3q3",
      "prompt": "You borrow $1,000 at 5% simple interest, but now for 2 years. How much total interest do you owe?",
      "answer": 100,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "$1,000 × 5% × 2 years = $100. Double the time means double the interest."
     },
     {
      "type": "tf",
      "id": "u4l3q4",
      "prompt": "With a fixed-rate amortizing loan, your early payments go mostly toward interest and later payments go mostly toward principal.",
      "answer": true,
      "explanation": "Early on you owe interest on a big balance, so most of the payment is interest. As the balance shrinks, more of each payment chips away the principal."
     },
     {
      "type": "mc",
      "id": "u4l3q5",
      "prompt": "What is the principal of a loan?",
      "choices": [
       "The original amount you borrowed, before interest",
       "The interest you pay each month",
       "The bank that gave you the loan",
       "The penalty for paying late"
      ],
      "correct": 0,
      "explanation": "The principal is the starting amount you borrowed. Interest is charged on top of it."
     },
     {
      "type": "mc",
      "id": "u4l3q7",
      "prompt": "All else equal, which loan will cost you the most in total interest?",
      "choices": [
       "A higher APR with a longer term",
       "A lower APR with a shorter term",
       "A lower APR with a longer term",
       "A higher APR with a shorter term"
      ],
      "correct": 0,
      "explanation": "A higher rate and more time both pile on interest. Combine them and you pay the most overall."
     }
    ]
   },
   {
    "id": "unit4-lesson4",
    "title": "Good Debt vs. Bad Debt",
    "icon": "arrow.up.arrow.down",
    "questions": [
     {
      "type": "mc",
      "id": "u4l4q2",
      "prompt": "What generally makes a debt 'good' debt?",
      "choices": [
       "It helps you build wealth or income and usually has a lower interest rate",
       "It always has to be paid back quickly",
       "It comes from a friend instead of a bank",
       "It never charges any interest"
      ],
      "correct": 0,
      "explanation": "Good debt is an investment in your future, like a home or education, at a manageable interest rate."
     },
     {
      "type": "tf",
      "id": "u4l4q3",
      "prompt": "Payday loans often carry extremely high APRs, sometimes around 400%.",
      "answer": true,
      "explanation": "Payday loans look small, but their fees add up to sky-high APRs. That's why they're classic bad debt."
     },
     {
      "type": "mc",
      "id": "u4l4q4",
      "prompt": "What does it mean to 'default' on a loan?",
      "choices": [
       "Failing to make your payments as agreed",
       "Paying the loan off early",
       "Refinancing to a lower rate",
       "Making an extra payment"
      ],
      "correct": 0,
      "explanation": "Defaulting means you've stopped paying as promised. It hurts your credit and can lead to collections."
     },
     {
      "type": "ms",
      "id": "u4l4q5",
      "prompt": "Which are possible consequences of defaulting on a loan? (Choose all that apply.)",
      "choices": [
       "Damage to your credit score",
       "Your account sent to collections",
       "Possible wage garnishment",
       "Your credit score automatically jumps to 850"
      ],
      "correct": [
       0,
       1,
       2
      ],
      "explanation": "Default can wreck your credit, send your debt to collectors, and even lead to garnished wages. It definitely won't boost your score."
     },
     {
      "type": "num",
      "id": "u4l4q7",
      "prompt": "A payday lender charges $15 in fees for every $100 borrowed. On a $200 loan, how many dollars in fees do you pay?",
      "answer": 30,
      "tolerance": 0,
      "prefix": "$",
      "explanation": "$15 per $100 × 2 = $30 in fees for just two weeks, which works out to a shockingly high APR."
     }
    ]
   },
   {
    "id": "unit4-lesson5",
    "title": "Getting Out of Debt",
    "icon": "chart.line.downtrend.xyaxis",
    "questions": [
     {
      "type": "mc",
      "id": "u4l5q1",
      "prompt": "In the debt 'avalanche' method, which debt do you attack first?",
      "choices": [
       "The one with the highest interest rate",
       "The one with the smallest balance",
       "The newest debt you took on",
       "The one with the friendliest lender"
      ],
      "correct": 0,
      "explanation": "The avalanche targets the highest interest rate first, which saves you the most money over time."
     },
     {
      "type": "mc",
      "id": "u4l5q2",
      "prompt": "In the debt 'snowball' method, which debt do you pay off first?",
      "choices": [
       "The one with the smallest balance",
       "The one with the highest interest rate",
       "The largest debt you owe",
       "Whichever is due first"
      ],
      "correct": 0,
      "explanation": "The snowball knocks out the smallest balance first, giving you a quick win to stay motivated."
     },
     {
      "type": "tf",
      "id": "u4l5q3",
      "prompt": "The avalanche method saves you the most money in interest over time.",
      "answer": true,
      "explanation": "By killing the highest-rate debt first, the avalanche minimizes the total interest you pay."
     },
     {
      "type": "mc",
      "id": "u4l5q4",
      "prompt": "Why do some people prefer the snowball method even though it can cost a little more?",
      "choices": [
       "Quick early wins keep them motivated to keep going",
       "It's the only method banks allow",
       "It always pays off debt faster than avalanche",
       "It erases interest completely"
      ],
      "correct": 0,
      "explanation": "Paying off a whole debt fast feels great, and that momentum helps many people stick with the plan."
     },
     {
      "type": "ms",
      "id": "u4l5q6",
      "prompt": "Which are smart steps when getting out of debt? (Choose all that apply.)",
      "choices": [
       "Always pay at least the minimum on every debt",
       "List your debts with their rates and balances",
       "Stop making any payments until you've saved a lump sum",
       "Put any extra money toward one target debt at a time"
      ],
      "correct": [
       0,
       1,
       3
      ],
      "explanation": "Always cover every minimum, map out your debts, and focus extra cash on one target. Skipping payments just adds fees and damages your credit."
     }
    ]
   }
  ]
 }
];
