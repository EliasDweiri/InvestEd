import SwiftUI

// MARK: - Avatar rendering

/// Draws an AvatarConfig anywhere in the app: colored circle backdrop,
/// the character, an optional hat perched on top, and an optional
/// accessory badge at the bottom-right.
struct AvatarView: View {
    let config: AvatarConfig
    var size: CGFloat = 96

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: AvatarConfig.currentPalette(config.backgroundHex)))
            Image(Mascots.imageName(forAvatarKey: config.baseEmoji))
                .resizable()
                .scaledToFit()
                .frame(width: size * 0.82, height: size * 0.82)

            if let hat = config.hat {
                Image(systemName: hat)
                    .font(.system(size: size * 0.24, weight: .bold))
                    .foregroundColor(Color(hex: "E2AA30"))
                    .shadow(color: .black.opacity(0.25), radius: 1, y: 1)
                    .offset(y: -size * 0.42)
            }
            if let accessory = config.accessory {
                Image(systemName: accessory)
                    .font(.system(size: size * 0.17, weight: .bold))
                    .foregroundColor(.white)
                    .padding(size * 0.06)
                    .background(Circle().fill(Color(hex: "1B1F3B")))
                    .overlay(Circle().stroke(.white, lineWidth: 2))
                    .offset(x: size * 0.33, y: size * 0.33)
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Builder sheet

/// The dress-up room: pick a character, backdrop, hat, and accessory.
/// Changes preview live and save to the profile (and Firestore).
struct AvatarBuilderView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) private var dismiss

    @State private var config = AvatarConfig()
    @State private var shopMessage: String?

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 24) {
                        AvatarView(config: config, size: 130)
                            .padding(.top, 8)
                            .animation(.spring(response: 0.35, dampingFraction: 0.7), value: config)

                        HStack(spacing: 6) {
                            GoldCoinIcon(size: 17)
                            Text("\(appState.currentUser?.goldBalance ?? 0) Gold")
                                .font(AppTheme.bodyFont.bold())
                                .foregroundColor(AppTheme.textPrimary)
                                .contentTransition(.numericText())
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(AppTheme.cardBackground)
                        .clipShape(Capsule())

                        if let shopMessage {
                            Text(shopMessage)
                                .font(AppTheme.captionFont)
                                .foregroundColor(AppTheme.streakOrange)
                        }

                        section("Character") {
                            grid(items: AvatarConfig.baseOptions, columns: 5) { key in
                                selectableCircle(isSelected: config.baseEmoji == key) {
                                    Image(Mascots.imageName(forAvatarKey: key))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 36, height: 36)
                                } action: {
                                    config.baseEmoji = key
                                }
                            }
                        }

                        section("Backdrop") {
                            grid(items: AvatarConfig.backgroundOptions, columns: 8) { hex in
                                selectableCircle(isSelected: config.backgroundHex == hex) {
                                    Circle().fill(Color(hex: hex)).frame(width: 26, height: 26)
                                } action: {
                                    config.backgroundHex = hex
                                }
                            }
                        }

                        section("Hat") {
                            optionRow(options: AvatarConfig.hatOptions, selected: config.hat) { symbol in
                                attemptEquip(symbol) { config.hat = (config.hat == symbol) ? nil : symbol }
                            }
                        }

                        section("Accessory") {
                            optionRow(options: AvatarConfig.accessoryOptions, selected: config.accessory) { symbol in
                                attemptEquip(symbol) { config.accessory = (config.accessory == symbol) ? nil : symbol }
                            }
                        }

                        PrimaryButton(title: "Save Look") {
                            save()
                        }
                        .padding(.top, 4)
                    }
                    .padding()
                }
            }
            .navigationTitle("Your Avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                config = appState.currentUser?.avatar ?? AvatarConfig(baseEmoji: appState.currentUser?.avatarEmoji ?? "pig")
            }
        }
    }

    /// Free or owned items equip instantly; premium items are bought with
    /// Gold on first tap, then equip.
    private func owns(_ symbol: String) -> Bool {
        AvatarConfig.price(of: symbol) == nil || (appState.currentUser?.unlockedItems ?? []).contains(symbol)
    }

    private func attemptEquip(_ symbol: String, equip: () -> Void) {
        shopMessage = nil
        if owns(symbol) {
            equip()
            return
        }
        guard var user = appState.currentUser, let price = AvatarConfig.price(of: symbol) else { return }
        if user.spendGold(price) {
            var items = user.unlockedItems ?? []
            items.append(symbol)
            user.unlockedItems = items
            appState.currentUser = user
            try? FirestoreService.shared.saveUser(user)
            equip()
            shopMessage = "Unlocked for \(price) Gold."
        } else {
            shopMessage = "Not enough Gold. Complete lessons to earn more (\(price) needed)."
        }
    }

    private func save() {
        guard var user = appState.currentUser else { return }
        user.avatar = config
        user.avatarEmoji = config.baseEmoji
        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
        dismiss()
    }

    // MARK: - Small layout helpers

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(AppTheme.headingFont)
                .foregroundColor(AppTheme.textPrimary)
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .cardSurface()
    }

    private func grid<Item: Hashable, Cell: View>(items: [Item], columns: Int, @ViewBuilder cell: @escaping (Item) -> Cell) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columns), spacing: 10) {
            ForEach(items, id: \.self) { item in
                cell(item)
            }
        }
    }

    private func selectableCircle<Content: View>(isSelected: Bool, @ViewBuilder content: () -> Content, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(AppTheme.background)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Circle().stroke(isSelected ? AppTheme.primaryGreen : .clear, lineWidth: 3)
                    )
                content()
            }
        }
        .buttonStyle(SpringPressStyle())
    }

    private func optionRow(options: [(String, String)], selected: String?, action: @escaping (String) -> Void) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(options, id: \.0) { symbol, name in
                    Button {
                        action(symbol)
                    } label: {
                        VStack(spacing: 5) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: symbol)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(selected == symbol ? .white : AppTheme.textSecondary)
                                    .frame(width: 46, height: 46)
                                    .background(
                                        Circle().fill(selected == symbol ? AppTheme.primaryGreen : AppTheme.background)
                                    )
                                if !owns(symbol), let price = AvatarConfig.price(of: symbol) {
                                    Text("\(price)")
                                        .font(.system(size: 8, weight: .bold))
                                        .foregroundColor(Color(hex: "8A6410"))
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 2)
                                        .background(Capsule().fill(AppTheme.accentGold))
                                        .offset(x: 8, y: -4)
                                }
                            }
                            Text(name)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    }
                    .buttonStyle(SpringPressStyle())
                }
            }
            .padding(.vertical, 2)
        }
    }
}
