export const meta = {
  name: 'invested-appstore-audit',
  description: 'Audit InvestEd for missing in-scope features + draft all App Store listing and legal copy',
  phases: [
    { title: 'Audit', detail: 'one agent per feature area finds gaps within existing features' },
    { title: 'Listing', detail: 'draft store listing, privacy policy, terms, and disclaimer copy' },
  ],
}

const OVERVIEW = `InvestEd is a Duolingo-style iOS app (SwiftUI + Firebase Auth/Firestore) that
teaches teens & beginners personal finance and investing. Existing features:
- LEARN: 12 units x 5 lessons x 7 questions + a 15-question "Knowledge Check" that gates the next unit;
  8 interactive question types; streaks, XP, levels, hearts (5 lives), Gold currency, achievements, a weekly league.
- MARKET: a simulated $10,000 portfolio; real quotes via Finnhub; buy/sell stocks; an Options Playground
  (calls/puts with Black-Scholes pricing); watchlist is currently a hardcoded list.
- FRIENDS: username search, friend requests, add-by-code (QR generate), a friends XP leaderboard.
- SHOP ("Moby's Market"): spend Gold on Streak Freezes and avatar gear; an "InvestEd Plus" $4.99/mo
  subscription is laid out but placeholder-only (ShopView.purchasesEnabled=false).
- PROFILE: custom avatar builder, stats, achievements, monthly badge, recent trades, friend QR code, Sign Out.
- CHAT: "Penny", an AI assistant (Cloudflare Worker proxy).
- ONBOARDING: welcome, email/password auth, an adaptive placement test.
The app repo is at /Users/eliasdweiri/InvestEd (source under InvestEd/). It is heading to the App Store.`

const AREAS = [
  { key: 'learn', title: 'Learn & gamification',
    hint: 'Files: InvestEd/Onboarding/Views/Main/LearnView.swift, ViewModels/LearnViewModel.swift, Models/LearningModels.swift, Models/AchievementModels.swift.' },
  { key: 'market', title: 'Market & simulated investing',
    hint: 'Files: InvestEd/Onboarding/Views/Main/MarketView.swift, ViewModels/MarketViewModel.swift, PortfolioViewModel.swift, Models/MarketModels.swift, Services/MarketDataService.swift.' },
  { key: 'social', title: 'Friends & social / leagues',
    hint: 'Files: InvestEd/Onboarding/Views/Main/FriendsView.swift, LeagueSection.swift, ViewModels/FriendsViewModel.swift, Models/SocialModels.swift.' },
  { key: 'economy', title: 'Shop, Gold economy & monetization',
    hint: 'Files: InvestEd/Onboarding/Views/Main/ShopView.swift, AvatarBuilderView.swift, Models/UserModels.swift (Gold/cents, unlockedItems).' },
  { key: 'profile', title: 'Profile, settings & account',
    hint: 'Files: InvestEd/Onboarding/Views/Main/ProfileView.swift, ViewModels/ProfileViewModel.swift, Services/AuthService.swift.' },
  { key: 'engagement', title: 'Retention: notifications, streaks, onboarding',
    hint: 'Files: InvestEd/Con-Mod-Ser-Uti-VMo/Services/NotificationService.swift, Onboarding/Views/Onboarding/*, ViewModels/OnboardingViewModel.swift.' },
]

const GAP_SCHEMA = {
  type: 'object',
  required: ['area', 'gaps'],
  properties: {
    area: { type: 'string' },
    gaps: {
      type: 'array',
      items: {
        type: 'object',
        required: ['title', 'why', 'value', 'effort', 'risk'],
        properties: {
          title: { type: 'string' },
          why: { type: 'string', description: 'why it belongs and helps users' },
          value: { type: 'string', enum: ['High', 'Medium', 'Low'] },
          effort: { type: 'string', enum: ['Small', 'Medium', 'Large'] },
          risk: { type: 'string', description: 'App Store / technical risk, or None' },
          hint: { type: 'string', description: 'one-line implementation hint' },
        },
        additionalProperties: true,
      },
    },
  },
  additionalProperties: true,
}

