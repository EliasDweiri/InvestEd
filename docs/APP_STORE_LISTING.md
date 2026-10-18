# InvestEd — App Store Listing (draft)

_Paste-ready copy for App Store Connect. Replace bracketed placeholders before submitting._

I have what I need. Here is the complete, paste-ready App Store listing copy.

---

# InvestEd — App Store Connect Listing Copy

## App Name (≤30 chars)
**`InvestEd: Money & Investing`**  *(27/30)*

Alternates if the exact name is taken:
- `InvestEd: Learn to Invest` *(25)*
- `InvestEd — Invest & Learn` *(25)*

## Subtitle (≤30 chars)
**`Learn to invest, risk-free`**  *(26/30)*

Alternates:
- `Finance lessons + stock sim` *(27)*
- `Money skills for beginners` *(26)*

---

## Promotional Text (≤170 chars)
> Master money the fun way. Trade a $10,000 practice portfolio, level up through bite-size lessons, and compete with friends — all risk-free, no real money involved.

*(162/170 — this field can be updated anytime without a new build; good for seasonal or feature callouts.)*

---

## Description

**Investing shouldn't be scary — or expensive to learn.**

InvestEd turns personal finance into a game you'll actually want to play. Level up through bite-size lessons, put your skills to work in a realistic market simulator, and build real money confidence — without risking a single real dollar. Whether you're a teen getting your first taste of the stock market or a total beginner who's always felt locked out, InvestEd meets you where you are and takes you from "what's a stock?" to building and managing a portfolio.

Every lesson is quick, interactive, and rewarding. Earn XP, keep your streak alive, climb the weekly league, and unlock achievements as concepts finally click.

**What you'll get:**

- **📚 Learn by doing** — 12 units of finance and investing built from bite-size lessons and 8 interactive question types, with a Knowledge Check to unlock each new unit.
- **📈 Practice market** — start with a simulated $10,000 and buy or sell stocks using real, live quotes. Make mistakes here, not with your paychecks.
- **⚙️ Options Playground** — explore calls and puts with realistic pricing in a safe, simulated sandbox.
- **🔥 Streaks, XP & levels** — stay motivated with daily streaks, hearts, Gold currency, and achievements.
- **🏆 Weekly league** — climb the leaderboard and keep the momentum going.
- **👋 Learn with friends** — add friends by username or QR code and compare progress on a friendly XP leaderboard.
- **💬 Meet Penny** — your friendly AI helper for quick, plain-English answers to money questions.
- **🎨 Make it yours** — build a custom avatar and track your stats, badges, and progress.

**Why InvestEd is safe:**
All trading and portfolios in InvestEd are **100% simulated** — no real money is ever bought, sold, deposited, or withdrawn. InvestEd is an **educational tool**, not a brokerage, and nothing in the app is **personalized investment, financial, or trading advice**. It's a place to build knowledge and confidence before you ever touch a real dollar.

Start your streak today — your future self will thank you.

---

