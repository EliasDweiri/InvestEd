# InvestEd — Improvement Suggestions

Grounded in a full read of the current codebase (July 2026). Ordered by impact
vs. effort. The 🔴 items are the ones I'd do next.

## 🔴 High impact

1. **Move the Finnhub API key off the device.** `Constants.finnhubAPIKey` is
   compiled into the app binary, so anyone can extract it and burn your quota
   (or rack up charges). You already have the pattern to fix it: proxy quotes
   through a Cloudflare Worker exactly like the chat proxy, and cache responses
   (Finnhub free tier is ~60 calls/min and `fetchQuotes` calls them in a serial
   loop, which is slow and rate-limit-prone).

2. **Add unit tests for the logic that now carries real weight.** There are
   ~600 questions and a gating engine but essentially no tests. Highest-leverage
   targets: `Question.isCorrect` (all 8 types), `LearnViewModel` gating +
   streak, `PortfolioViewModel` buy/sell/option math, `OptionPricer`. A CI step
   that runs `python3 tools/gen_content.py` + `xcodebuild build` would catch
   content and compile breakage before it ships.

3. **Spaced repetition / "mistakes" review.** Questions a learner misses should
   resurface in a review queue a day or two later. This is the single biggest
   retention lever for a learning app and fits the existing lesson engine.

4. **Lock down Firestore rules.** The whole `AppUser` doc (progress + portfolio
   + transactions) is one document. Confirm rules restrict each user to their
   own doc and expose only the minimum of friends' data. Also: `transactions`
   grows unbounded inside the user doc — consider a subcollection before it
   bloats reads.

## 🟡 Medium impact

5. **Real portfolio history.** Charts are simulated (`withGeneratedHistoryIfNeeded`)
   because the free Finnhub tier lacks candles. Snapshot each user's net worth
   daily (a tiny Firestore write) so the portfolio value chart becomes real.

6. **Real leagues & leaderboards.** Leagues currently show bots
   (`SampleData.leagueBots`). A Firestore query ordered by `weeklyXP` (with the
   week anchor you already store) turns this into a real competitive loop.

7. **Wire up notifications.** `NotificationService` exists but streak-reminder /
   "come back" local notifications aren't scheduled. Streak reminders are proven
   retention drivers and you already track `lastLessonDate`.

8. **Surface achievements.** `AchievementModels` exists with no screen. A badge
   wall tied to milestones (first perfect Knowledge Check, 7-day streak, first
   option trade) gives long-term goals.

9. **Hearts economy.** Hearts reset per lesson today, so the "5 lives" have no
   lasting stakes across a session. Consider a shared/regenerating hearts pool
   (refill with Gold or over time) — it makes lives meaningful and gives Gold a
   real sink.

## 🟢 Polish & code health

10. **Accessibility.** Add accessibility identifiers/labels (also makes UI tests
    reliable — their absence made verification harder), verify Dynamic Type
    scaling on the fixed-size fonts, and check contrast of the interactive
    question chips in dark mode.

11. **De-duplicate the options UI.** `OptionsPlaygroundSheet` (Market tab) and
    the new `InteractiveOptionAnswerView` (lessons) share a lot — extract a
    common builder component.

12. **Vary option volatility by symbol.** `OptionPricer` uses a fixed 30% vol;
    a per-symbol table would make premiums feel more real.

13. **Rename the `Con-Mod-Ser-Uti-VMo` group** to conventional folders, and
    consider `@Observable` / dependency injection instead of the global
    `AppState.shared` singleton (helps testing).

## New content architecture (already in place)

- Content is authored as JSON in `content_src/units/` and generated to Swift by
  `tools/gen_content.py` — never edit `LessonContentData.swift` by hand.
- Each unit's **Knowledge Check** is auto-assembled (15 Q sampled from the 5
  lessons), so it always covers the whole unit and always reuses vetted
  questions. Adding a lesson question automatically enriches the check.
- Next content step: run the fact-check pass on Units 3–11 (their verify agents
  hit a session limit during the first bulk run; numeric + options questions
  were already spot-checked and are correct).