phase('Audit')
const audits = await parallel(AREAS.map((a) => () =>
  agent(
    `${OVERVIEW}\n\nYou are a senior product engineer auditing the "${a.title}" area of InvestEd. ${a.hint}\n` +
    `Read the relevant source files, then list the MISSING sub-features that clearly fit UNDER THIS EXISTING feature ` +
    `umbrella (natural completions/gaps — NOT brand-new pillars). For each: why it helps users, value (High/Medium/Low), ` +
    `effort (Small/Medium/Large), any App Store or technical risk, and a one-line implementation hint. ` +
    `Focus on things that make the app feel finished and worth publishing. Return 4-8 concrete gaps.`,
    { label: `audit:${a.key}`, phase: 'Audit', schema: GAP_SCHEMA, agentType: 'general-purpose' }
  )
))

phase('Listing')
const [listing, privacyPolicy, terms, disclaimer] = await parallel([
  () => agent(
    `${OVERVIEW}\n\nWrite the complete App Store listing copy for InvestEd, ready to paste into App Store Connect. Include: ` +
    `app name + subtitle (30 chars), a compelling promotional text (170 chars), a full description (with a hook, a bulleted ` +
    `feature list, and a short "why it's safe: simulated money, educational, not investment advice" note), 100 chars of ` +
    `keywords (comma-separated, no spaces), suggested primary/secondary category, a recommended age rating with rationale ` +
    `(consider it teaches options/crypto with a simulated portfolio), a "What's New" first-release note, and App Review notes ` +
    `(mention login is required — provide a placeholder demo account line — and that all trading is simulated). ` +
    `Also list the App Privacy "nutrition label" data types this app collects (email, username, usage/progress) and how they map. ` +
    `Return as clean Markdown.`,
    { label: 'listing', phase: 'Listing' }
  ),
  () => agent(
    `Write a clear, plain-English Privacy Policy for InvestEd, an educational personal-finance iOS app for teens & beginners ` +
    `(min age 13). It uses Firebase Authentication (email/password) and Cloud Firestore to store: email, username, learning ` +
    `progress, a SIMULATED (fake-money) portfolio, and friend connections. It uses Finnhub for real market quotes (no personal ` +
    `data sent). An AI assistant ("Penny") answers finance questions via a proxy server; chat text is sent to the AI provider. ` +
    `No ads, no third-party analytics/tracking SDKs, no selling of data. Users can delete their account in-app. Include ` +
    `sections: what we collect, how we use it, third parties (Google Firebase, Finnhub, the AI provider), data retention, ` +
    `account deletion, children's privacy (13+), security, and a contact placeholder [YOUR-EMAIL]. Return as Markdown with a ` +
    `[Last updated: DATE] placeholder.`,
    { label: 'privacy', phase: 'Listing' }
  ),
  () => agent(
    `Write plain-English Terms of Service for InvestEd, an educational iOS app with a SIMULATED (fake-money) investing ` +
    `portfolio. Emphasize: the app is for education only and is NOT financial, investment, or trading advice; all portfolios ` +
    `and trades are simulated with no real money or real securities; Gold is a virtual in-app currency with no cash value; ` +
    `optional paid features (a subscription and Gold packs) may exist via Apple in-app purchase; acceptable use; accounts & ` +
    `termination; disclaimers & limitation of liability; 13+ age requirement; contact placeholder [YOUR-EMAIL]. Return Markdown ` +
    `with a [Last updated: DATE] placeholder.`,
    { label: 'terms', phase: 'Listing' }
  ),
  () => agent(
    `Write a SHORT (60-90 word) in-app financial disclaimer suitable for a one-time onboarding screen in InvestEd. It must make ` +
    `clear: this is an educational app; the portfolio is simulated with fake money and no real trades happen; nothing in the ` +
    `app (including the AI assistant "Penny") is financial or investment advice; and users should do their own research or ` +
    `consult a licensed professional before real investing. Warm, encouraging, teen-friendly tone. Return just the disclaimer text.`,
    { label: 'disclaimer', phase: 'Listing' }
  ),
])

return {
  audits: audits.filter(Boolean),
  listing: listing || '',
  privacyPolicy: privacyPolicy || '',
  terms: terms || '',
  disclaimer: disclaimer || '',
}
