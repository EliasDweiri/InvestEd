# InvestEd — Feature Gaps & Next Features

In-scope features that would round out the *existing* app (from a per-area audit). Grouped by area; within each, High value first. These are on top of the App Store compliance work already implemented.


## Learn & Gamification

### Achievement unlock celebration (detect + toast at the moment earned)  
**Value:** High · **Effort:** Small · **Risk:** None — all data is already local/computed.  
A full Achievement.all catalog exists but is only shown as a static grid in ProfileView; users cross thresholds like Bookworm (10 lessons) or Week Warrior (7-day streak) with zero acknowledgement. Surfacing the unlock the instant it happens is the single highest-leverage dopamine hit for a Duolingo-style app and makes the existing system feel intentional rather than hidden.  
*Implementation:* In LearnViewModel.complete(), snapshot Achievement.all.filter{isUnlocked(oldUser)} before saving vs. after, publish the newly-unlocked ones, and show a card/toast overlay in LessonPlayerView.completionView.

### Level-up celebration on the completion screen  
**Value:** High · **Effort:** Small · **Risk:** None.  
AppUser.level is xp/100+1 and addXP() just increments; the completion view shows +XP/+Gold but never notices when that XP pushes the user to a new level. A 'Level 5!' moment is a core progression reward that's currently invisible even though the level is already displayed in the stats chip.  
*Implementation:* Capture user.level before addXP() in complete(), compare after; add a leveledUpTo @Published and render a badge in completionView alongside the XP/Gold pills.

### Auto-scroll the path to the current lesson on open  
**Value:** High · **Effort:** Small · **Risk:** None.  
LearnView's ScrollView has no ScrollViewReader, so a returning user always lands at Unit 1's top and must scroll past every completed unit (up to 12) to find their pulsing 'current' node. This is the most-used screen; landing on the actionable node makes the app feel finished and respects the returning-user's time.  
*Implementation:* Wrap the units ForEach in a ScrollViewReader, tag each PathNodeView/FinalTestNodeView with .id(lesson.id), and proxy.scrollTo(currentNodeID, anchor:.center) in .onAppear — the exact pattern already used in ChatView.

### Review-Mistakes practice mode  
**Value:** Medium · **Effort:** Medium · **Risk:** None; adds one array field to the user doc (Firestore-backward-compatible as Optional).  
Nothing records which questions a learner missed, and there's no way to re-drill weak spots — replaying a gold node just re-runs the whole lesson. A targeted 'Practice your mistakes' set is a hallmark completion of this genre, reinforces retention, and gives a reason to earn XP after all lessons are done.  
*Implementation:* Collect question IDs in LearnViewModel.submit() when !correct into a persisted [String] on AppUser, then add a 'Review Mistakes' entry that builds an ad-hoc Lesson from those Questions and clears them on a correct pass.

### Daily XP goal with a progress ring  
**Value:** Medium · **Effort:** Medium · **Risk:** None.  
The app has a streak and a monthly badge but no daily goal — the very loop the streak depends on. A small configurable daily XP target (e.g. 30 XP) with a ring in the stats header gives users a concrete 'done for today' signal and a second celebratory beat each day, tightening the habit loop that drives retention.  
*Implementation:* Add dailyXPGoal + today's-XP tracking (reset when lastLessonDate isn't today) to AppUser, render a ring in LearnView.statsHeader, and fire a small celebration when the goal is first hit in complete().

