export const meta = {
  name: 'invested-content',
  description: 'Author + fact-check 11 InvestEd learning units (5 lessons x 7 questions + a 10-question final test each) as validated JSON',
  phases: [
    { title: 'Author', detail: 'one finance educator agent writes each unit' },
    { title: 'Verify', detail: 'one fact-checker QAs and corrects each unit' },
  ],
}

// ---- Shared reference embedded into every agent prompt ----
const FORMAT_REF = `
QUESTION FORMATS — the "type" field selects the shape. Copy these field names EXACTLY.
- Multiple choice (exactly one right answer):
  {"type":"mc","id":"u7l1q1","prompt":"...","choices":["A","B","C","D"],"correct":0,"explanation":"..."}
- True / False (prompt is a statement):
  {"type":"tf","id":"u7l1q2","prompt":"<a statement>","answer":true,"explanation":"..."}
- Multi-select (choose ALL that apply; 2-3 correct; end the prompt with "(Choose all that apply.)"):
  {"type":"ms","id":"u7l1q3","prompt":"... (Choose all that apply.)","choices":["A","B","C","D"],"correct":[0,2],"explanation":"..."}
- Ordering (list the items in their CORRECT order; the app shuffles them for the learner):
  {"type":"order","id":"u7l1q4","prompt":"Put these steps in order.","items":["first","second","third","fourth"],"explanation":"..."}
- Matching (each left item pairs with the right item written beside it):
  {"type":"match","id":"u7l1q5","prompt":"Match each term to its meaning.","pairs":[["Term A","Meaning A"],["Term B","Meaning B"],["Term C","Meaning C"],["Term D","Meaning D"]],"explanation":"..."}
- Numeric (typed answer graded within tolerance; add "prefix":"$" or "suffix":"%" / " months" when it fits):
  {"type":"num","id":"u7l1q6","prompt":"...","answer":600,"tolerance":0,"prefix":"$","explanation":"..."}
  Estimate/slider variant: add "slider":true,"min":0,"max":100,"step":5 (answer must land on a step).
- Categorize (sort items into buckets):
  {"type":"cat","id":"u7l1q7","prompt":"Sort each into ...","categories":["Bucket A","Bucket B"],"items":[["Item 1","Bucket A"],["Item 2","Bucket B"],["Item 3","Bucket A"]],"explanation":"..."}
- Interactive option (learner builds a call or put on a stock — ONLY use in the Stock Market options lesson):
  {"type":"opt","id":"u3l5q1","prompt":"Build the position that fits.","symbol":"NVDA","company":"NVIDIA","spot":130,"scenario":"You're convinced NVDA jumps after earnings.","kind":"call","target":150,"success":"A call profits when the stock climbs above your strike plus the premium paid.","explanation":"..."}
  (kind is "call" for a bullish view, "put" for a bearish view.)

HARD RULES:
- Each regular lesson: EXACTLY 7 questions. The finalTest: EXACTLY 10 questions drawn from across the whole unit.
- Variety: each lesson uses at least 3 DIFFERENT types. Across the 5 lessons, use mc, tf, ms, order, match, num, and cat at least once each. (opt only where noted.)
- Every answer key MUST be correct. Double-check numeric math. For "num", set tolerance so only the intended answer counts (0 for exact facts; a small band only for genuine estimates).
- Facts must be accurate and written for a bright teenager. Explanations are 1-2 friendly sentences that teach the "why".
- IDs: lesson ids "<unitId>-lesson1" ... "<unitId>-lesson5"; final test id "<unitId>-final". Question ids "u<idNum>l<lessonNumber>q<k>" for lessons and "u<idNum>fq<k>" for the final. Keep every id unique.
- Matching: 3-4 pairs. Ordering: 3-5 items. Categorize: 2-3 buckets, 4-6 items. Multi-select: 4 choices, 2-3 correct.
- Output ONLY the unit object. icons are SF Symbol names (e.g. "chart.pie.fill", "banknote.fill", "building.columns.fill", "creditcard.fill", "percent", "bitcoinsign.circle.fill", "function", "brain.head.profile").`