## Keywords (≤100 chars, comma-separated, no spaces)
```
stocks,finance,budget,options,crypto,portfolio,teen,beginner,trading,market,savings,lessons,etf,401k
```
*(100/100. Intentionally avoids words already in the app name/subtitle — "invest," "investing," "money," "learn" — since Apple already indexes those, so the keyword field isn't wasted repeating them.)*

---

## Categories
- **Primary:** Education
- **Secondary:** Finance

*(Rationale: the core loop is a structured learning curriculum with lessons, XP, and gated units — Education is the strongest fit and a friendlier competitive field than Finance. Finance as secondary captures market/investing intent searches.)*

---

## Age Rating — Recommended: **12+** (legacy) / **13+** (Apple's 2026 age-rating system)

**Rationale:** The app is purely educational and contains no real-money transactions, wagering, or gambling mechanics — the portfolio and all trades are simulated. However, it teaches and simulates **higher-risk instruments (options and crypto)** and includes an **AI chat assistant** and **user-to-user social features** (friend search, leaderboards). That combination makes an all-ages "4+" rating a poor fit and is best served by a **12+/13+** rating, which aligns with the teen-and-up target audience.

**Suggested answers to the App Store age-rating questionnaire:**
- Simulated Gambling: **None** — stock/options simulation is skill-and-education based, not casino/wagering gambling. (If App Review flags the options simulator under this heading, be ready to explain in Review Notes that there are no wagers, odds, or payouts; if required to select a level, choose the lowest.)
- Medical/Treatment Info, Violence, Sexual Content, Profanity, Horror, Alcohol/Drugs: **None**
- Unrestricted Web Access: **No**
- Contests: **No**
- Age Assurance: standard; no age-restricted real-money financial activity occurs in-app.

---

## What's New (first-release version note)
> Welcome to InvestEd 1.0! 🎉
>
> Start your money journey with:
> • 12 units of bite-size finance & investing lessons
> • A simulated $10,000 portfolio with real, live stock quotes
> • An Options Playground to explore calls and puts, risk-free
> • Streaks, XP, levels, achievements, and a weekly league
> • Friends, leaderboards, and Penny, your AI money helper
>
> This is just the beginning — more lessons and features are on the way. Keep your streak alive!

---

## App Review Notes
```
LOGIN REQUIRED
This app requires an account (email/password via Firebase Auth) to access all
features. Please use the demo account below:

  Email:    demo@invested.app        [REPLACE with a real test account before submitting]
  Password: InvestEdDemo1!            [REPLACE with the real password]

The demo account is pre-seeded with progress so reviewers can immediately see
lessons, the market simulator, friends, and profile features.

ALL TRADING IS SIMULATED
- No real money is ever involved. The $10,000 portfolio, all stock buy/sell
  actions, and the Options Playground are 100% simulated for education.
- The app is NOT a brokerage and executes no real trades or fund transfers.
- Real, delayed/live stock QUOTES are fetched from Finnhub (finnhub.io) for
  realism, but orders never touch a real market or account.
- InvestEd provides general financial education only — no personalized
  investment advice. In-app disclaimers state this (e.g., the Options
  Playground labels pricing as "for learning, not investment advice").

AI CHAT ("Penny")
- Penny answers general money questions via a Cloudflare Worker proxy. It does
  not give personalized or actionable trading recommendations.

IN-APP PURCHASES
- The "InvestEd Plus" subscription is laid out but DISABLED in this build
  (no real-money purchase can be completed). No StoreKit products are active
  in v1.0. In-app "Gold" is an earned virtual currency, not purchasable.

Thank you for reviewing InvestEd!
```

*(Action item before submission: replace the demo credentials above with a working test account, since login is required and Apple will reject a build they can't get past.)*

---

## App Privacy — "Nutrition Label" Data Types

Based on what the app collects (Firebase Auth email; Firestore username + learning/market progress), declare the following. All items are **collected**, **linked to the user's identity**, and **NOT used for tracking** (no third-party ad/data-broker sharing).

| App Privacy Category | Data Type | What it maps to in InvestEd | Purpose | Linked to user? | Used for tracking? |
|---|---|---|---|---|---|
| **Contact Info** | Email Address | Sign-up / sign-in email (Firebase Auth) | App Functionality (account, authentication) | Yes | No |
| **Identifiers** | User ID | Username + Firebase account/UID used for friends, requests, QR add-by-code, and leaderboards | App Functionality | Yes | No |
| **Usage Data** | Product Interaction | Lesson/unit progress, XP, level, streaks, hearts, Gold, achievements, and simulated portfolio/trade activity stored in Firestore | App Functionality | Yes | No |

**Notes for the App Privacy questionnaire:**
- **Data used to track you:** None.
- **Data linked to you:** Email Address, User ID, Product Interaction (all three above).
- **Data not linked to you:** None declared.
- If you later add crash reporting or analytics SDKs (e.g., Firebase Crashlytics/Analytics), you must add **Diagnostics → Crash Data / Performance Data** and possibly **Identifiers → Device ID**; the current declaration assumes those are not enabled.
- Third-party processors in this data flow: **Google Firebase** (Auth + Firestore) stores email, username, and progress; **Finnhub** receives stock symbols for quotes (no personal user data sent); the **Cloudflare Worker** proxies chat messages. Confirm each processor's data handling is reflected accurately before publishing.

---

**Source references used (for your verification):** simulated-portfolio starting balance and disclaimer copy in `/Users/eliasdweiri/InvestEd/InvestEd/Con-Mod-Ser-Uti-VMo/Utilities/Constants.swift` and `/Users/eliasdweiri/InvestEd/InvestEd/Onboarding/Views/Main/MarketView.swift`; disabled-subscription state in `/Users/eliasdweiri/InvestEd/InvestEd/Onboarding/Views/Main/ShopView.swift`.