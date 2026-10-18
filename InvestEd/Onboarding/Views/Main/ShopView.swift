import SwiftUI

/// Moby's Market — the Shop tab. Gold (earned from lessons) buys power-ups
/// and avatar gear right now. The InvestEd Plus subscription section is
/// fully laid out but intentionally NOT functional: real-money purchases
/// stay disabled until the Apple Developer subscription and App Store
/// products are set up. Everything is wired so enabling it later is a
/// one-spot change (`ShopView.purchasesEnabled`).
struct ShopView: View {
    /// Flip to true once StoreKit products exist on App Store Connect.
    static let purchasesEnabled = false

    @EnvironmentObject var appState: AppState
    @StateObject private var iap = IAPManager.shared
    @State private var shopMessage: String?
    @State private var showAvatarBuilder = false

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                FloatingMoneyBackground()
                ScrollView {
                    VStack(spacing: 20) {
                        header
                        if let message = iap.message ?? shopMessage {
                            Text(message)
                                .font(AppTheme.captionFont)
                                .foregroundColor(AppTheme.streakOrange)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .transition(.opacity)
                        }
                        // Real-money sections (Gold packs, InvestEd Plus) only
                        // appear once StoreKit is live. Everything in this
                        // build is earned by learning — nothing costs money.
                        if Self.purchasesEnabled { goldPacksSection }
                        powerUpsSection
                        avatarGearSection
                        if Self.purchasesEnabled { plusSection }
                    }
                    .padding()
                    .padding(.bottom, 110) // keep last card clear of the floating tab bar
                }
            }
            .navigationTitle("Shop")
            .task { await iap.loadProducts() }
            .sheet(isPresented: $showAvatarBuilder) {
                AvatarBuilderView()
            }
        }
    }

    // MARK: - Header (Moby + gold balance)

    private var header: some View {
        HStack(spacing: 14) {
            Image(Mascots.whale.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
            VStack(alignment: .leading, spacing: 3) {
                Text("Moby's Market")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.textPrimary)
                Text("Spend the Gold you earn from lessons.")
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
            }
            Spacer()
            HStack(spacing: 6) {
                GoldCoinIcon(size: 18)
                Text("\(appState.currentUser?.goldBalance ?? 0)")
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                    .contentTransition(.numericText())
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(AppTheme.accentGold.opacity(0.18))
            .clipShape(Capsule())
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    // MARK: - Gold packs (real-money in-app purchase; placeholder until live)

    private var goldPacksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                sectionTitle("Get Gold")
                Spacer()
                if !iap.isConfigured {
                    Text("Coming soon")
                        .font(.system(size: 10.5, weight: .bold, design: .rounded))
                        .foregroundColor(AppTheme.streakOrange)
                        .padding(.horizontal, 8).padding(.vertical, 4)
                        .background(Capsule().fill(AppTheme.streakOrange.opacity(0.15)))
                }
            }
            Text("Top up Gold to grab power-ups and avatar gear faster. You can always earn Gold free by finishing lessons.")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(IAPManager.goldPacks) { pack in
                    goldPackCell(pack)
                }
            }

            if iap.isConfigured {
                Button("Restore Purchases") { Task { await iap.restore() } }
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.secondaryBlue)
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private func goldPackCell(_ pack: IAPManager.GoldPack) -> some View {
        VStack(spacing: 8) {
            if let tag = pack.tag {
                Text(tag)
                    .font(.system(size: 9, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8).padding(.vertical, 3)
                    .background(Capsule().fill(AppTheme.primaryGreen))
            } else {
                Color.clear.frame(height: 15)
            }
            HStack(spacing: 6) {
                GoldCoinIcon(size: 20)
                Text("\(pack.gold)")
                    .font(AppTheme.headingFont)
                    .foregroundColor(AppTheme.textPrimary)
            }
            Text("Gold").font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
            Button {
                Task { await iap.purchase(pack) }
            } label: {
                Group {
                    if iap.purchasingID == pack.id {
                        ProgressView().tint(.white)
                    } else {
                        Text(iap.displayPrice(for: pack))
                            .font(AppTheme.captionFont.bold())
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 9)
                .background(Capsule().fill(iap.isConfigured ? AppTheme.secondaryBlue : AppTheme.textSecondary.opacity(0.5)))
            }
            .buttonStyle(SpringPressStyle())
            .disabled(iap.purchasingID != nil)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 8)
        .background(AppTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    // MARK: - Power-ups (functional, priced in Gold)

    private var powerUpsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("Power-Ups")
            shopRow(
                icon: "snowflake",
                iconColor: AppTheme.secondaryBlue,
                title: "Streak Freeze",
                caption: "Miss a day? A freeze saves your streak automatically. Hold up to 3.",
                trailing: "\(appState.currentUser?.streakFreezes ?? 0)/3 owned"
            ) {
                goldButton(price: 150) { buyStreakFreeze() }
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    // MARK: - Avatar gear (functional, priced in Gold)

    private var avatarGearSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("Avatar Gear")
            Text("Unlock hats and accessories, then style them in the Avatar Studio.")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)

            let priced = (AvatarConfig.hatOptions + AvatarConfig.accessoryOptions)
                .filter { AvatarConfig.price(of: $0.0) != nil }
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(priced, id: \.0) { symbol, name in
                    gearCell(symbol: symbol, name: name)
                }
            }

            SecondaryButton(title: "Open Avatar Studio") {
                showAvatarBuilder = true
            }
        }
        .padding()
        .background(AppTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private func gearCell(symbol: String, name: String) -> some View {
        let owned = (appState.currentUser?.unlockedItems ?? []).contains(symbol)
        let price = AvatarConfig.price(of: symbol) ?? 0
        return VStack(spacing: 7) {
            Image(systemName: symbol)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(owned ? .white : AppTheme.textSecondary)
                .frame(width: 50, height: 50)
                .background(Circle().fill(owned ? AppTheme.primaryGreen : AppTheme.background))
            Text(name)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundColor(AppTheme.textPrimary)
                .lineLimit(1)
            if owned {
                Text("Owned")
                    .font(.system(size: 10, weight: .bold, design: .rounded))
                    .foregroundColor(AppTheme.primaryGreen)
            } else {
                Button {
                    buyGear(symbol: symbol, name: name, price: price)
                } label: {
                    HStack(spacing: 4) {
                        GoldCoinIcon(size: 11)
                        Text("\(price)")
                            .font(.system(size: 11, weight: .bold, design: .rounded))
                    }
                    .foregroundColor(Color(hex: "8A6410"))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(AppTheme.accentGold))
                }
                .buttonStyle(SpringPressStyle())
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(AppTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - InvestEd Plus (laid out, deliberately not purchasable yet)

    private var plusSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: "crown.fill")
                    .font(.system(size: 22))
                    .foregroundColor(AppTheme.accentGold)
                Text("InvestEd Plus")
                    .font(AppTheme.headingFont)
                    .foregroundColor(.white)
                Spacer()
                Text("$4.99/mo")
                    .font(AppTheme.captionFont.bold())
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(.white.opacity(0.18)))
            }

            VStack(alignment: .leading, spacing: 9) {
                plusFeature("heart.fill", "Unlimited hearts in lessons")
                plusFeature("snowflake", "A free Streak Freeze every week")
                plusFeature("chart.line.uptrend.xyaxis", "Advanced market stats in the simulator")
                plusFeature("paintpalette.fill", "Exclusive avatar backdrops and gear")
            }

            Button {
                shopMessage = "InvestEd Plus is coming soon — subscriptions unlock once the App Store setup is finished."
            } label: {
                Text(Self.purchasesEnabled ? "Subscribe" : "Coming Soon")
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(Self.purchasesEnabled ? AppTheme.textPrimary : .white.opacity(0.85))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(
                        Capsule().fill(Self.purchasesEnabled ? Color.white : Color.white.opacity(0.22))
                    )
            }
            .buttonStyle(SpringPressStyle())

            Text("Real-money purchases are disabled in this build. They'll switch on when the Apple Developer subscription and App Store products are configured.")
                .font(.system(size: 10.5, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.75))
        }
        .padding()
        .background(
            LinearGradient(colors: [Color(hex: "4361EE"), Color(hex: "9B5DE5")],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
    }

    private func plusFeature(_ icon: String, _ text: String) -> some View {
        HStack(spacing: 9) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(AppTheme.accentGold)
                .frame(width: 20)
            Text(text)
                .font(AppTheme.captionFont)
                .foregroundColor(.white.opacity(0.95))
        }
    }

    // MARK: - Purchases (Gold)

    private func buyStreakFreeze() {
        guard var user = appState.currentUser else { return }
        guard (user.streakFreezes ?? 0) < 3 else {
            shopMessage = "You can hold at most 3 freezes at a time."
            return
        }
        if user.spendGold(150) {
            user.streakFreezes = (user.streakFreezes ?? 0) + 1
            appState.currentUser = user
            try? FirestoreService.shared.saveUser(user)
            shopMessage = "Streak Freeze purchased — it activates automatically."
        } else {
            shopMessage = "Not enough Gold — lessons pay 10 to 15 Gold each."
        }
    }

    private func buyGear(symbol: String, name: String, price: Int) {
        guard var user = appState.currentUser else { return }
        if user.spendGold(price) {
            var items = user.unlockedItems ?? []
            items.append(symbol)
            user.unlockedItems = items
            appState.currentUser = user
            try? FirestoreService.shared.saveUser(user)
            shopMessage = "\(name) unlocked for \(price) Gold. Style it in the Avatar Studio."
        } else {
            shopMessage = "Not enough Gold for \(name) — you need \(price)."
        }
    }

    // MARK: - Layout helpers

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(AppTheme.headingFont)
            .foregroundColor(AppTheme.textPrimary)
    }

    private func shopRow<Trailing: View>(
        icon: String, iconColor: Color, title: String, caption: String,
        trailing: String? = nil, @ViewBuilder button: () -> Trailing
    ) -> some View {
        HStack(spacing: 14) {
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 54, height: 54)
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(iconColor)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(AppTheme.bodyFont.bold())
                    .foregroundColor(AppTheme.textPrimary)
                Text(caption)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.textSecondary)
                if let trailing {
                    Text(trailing)
                        .font(.system(size: 10.5, weight: .semibold, design: .rounded))
                        .foregroundColor(AppTheme.secondaryBlue)
                }
            }
            Spacer()
            button()
        }
    }

    private func goldButton(price: Int, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 5) {
                GoldCoinIcon(size: 13)
                Text("\(price)")
                    .font(AppTheme.captionFont.bold())
            }
            .foregroundColor(Color(hex: "8A6410"))
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(AppTheme.accentGold)
            .clipShape(Capsule())
        }
        .buttonStyle(SpringPressStyle())
    }
}