const EXAMPLE = `EXAMPLE of one well-formed lesson (fields and shape to mirror — write your own content):
{"id":"unit1-lesson1","title":"Budgeting 101","icon":"chart.pie.fill","questions":[
 {"type":"mc","id":"u1l1q1","prompt":"What is a budget?","choices":["A plan for how you'll spend and save your money","A type of bank account","A loan from the government","A stock index"],"correct":0,"explanation":"A budget maps your income and expenses so you know where money goes."},
 {"type":"tf","id":"u1l1q2","prompt":"A budget should include both your income and your expenses.","answer":true,"explanation":"A good budget tracks money in and money out."},
 {"type":"cat","id":"u1l1q3","prompt":"Sort each cost into fixed or variable.","categories":["Fixed","Variable"],"items":[["Rent","Fixed"],["Groceries","Variable"],["Car insurance","Fixed"],["Dining out","Variable"]],"explanation":"Fixed costs stay the same monthly; variable costs move with your choices."},
 {"type":"num","id":"u1l1q4","prompt":"Using 50/30/20 on $2,000 take-home, how many dollars go to savings?","answer":400,"tolerance":0,"prefix":"$","explanation":"20% of $2,000 is $400."},
 {"type":"ms","id":"u1l1q5","prompt":"Which are 'needs'? (Choose all that apply.)","choices":["Rent","Groceries","Concert tickets","Electricity"],"correct":[0,1,3],"explanation":"Rent, groceries, and utilities are essentials; concert tickets are a want."},
 {"type":"order","id":"u1l1q6","prompt":"Order the budgeting steps.","items":["Total your income","List your expenses","Subtract expenses from income","Adjust to hit your savings goal"],"explanation":"Income, expenses, difference, adjust."},
 {"type":"tf","id":"u1l1q7","prompt":"Spending more than you earn creates a deficit.","answer":true,"explanation":"A deficit means relying on savings or debt to cover the gap."}
]}`