### Refill hearts / preserve progress instead of a hard restart on fail  
**Value:** Medium · **Effort:** Small · **Risk:** Low — use the earned soft currency (Gold via spendGold), NOT real money or an IAP-for-lives, to stay clear of App Store 3.1.1 pay-to-continue scrutiny in a teen app.  
Out of hearts calls retry() which resets to question 0, discarding every correct answer — brutal on the 15-question Knowledge Check and a common rage-quit point. Offering a Gold-funded refill that resumes at the current question (there's already a Gold economy and streak-freeze precedent) keeps momentum and gives Gold a meaningful sink.  
*Implementation:* In LessonPlayerView.failView, add a 'Refill 5 hearts for N Gold' button that calls user.spendGold, resets hearts, and resumes at currentQuestionIndex rather than calling retry().

### Reduce Motion + VoiceOver support on the learning path  
**Value:** Medium · **Effort:** Small · **Risk:** Accessibility is an App Store quality expectation (not usually a hard rejection, but flagged in review) — worth closing before submission.  
The current/final-test nodes pulse with repeatForever animations and the custom Circle/RoundedRectangle buttons and StatChips carry no accessibility labels or traits. For a to-be-published consumer app, respecting Reduce Motion and VoiceOver is a baseline quality expectation reviewers and users notice, and it's cheap to add.  
*Implementation:* Gate the pulsing withAnimation behind @Environment(\.accessibilityReduceMotion) and add .accessibilityLabel/.accessibilityAddTraits(.isButton) with lock/completed state to PathNodeView, FinalTestNodeView, and StatChip.


## Market & simulated investing

### Live pricing for every held/searched symbol (accurate portfolio valuation)  
**Value:** High · **Effort:** Medium · **Risk:** Finnhub free tier is ~60 calls/min and fetchQuotes loops one-by-one; fetching many held symbols each refresh can hit limits. Batch and cache quotes.  
Users can buy ANY ticker via search, but MarketViewModel.loadWatchlist only fetches the 8 hardcoded watchlist symbols + 4 index proxies. Any holding or option on an off-watchlist symbol has no live quote, so PortfolioViewModel falls back to averageCost/premiumPaid — its gain never moves and the headline Portfolio Value is silently wrong. This breaks the core promise of a live simulator for exactly the stocks a motivated user seeks out.  
*Implementation:* Union Constants.watchlistSymbols with currentUser.holdings + optionPositions symbols, fetch all, and expose a [symbol: Stock] price map that PortfolioViewModel uses instead of only marketVM.stocks.

### Personal, persisted watchlist (add/remove from search)  
**Value:** High · **Effort:** Medium · **Risk:** None — fake-money sim, no App Store concern.  
The watchlist is a hardcoded array (flagged in the project brief). Searching a ticker opens its detail page but there is no way to save it — nothing the user does personalizes the Market tab. A user-owned watchlist with a star toggle makes the tab sticky and personal.  
*Implementation:* Add watchlistSymbols: [String]? to AppUser (persist via FirestoreService), add a star button on StockDetailView, and drive popularSection from it with Constants.watchlistSymbols as the default seed.

### Total return badge on the Portfolio card (gain/loss vs $10k start)  
**Value:** High · **Effort:** Small · **Risk:** None.  
The Portfolio Value card shows a dollar figure but never whether the user is up or down. Total return in $ and % against the $10,000 starting balance is the single most motivating number in any investing app, and it is currently absent — the sim gives no sense of winning or losing.  
*Implementation:* return = totalPortfolioValue - Constants.startingCashBalance; render a green/red delta + percent under the value with .contentTransition(.numericText()).

### Auto-refreshing quotes with a 'prices as of' timestamp  
**Value:** Medium · **Effort:** Medium · **Risk:** API rate limits and battery drain — use a 15-30s timer, pause when backgrounded, and reuse the batched-quote path.  
Quotes update only on initial load and manual pull-to-refresh, so within a session holdings and options P&L are frozen and the screen feels dead. A periodic refresh while foregrounded, plus an 'as of HH:mm' label, makes the simulator feel live and trustworthy.  
*Implementation:* Start a repeating Task/Timer in MarketViewModel that re-runs loadWatchlist on an interval and stores lastUpdated: Date; cancel on disappear.

### Full transaction history / trade blotter in the Market tab  
**Value:** Medium · **Effort:** Small · **Risk:** None.  
Every buy, sell, and option trade is recorded in user.transactions, but the Market tab surfaces none of it (only Profile shows a few recent trades). A scrollable history — date, symbol, buy/sell, shares, price, total — gives the paper-trading sim the audit trail users expect and reinforces cause-and-effect learning.  
*Implementation:* Add a 'History' NavigationLink to a List over user.transactions with type-colored rows; data already exists, purely a view.

### Stock detail: company profile (sector, market cap, logo) + recent news  
**Value:** Medium · **Effort:** Medium · **Risk:** Headlines are third-party external content — low risk; keep read-only, attributed, no in-app links to unvetted sites.  
The detail page fetches Finnhub's profile but uses only the company name; sector, industry, market cap and logo are already in that same endpoint, and free-tier company-news adds headlines. An 'About' card plus a few recent headlines turns a bare price screen into the educational context this teaching app is about.  
*Implementation:* Extend FinnhubProfile (finnhubIndustry, marketCapitalization, logo) and call /company-news; render an About card + top 3 headlines on StockDetailView.

### Portfolio allocation / diversification donut  
**Value:** Medium · **Effort:** Small · **Risk:** None.  
Diversification is a core lesson of the app, yet the portfolio is shown only as flat cash/stocks/options totals. A donut of cash vs each holding's weight visually teaches concentration risk and ties the Market tab back to the Learn curriculum.  
*Implementation:* SwiftUI Charts SectorMark over [cash + each holding's market value]; drop it under portfolioCard, reusing the same price map.

### Realized gain/loss on sells (and a lifetime realized total)  
**Value:** Medium · **Effort:** Small · **Risk:** None.  
Selling records a transaction but discards whether the trade actually made or lost money — the app's biggest teaching moment slips by. Showing 'You realized +$X (Y%)' on each sale and a running realized total closes the learning loop between buying, holding, and selling.  
*Implementation:* On sell(), compute (price - averageCost) * shares; surface it in the confirmation string and accumulate onto a realizedPL: Double? field on AppUser.


## Friends & social / leagues

### Block & report users (UGC safety)  
**Value:** High · **Effort:** Medium · **Risk:** App Store Guideline 1.2 requires reporting/blocking for social/UGC apps; shipping without it risks rejection. This gap REMOVES that risk.  
Usernames and avatars are user-generated content shown to other users, and the app targets teens. There is no way to block or report an abusive or inappropriate friend/username anywhere in the app. Apple requires a report+block mechanism for any app with UGC or social interaction, so this is a likely rejection blocker, not just a nicety.  
*Implementation:* Add a blockedUserIDs field on AppUser + a 'reports' Firestore collection; filter blocked IDs out of friends/league/search and add a context menu 'Block'/'Report' on each friend and league row.

### Remove / unfriend a friend  
**Value:** High · **Effort:** Small · **Risk:** None (must also remove the reverse edge — see two-way fix below).  
Once a request is accepted there is no way to remove a friend — friendsSection and the league only ever grow. Users expect to prune their list, and it pairs with blocking. Its absence makes the tab feel unfinished.  
*Implementation:* Add FirestoreService.removeFriend(myID:otherID:) that deletes each ID from the other's friendIDs, exposed via swipe action or long-press menu on the friend row in FriendsView.swift.

### Make accepting a request two-way (reciprocity fix)  
**Value:** High · **Effort:** Medium · **Risk:** Client-only writes to another user's doc need permissive Firestore rules; safest via a small Cloud Function or a batched/transaction write. Correctness bug.  
In FriendsViewModel.respond(to:accept:) only the accepter appends fromUserID to their own friendIDs and saves themselves; the original sender never gets the accepter added, so the sender never sees the new friend or their XP in the league. Half of every new friendship is silently broken today.  
*Implementation:* On accept, write both edges (transaction or arrayUnion on both user docs), ideally in an onUpdate Cloud Function triggered when a friendRequest flips to accepted.

### Weekly league results: promotion / relegation + reward payout  
**Value:** High · **Effort:** Large · **Risk:** Needs a reliable weekly rollover (server-side cron/Cloud Function) so results fire even when the app is closed; App Store note: rewards must be XP/Gold, not real money.  
LeagueTier is computed only from the user's own currentWeeklyXP against fixed thresholds — it is a solo progress bar, not a competitive cohort. There is no end-of-week resolution, no top-3 promotion / bottom demotion versus the friends shown in standings, and no Gold/XP reward or results screen when the week resets. This is the core Duolingo-style promise and the biggest 'feels finished' gap for the tab.  
*Implementation:* On week rollover compute each user's rank within their friend cohort, pay Gold/XP for a top finish, store last-week result, and show a one-time 'League Results' celebration sheet on next open.

### Tappable friend / leaderboard profile detail  
**Value:** Medium · **Effort:** Medium · **Risk:** None — only expose already-public FriendProfile fields; never email/cash balance (model already scopes this).  
Every friend and league row is inert — tapping does nothing. Users naturally tap a leaderboard entry to see who they're competing with (avatar, level, streak, achievements, badge). It rewards the social loop and gives the FriendProfile data a home.  
*Implementation:* Add a FriendDetailView and wrap rows in FriendsView.swift / LeagueSection.swift in NavigationLink; reuse MascotBubble and the public stats already in FriendProfile.

### Duplicate-request guard + outgoing/pending request visibility  
**Value:** Medium · **Effort:** Medium · **Risk:** None.  
sendFriendRequest creates a fresh UUID doc every tap with no dedupe: the search result shows 'Add' even for people who are already friends or already have a pending request, so users can spam duplicates and can't see or cancel requests they've sent. Makes the flow feel buggy.  
*Implementation:* Before sending, check friendIDs and existing pending friendRequests; show 'Friends'/'Requested' states in the search result, and add an outgoing-requests list with a cancel button.

### In-app QR scanner to add by code  
**Value:** Medium · **Effort:** Medium · **Risk:** Requires camera access; Info.plist currently has no NSCameraUsageDescription — must add a purpose string or the app crashes/rejects on camera use.  
Profile generates a friend QR (invested:add:<id>) and addFriend already parses that payload, but there is no scanner — a friend can only add you by copying a raw code to the clipboard, defeating the point of the QR. The scan half of the QR feature is missing.  
*Implementation:* Add an AVCaptureMetadataOutput QR scanner sheet from the search card that feeds the scanned string into viewModel.addFriend(byCode:); add NSCameraUsageDescription.

### Pull-to-refresh & live-updating friends / standings  
**Value:** Low · **Effort:** Small · **Risk:** Firestore listeners on many friends add reads/cost; a simple .refreshable pull is the cheap first step.  
loadFriends() runs once on appear, so friends' XP, streak and weekly standings go stale within a session and the league order stops moving. A refreshable, or listener-backed, list keeps the leaderboard feeling live and competitive.  
*Implementation:* Wrap the ScrollView in .refreshable { viewModel.loadFriends() } in FriendsView.swift, and optionally re-fetch when the tab re-appears.


## Shop, Gold economy & monetization

### Actually wire InvestEd Plus to StoreKit 2  
**Value:** High · **Effort:** Large · **Risk:** App Store: subscriptions require an App Store Connect product, a StoreKit config, working purchase + Transaction.updates listener, and a privacy/paid-app agreement; a non-functional or crashing purchase flow is a guaranteed rejection.  
The whole subscription card is built but purchasesEnabled is hardcoded false and there is zero StoreKit code — the app's only real-money revenue path is a dead button, so the product ships with no monetization despite advertising a $4.99/mo tier.  
*Implementation:* Add a StoreKitManager (Product.products / product.purchase() / Transaction.currentEntitlements) plus a .storekit test file, then flip ShopView.purchasesEnabled and bind the Subscribe button to it.

### Add a Plus entitlement flag and actually deliver the 4 advertised perks  
**Value:** High · **Effort:** Medium · **Risk:** App Store: advertising features you do not deliver is a metadata/misleading rejection under Guideline 2.3; also a refund/trust problem with real teens paying.  
AppUser has no isPlus/expiry field and nothing in the codebase gates the four benefits the card promises (unlimited hearts, weekly free freeze, advanced sim stats, exclusive gear). Even with StoreKit wired, subscribers would pay and receive nothing.  
*Implementation:* Add plusExpiry: Date? to AppUser (optional for Firestore back-compat) and gate hearts in LearnViewModel, the weekly freeze grant, MarketView stats, and AvatarConfig gear on a computed isPlus.

### Spend Gold to refill hearts / continue a failed lesson  
**Value:** High · **Effort:** Medium · **Risk:** None (Gold is earned, not purchased, so no real-money/IAP implications).  
Gold has only two sinks today (freeze + gear) and the out-of-hearts screen only offers a full restart. A 'Refill hearts for Gold' option gives Gold a meaningful, repeatable sink, reduces rage-quits, and mirrors the genre's core loop — making the currency feel valuable.  
*Implementation:* In LearnView.failView add a goldButton that calls user.spendGold(price) and resets viewModel.hearts to continue in place instead of viewModel.retry().

### Restore Purchases control  
**Value:** Medium · **Effort:** Small · **Risk:** App Store: Guideline 3.1.1 explicitly requires a Restore button for non-consumable/subscription IAP — its absence is a near-certain rejection.  
There is no restore path anywhere. Any user who reinstalls or switches devices cannot recover their subscription, and Apple mandates a restore mechanism for auto-renewing subscriptions.  
*Implementation:* Add a 'Restore Purchases' row under the Plus card that calls AppStore.sync() and refreshes entitlement from Transaction.currentEntitlements.

### Expand the Power-Ups shelf beyond a single item  
**Value:** Medium · **Effort:** Medium · **Risk:** None; keep all new power-ups Gold-priced (not real money) to avoid IAP scope.  
The Power-Ups section contains exactly one product (Streak Freeze), so the Shop looks thin and unfinished. Adding an XP Boost (double XP next lesson), Streak Repair (restore a broken streak), or a Heart Refill pack deepens the economy and gives daily earners something to chase.  
*Implementation:* Refactor power-ups into a data-driven [PowerUp] list rendered in a loop, and apply each effect via new flags on AppUser / LearnViewModel.

### Premium avatar backdrops to fulfill the 'exclusive backdrops' Plus perk  
**Value:** Medium · **Effort:** Small · **Risk:** Low; if any backdrop is Plus-only it ties into the same 2.3 metadata concern, so gate it on the entitlement flag.  
The Plus card promises 'exclusive avatar backdrops', but all 8 entries in AvatarConfig.backgroundOptions are free and none appear in itemPrices — so the advertised perk does not exist and backdrops are a wasted Gold/Plus sink.  
*Implementation:* Add a few premium hex backdrops with Gold prices (or Plus-gating) and enforce owns() in the AvatarBuilder 'Backdrop' grid the way hats/accessories already are.

### Gold transaction ledger (earn & spend history)  
**Value:** Medium · **Effort:** Small · **Risk:** None.  
Stock trades are recorded in transactions, but Gold changes leave no trail — users can't see why their balance moved, which erodes trust in the currency once they start spending real effort earning it.  
*Implementation:* Append a lightweight GoldEntry (amount, reason, date) inside earnGold/spendGold and surface a scrollable list in the Shop header or Profile.

### Confirmation dialog for Gold spends  
**Value:** Low · **Effort:** Small · **Risk:** None.  
buyGear and buyStreakFreeze deduct Gold instantly on a single tap with no undo, so a mis-tap permanently burns up to 150 Gold (10+ lessons of effort) on the wrong item.  
*Implementation:* Wrap the pricier gear/freeze purchases in a confirmationDialog that shows item, price, and resulting balance before calling spendGold.


## Profile, settings & account

### In-app "Delete Account" flow  
**Value:** High · **Effort:** Medium · **Risk:** App Store Guideline 5.1.1(v) HARD REQUIREMENT — apps with account creation are rejected without in-app deletion. Adding it removes a guaranteed-rejection risk.  
Users need to permanently remove their account and data; App Store review requires it for any app that supports account creation. AuthService has signUp/signIn/signOut but no delete path.  
*Implementation:* Add AuthService.deleteAccount(): reauthenticate (recent-login required), Auth.auth().currentUser?.delete(), then FirestoreService delete of the user doc; gate behind a destructive confirmation alert in a Settings screen.

### Password recovery & change password  
**Value:** High · **Effort:** Small · **Risk:** None. Standard account hygiene reviewers expect.  
Email/password is the primary auth but there is no 'Forgot password?' or 'Change password' anywhere, so a locked-out user is stranded. Firebase makes this trivial.  
*Implementation:* Wrap Auth.auth().sendPasswordReset(withEmail:) in AuthService; add a 'Forgot password?' link on AuthView and a 'Change password' row in settings that fires the reset email.

### Legal & About section (Privacy Policy, Terms, version, support)  
**Value:** High · **Effort:** Small · **Risk:** App Store requires an accessible privacy policy link; kids/teen audience (Guideline 5.1.2 / App Privacy) raises scrutiny. Absence is a common rejection.  
No privacy-policy or terms link exists in-app, and there's no app version, build, or support contact. A teen-targeted app with accounts must surface these.  
*Implementation:* Static rows using Link/openURL to a hosted policy & terms, a mailto: support row, and Bundle.main CFBundleShortVersionString/version for 'Version 1.0 (build N)'.

### A real Settings screen (gear entry point)  
**Value:** Medium · **Effort:** Medium · **Risk:** None.  
There is no settings surface at all — the profile toolbar only has the QR button, and Sign Out is a loose button in the scroll. Account, notification, legal, and privacy controls have nowhere to live.  
*Implementation:* Add a gear ToolbarItem on ProfileView opening a grouped SettingsView (List with sections) that hosts the account, notifications, legal, and sign-out/delete rows below.

### Editable username / display name  
**Value:** Medium · **Effort:** Medium · **Risk:** Username-uniqueness collisions and case-sensitivity must be handled to avoid duplicate handles.  
Username is captured once at onboarding and can never be changed; users outgrow a handle or make a typo and are stuck with it forever, and it's shown to friends everywhere.  
*Implementation:* Edit sheet from the header; reuse FirestoreService.findUser(byUsername:) to enforce uniqueness before saving the updated AppUser.

### Notification preferences (toggle + reminder time)  
**Value:** Medium · **Effort:** Medium · **Risk:** Low. Also improves alignment with App Store expectation that users can manage notifications.  
The daily streak reminder is hardcoded to 18:30 with no way to turn it off or reschedule, and friend-request pings can't be silenced. This is exactly what users expect to control.  
*Implementation:* Persist prefs via @AppStorage, pass hour/minute into scheduleDailyStreakReminder, respect an on/off toggle, and add an 'Open iOS Settings' link when authorization is denied.

### Restore Purchases & Manage Subscription  
**Value:** Medium · **Effort:** Small · **Risk:** App Store requires a Restore mechanism for subscriptions/non-consumables (Guideline 3.1.1); shipping paid tiers without it triggers rejection.  
The 'InvestEd Plus' auto-renewable subscription is laid out but has no Restore Purchases control or subscription-management link — required for anyone who reinstalls or switches devices once purchases go live.  
*Implementation:* Settings rows calling StoreKit AppStore.showManageSubscriptions(in:) and a restore-purchases action; wire to the existing ShopView.purchasesEnabled flag.

### Sign-out confirmation  
**Value:** Low · **Effort:** Small · **Risk:** None.  
viewModel.signOut() fires instantly from a tappable button in the scroll, so an accidental tap logs the user out with no undo.  
*Implementation:* Wrap the Sign Out action in a .confirmationDialog/.alert before calling viewModel.signOut().


## Retention: notifications, streaks, onboarding

### Notification permission priming step in onboarding  
**Value:** High · **Effort:** Medium · **Risk:** None. Standard soft-ask pattern; keep the system prompt user-initiated so a decline doesn't burn the one-time OS dialog.  
Permission is currently cold-requested at MainTabView.onAppear with zero context (NotificationService.swift:13, MainTabView.swift:44). A soft-ask screen during onboarding — explaining that a nightly nudge is what keeps the streak alive — before triggering the iOS prompt dramatically raises opt-in, and opted-in users are the ones who come back. Since streaks are the app's core retention loop, losing the notification grant on the very first launch quietly kills retention.  
*Implementation:* Add a priming view after PlacementResultView (or a step in PlacementTestFlowView) with an 'Enable reminders' button that calls scheduleDailyStreakReminder(); stop calling it blindly in MainTabView.onAppear.

### Foreground presentation + tap handling via UNUserNotificationCenterDelegate  
**Value:** High · **Effort:** Small · **Risk:** None.  
There is no notification delegate anywhere (AppDelegate in InvestEdApp.swift only configures Firebase). Friend-request notifications from notifyFriendRequest (FriendsViewModel.swift:26) are silently dropped whenever the app is open, and tapping any notification just opens the app to wherever it was — the streak reminder doesn't land on Learn, the friend request doesn't land on Friends. This makes the notifications feel broken/half-wired.  
*Implementation:* Make AppDelegate conform to UNUserNotificationCenterDelegate, set center.delegate in didFinishLaunching, implement willPresent (return .banner/.sound) and didReceive to route to the right tab via a shared selection/AppState.

### Stop nagging once the streak is already safe  
**Value:** High · **Effort:** Small · **Risk:** None.  
scheduleDailyStreakReminder installs a single 18:30 repeating trigger that fires unconditionally (NotificationService.swift:23-29). A diligent user who did a lesson at 8am still gets 'Penny misses you! Don't let the flame go out' at 6:30pm — a factually wrong, mildly insulting nudge that is a leading cause of users disabling notifications or uninstalling.  
*Implementation:* In LearnViewModel.updateStreak (after setting lastLessonDate), cancel and re-add the reminder so it next fires tomorrow; or gate the reminder body on whether lastLessonDate is today.

### Forgot Password / password reset flow  
**Value:** High · **Effort:** Small · **Risk:** None.  
AuthView.swift offers only Sign Up and Log In — there is no password recovery, and AuthService has no sendPasswordReset. Any email/password user who forgets their password is permanently locked out of their streak, XP, and portfolio, which is pure, unrecoverable churn and a common App Store reviewer complaint.  
*Implementation:* Add a 'Forgot password?' button on the Log In screen that calls Auth.auth().sendPasswordReset(withEmail:) via a new AuthService method and shows a confirmation.

### Terms of Service & Privacy Policy links on sign-up  
**Value:** High · **Effort:** Small · **Risk:** App Store Guideline 5.1.1 rejection risk; also 1.3/Kids-category scrutiny given the teen audience. Low technical risk.  
AuthView creates a Firebase account with no visible Terms/Privacy links or consent. App Store Guideline 5.1.1 requires account-based apps (especially those aimed at teens) to surface a privacy policy and terms at the point of account creation — its absence is a likely rejection and a trust gap for a finance app handling minors.  
*Implementation:* Add a footnote under the Sign Up button: 'By signing up you agree to our Terms and Privacy Policy' with tappable Links to hosted URLs (reuse the Cloudflare Worker domain to host them).

### Wire up the already-built Sign in with Apple button  
**Value:** Medium · **Effort:** Small · **Risk:** App Store 4.8 favors having it; requires enabling the Sign in with Apple capability/entitlement and a nonce. Low technical risk since the backend path exists.  
AuthViewModel.signInWithAppleCredential (line 39) and AuthService.signInWithApple (line 24) are fully implemented but no button in AuthView ever calls them — the comment literally says 'wired up in Step 6' and it never was. One-tap Apple sign-in removes the biggest onboarding drop-off (typing email/password/username) and is exactly what App Store 4.8 expects.  
*Implementation:* Add SignInWithAppleButton to AuthView, generate a SHA256 nonce, and pass the ASAuthorizationAppleIDCredential into the existing signInWithAppleCredential(idToken:nonce:...).

### Streak-milestone celebration + lapsed-user win-back notifications  
**Value:** Medium · **Effort:** Medium · **Risk:** Over-notifying can trigger opt-outs — frequency-cap the win-back series and stop after 2-3 unanswered nudges.  
Notifications only ever say the same generic 'don't lose your streak' line. There's no celebratory push at 3/7/30-day milestones (the Week Warrior / Month Master achievements already exist in AchievementModels) and no re-engagement nudge after a user actually lapses. These are the highest-ROI retention messages Duolingo-style apps rely on, and they're entirely absent.  
*Implementation:* Add scheduleMilestoneCelebration(streak:) fired from updateStreak on threshold hits, and a scheduleWinBack() series (e.g. +2/+7 days after lastLessonDate) with escalating copy referencing the exact streak length.

### In-app notification settings: custom reminder time, toggle, and re-enable path  
**Value:** Medium · **Effort:** Medium · **Risk:** None.  
The reminder time is hardcoded to 18:30 with no way to change it, turn it off, or re-enable notifications if the user denied them (a dead end today). A user who studies every morning gets a useless evening ping; a user who tapped 'Don't Allow' once can never recover. A simple settings row makes the whole notification feature feel finished and user-respecting. The unused .badge grant can also be put to work here (badge pending friend requests, clear on open).  
*Implementation:* Add a Notifications section in ProfileView with a DatePicker (persist the hour/minute and pass into scheduleDailyStreakReminder), an on/off Toggle, and — when getNotificationSettings shows denied — a button opening UIApplication.openSettingsURLString.


---
*47 opportunities across 6 areas. Already shipped from this list: Gold-funded heart refill, all-time return badge, auto-scroll to current lesson.*