// ---- The 11 units to build (Unit 1 Money Basics is already hand-authored) ----
const UNIT_SPECS = [
  { file: '02_paychecks_taxes', constName: 'paychecksAndTaxes', id: 'unit7', idNum: 7,
    title: 'Unit 2: Paychecks & Taxes', subtitle: 'Where your money goes before you see it',
    colorHex: '00B4D8', mascot: 'Chip the beaver',
    lessons: ['Reading a Paycheck (gross vs net, deductions, W-4)',
              'How Income Tax Works (marginal brackets, refunds, the raise myth)',
              'Types of Taxes (income, payroll/FICA, sales, property)',
              'Retirement Accounts 101 (401(k), Roth IRA, employer match = free money, tax-advantaged growth)',
              'Your First Job Money Moves (pay yourself first, lifestyle inflation, direct deposit split)'] },
  { file: '03_credit_debt', constName: 'creditAndDebt', id: 'unit4', idNum: 4,
    title: 'Unit 3: Credit & Debt', subtitle: 'Borrowing without getting bitten',
    colorHex: 'EF476F', mascot: 'Felix the fox',
    lessons: ['Credit Scores (what they are, payment history, soft vs hard inquiries)',
              'Credit Cards (APR, minimum payment trap, grace period, utilization)',
              'Loans & Interest (principal, interest, APR, simple amortization intuition)',
              'Good Debt vs Bad Debt (student loans/mortgage vs payday loans, default)',
              'Getting Out of Debt (snowball vs avalanche, paying highest-rate first)'] },
  { file: '04_power_of_time', constName: 'powerOfTime', id: 'unit5', idNum: 5,
    title: 'Unit 4: The Power of Time', subtitle: 'Compound growth and starting early',
    colorHex: 'FF6B4A', mascot: 'Shelley the turtle',
    lessons: ['Compound Interest (interest on interest, debt compounds too)',
              'The Rule of 72 (estimate doubling time; 72 / rate ≈ years)',
              'Starting Early (time beats amount; the 18 vs 28 saver example)',
              'Dollar-Cost Averaging (fixed amount on a schedule, buys more when cheap)',
              'Setting Financial Goals (SMART goals, short vs long time horizons, matching savings vs investing to horizon)'] },
  { file: '05_investing_foundations', constName: 'investingFoundations', id: 'unit2', idNum: 2,
    title: 'Unit 5: Investing Foundations', subtitle: 'Stocks, bonds, risk, and portfolios',
    colorHex: '4361EE', mascot: 'Sage the owl',
    lessons: ['What Is a Stock? (ownership, shareholders, exchanges)',
              'Stocks vs Bonds (equity vs lending, risk/return differences)',
              'Risk & Return (the tradeoff, volatility, lower-risk assets)',
              'Diversification (spreading risk, index funds as easy diversification)',
              'Building a Portfolio (asset allocation, matching to goals and age, rebalancing idea)'] },
  { file: '06_stock_market', constName: 'stockMarket', id: 'unit3', idNum: 3,
    title: 'Unit 6: The Stock Market', subtitle: 'Quotes, orders, cycles, and options',
    colorHex: 'FFC93C', mascot: 'Toro the bull',
    lessons: ['Reading a Stock Quote (ticker, change %, market cap, price != company size)',
              'Market vs Limit Orders (speed vs price control)',
              'Bull vs Bear Markets (definitions, 20% rule, staying calm)',
              'Intro to Options (a call = right to BUY, a put = right to SELL; premium; 1 contract = 100 shares; calls are bullish, puts are bearish; max loss = premium)',
              'Options Challenge (a hands-on lesson: 4 short teaching questions PLUS at least 2 "opt" interactive questions where the learner builds the right call/put for a scenario — use real tickers like AAPL spot 212, NVDA spot 130, TSLA spot 256; mix a bullish scenario needing a call and a bearish scenario needing a put)'],
    note: 'Lesson 5 (unit3-lesson5) MUST include at least two "opt" type questions plus a few teaching questions (total 7).' },
  { file: '07_funds_fees', constName: 'fundsAndFees', id: 'unit6', idNum: 6,
    title: 'Unit 7: Funds & Fees', subtitle: 'Index funds, ETFs, and keeping costs low',
    colorHex: '9B5DE5', mascot: 'Hazel the squirrel',
    lessons: ['Index Funds (own the whole index, most active managers lag it)',
              'ETFs vs Mutual Funds (intraday trading vs once-daily pricing, fractional shares)',
              "What's Inside a Fund (holdings, sectors, weightings, one share = many companies)",
              'Why Fees Matter (expense ratios compound against you over decades)',
              'Automated Investing (robo-advisors, target-date funds, set-and-forget diversification)'] },
  { file: '08_macro_econ_1', constName: 'macroEconOne', id: 'unit10', idNum: 10,
    title: 'Unit 8: Macro Economics I', subtitle: 'The big picture and the business cycle',
    colorHex: '2EC4B6', mascot: 'Econ the elephant',
    lessons: ['What Is Macroeconomics? (whole-economy view vs personal finance; supply & demand at scale)',
              'GDP & Economic Growth (what GDP measures, growth vs contraction)',
              'Inflation & Prices (rising prices, purchasing power, CPI, ~2% target, real vs nominal returns)',
              'Unemployment & Jobs (unemployment rate, why some is normal, effect on spending)',
              'The Business Cycle (expansion, peak, contraction, trough; cycles always turn)'] },
  { file: '09_macro_econ_2', constName: 'macroEconTwo', id: 'unit12', idNum: 12,
    title: 'Unit 9: Macro Economics II', subtitle: 'Policy, trade, and the wider world',
    colorHex: '0077B6', mascot: 'Moby the whale',
    lessons: ['The Federal Reserve & Interest Rates (central bank, sets key rates, dual mandate)',
              'Monetary Policy (raising/lowering rates to cool or heat the economy, effect on borrowing & markets)',
              'Fiscal Policy (government spending and taxes, deficits and debt, stimulus)',
              'Trade & Currencies (imports/exports, exchange rates, why a strong/weak dollar matters)',
              'Recessions & Reading the News (recession definition, why headlines exaggerate, why an emergency fund matters)'] },
  { file: '10_investor_psychology', constName: 'investorPsychology', id: 'unit8', idNum: 8,
    title: 'Unit 10: Investor Psychology', subtitle: 'Outsmarting your own brain',
    colorHex: 'F15BB5', mascot: 'Bearry the bear',
    lessons: ['Emotions & FOMO (buying tops out of fear of missing out, panic-selling locks in losses)',
              'Cognitive Biases (loss aversion, anchoring, confirmation bias, herd mentality)',
              'Scams & Red Flags (guaranteed returns, Ponzi/pump-and-dump, paid promos are not analysis)',
              'Building Good Habits (automate, set a checking schedule, write rules before you invest)',
              'The Long Game (patience, buy-and-hold, missing the best days, time in the market)'] },
  { file: '11_crypto', constName: 'cryptoAndDigitalAssets', id: 'unit9', idNum: 9,
    title: 'Unit 11: Crypto & Digital Assets', subtitle: 'Bitcoin, blockchains, and staying safe',
    colorHex: 'F7931A', mascot: 'Rocky the raccoon',
    lessons: ['What Is Cryptocurrency? (digital, decentralized, not government-backed, volatile)',
              'Blockchain Basics (shared tamper-resistant ledger, decentralization, miners/validators)',
              'Coins & Tokens (Bitcoin as digital gold vs Ethereum as a platform; wallets & private keys)',
              'Crypto Risks & Safety (only-what-you-can-lose, lost keys, rug pulls, no FDIC)',
              'The Wider Crypto World (stablecoins, NFTs, DeFi at a beginner level, scam awareness)'] },
  { file: '12_quant', constName: 'quantCorner', id: 'unit11', idNum: 11,
    title: 'Unit 12: Quant Corner', subtitle: 'Probability, data, and the math of markets',
    colorHex: '3D5A80', mascot: 'Otto the octopus',
    lessons: ['Probability & Expected Value (EV = sum of outcome x probability; positive-EV bets; house edge)',
              'Reading the Data (backtesting, sample size, correlation vs causation, past != future)',
              'Charts & Trends (price trends, moving-average intuition, noise vs signal — kept simple)',
              'Risk, Reward & Position Sizing (never bet it all, diversify, size positions to survive losses)',
              'Meet the Quants (what quants do, algorithms/HFT, math manages risk but cannot delete it)'] },
]

function authorPrompt(spec) {
  return `You are an expert personal-finance and investing educator writing content for InvestEd, a Duolingo-style app for teenagers and beginners. Author ONE complete learning unit as a JSON object.

UNIT: ${spec.title}
Unit id: ${spec.id}  (idNum ${spec.idNum})  constName: ${spec.constName}
Subtitle: ${spec.subtitle}
Color: ${spec.colorHex}   Guide mascot (for tone): ${spec.mascot}

The five lessons (in this order) and what each must teach:
${spec.lessons.map((l, i) => `  Lesson ${i + 1}: ${l}`).join('\n')}
${spec.note ? '\nSPECIAL: ' + spec.note : ''}

Then a final test (id "${spec.id}-final", title "${spec.title.replace(/^Unit \d+: /, '')}: Final Test", icon "trophy.fill", xp 50) with EXACTLY 10 questions that review the whole unit, mixing question types.

${FORMAT_REF}

${EXAMPLE}

Return the unit object with keys: constName ("${spec.constName}"), id ("${spec.id}"), title ("${spec.title}"), subtitle ("${spec.subtitle}"), colorHex ("${spec.colorHex}"), lessons (array of 5), finalTest (object). Make it genuinely educational, accurate, and fun.`
}

function verifyPrompt(spec) {
  return `You are a meticulous QA fact-checker for InvestEd's teen finance curriculum. You are given a JSON unit an author produced. Rigorously check and FIX it, then return the corrected unit object.

Check EVERY item:
1. Facts: every statement and explanation is accurate for a US teen audience. Fix any error.
2. Answer keys: for each question, confirm the marked answer is truly correct. Recompute all numeric math by hand; fix wrong "answer"/"correct"/"answer keys". For "tf" the "answer" boolean must match the statement's truth. For "ms" the "correct" list must be exactly the right indices. For "match" every pair's right side must actually be the correct match for its left. For "order" the "items" must be in the genuinely correct order. For "opt" kind must be "call" for bullish scenarios and "put" for bearish ones.
3. Structure: exactly 5 lessons, each with EXACTLY 7 questions; finalTest has EXACTLY 10. If counts are off, add or trim questions to hit them.
4. Type field names EXACTLY match the format reference below; fix any malformed question. Every id unique and following the convention (unit ${spec.id}, idNum ${spec.idNum}).
5. Variety: across the 5 lessons, mc, tf, ms, order, match, num, and cat each appear at least once. If a type is missing, convert a weaker question to it.
6. Quality: prompts unambiguous, explanations teach the "why" in 1-2 sentences, difficulty rises gently through the unit.
${spec.note ? '7. SPECIAL: ' + spec.note + ' Ensure this is satisfied.' : ''}

${FORMAT_REF}

Return the fully corrected unit object (same keys: constName, id, title, subtitle, colorHex, lessons, finalTest). Output the whole unit, not a diff.`
}

// Permissive schema: locks the unit shape, leaves question objects flexible
// (gen_content.py + the Swift compiler are the strict downstream validators).
const LESSON_SCHEMA = {
  type: 'object',
  required: ['id', 'title', 'icon', 'questions'],
  properties: {
    id: { type: 'string' },
    title: { type: 'string' },
    icon: { type: 'string' },
    xp: { type: 'integer' },
    questions: { type: 'array', minItems: 7, maxItems: 12, items: { type: 'object', additionalProperties: true } },
  },
  additionalProperties: true,
}
const UNIT_SCHEMA = {
  type: 'object',
  required: ['constName', 'id', 'title', 'subtitle', 'colorHex', 'lessons', 'finalTest'],
  properties: {
    constName: { type: 'string' },
    id: { type: 'string' },
    title: { type: 'string' },
    subtitle: { type: 'string' },
    colorHex: { type: 'string' },
    lessons: { type: 'array', minItems: 5, maxItems: 5, items: LESSON_SCHEMA },
    finalTest: LESSON_SCHEMA,
  },
  additionalProperties: true,
}

const results = await pipeline(
  UNIT_SPECS,
  (spec) => agent(authorPrompt(spec), { label: `author:${spec.file}`, phase: 'Author', schema: UNIT_SCHEMA }),
  (drafted, spec) => {
    if (!drafted) return null
    return agent(
      verifyPrompt(spec) + `\n\nHere is the unit to check:\n${JSON.stringify(drafted)}`,
      { label: `verify:${spec.file}`, phase: 'Verify', schema: UNIT_SCHEMA }
    ).then((fixed) => ({ file: spec.file, unit: fixed || drafted }))
  }
)

const built = results.filter(Boolean)
log(`Built ${built.length}/${UNIT_SPECS.length} units`)
return built
