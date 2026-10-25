import Foundation
import Combine
import StoreKit

/// In-app purchases (StoreKit 2). Two product families:
///   • Consumable "Gold packs" — buy the in-app Gold currency.
///   • The "InvestEd Plus" auto-renewable subscription (laid out in ShopView).
///
/// This is fully functional code, but it stays in PLACEHOLDER mode until the
/// matching products exist. With no Apple Developer account / App Store Connect
/// products yet, `Product.products(for:)` returns nothing, so `isConfigured`
/// stays false and the Shop shows fallback prices + "Coming Soon". To try it
/// locally, point the scheme at InvestEd.storekit (Edit Scheme ▸ Run ▸ Options
/// ▸ StoreKit Configuration). Once real products exist, everything just works.
@MainActor
final class IAPManager: ObservableObject {
    static let shared = IAPManager()

    struct GoldPack: Identifiable {
        let id: String            // must match the App Store Connect product ID
        let gold: Int
        let fallbackPrice: String // shown before real products load
        let tag: String?          // e.g. "Best value"
    }

    static let goldPacks: [GoldPack] = [
        GoldPack(id: "com.eliasdweiri.InvestEd.gold.handful", gold: 100,  fallbackPrice: "$0.99",  tag: nil),
        GoldPack(id: "com.eliasdweiri.InvestEd.gold.stack",   gold: 550,  fallbackPrice: "$3.99",  tag: "Popular"),
        GoldPack(id: "com.eliasdweiri.InvestEd.gold.chest",   gold: 1200, fallbackPrice: "$7.99",  tag: nil),
        GoldPack(id: "com.eliasdweiri.InvestEd.gold.vault",   gold: 2500, fallbackPrice: "$14.99", tag: "Best value"),
    ]
    static let plusSubscriptionID = "com.eliasdweiri.InvestEd.plus.monthly"

    private static let goldByID: [String: Int] =
        Dictionary(uniqueKeysWithValues: goldPacks.map { ($0.id, $0.gold) })

    @Published private(set) var products: [Product] = []
    @Published private(set) var isConfigured = false   // true once real products load
    @Published var purchasingID: String?
    @Published var message: String?

    private var updatesTask: Task<Void, Never>?

    private init() {
        // Grant Gold for purchases that complete outside the buy button
        // (deferred approvals, another device, etc.).
        updatesTask = Task { [weak self] in
            // Qualified: the app also has its own `Transaction` (a paper trade).
            for await update in StoreKit.Transaction.updates {
                guard let self else { continue }
                if case .verified(let transaction) = update {
                    if let gold = Self.goldByID[transaction.productID] { self.grantGold(gold) }
                    await transaction.finish()
                }
            }
        }
    }

    func loadProducts() async {
        let ids = Set(Self.goldPacks.map(\.id) + [Self.plusSubscriptionID])
        let loaded = (try? await Product.products(for: ids)) ?? []
        products = loaded.sorted { $0.price < $1.price }
        isConfigured = !loaded.isEmpty
    }

    func product(for id: String) -> Product? { products.first { $0.id == id } }

    /// Displayed price — the real localized price once configured, else the fallback.
    func displayPrice(for pack: GoldPack) -> String {
        product(for: pack.id)?.displayPrice ?? pack.fallbackPrice
    }

    func purchase(_ pack: GoldPack) async {
        guard let product = product(for: pack.id) else {
            message = "The store isn't live yet. Gold packs unlock once InvestEd is on the App Store."
            return
        }
        purchasingID = pack.id
        defer { purchasingID = nil }
        do {
            switch try await product.purchase() {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    grantGold(pack.gold)
                    await transaction.finish()
                    message = "\(pack.gold) Gold added."
                }
            case .userCancelled, .pending:
                break
            @unknown default:
                break
            }
        } catch {
            message = "Purchase failed: \(error.localizedDescription)"
        }
    }

    func restore() async {
        try? await AppStore.sync()
        message = "Purchases restored."
    }

    private func grantGold(_ amount: Int) {
        guard var user = AppState.shared.currentUser else { return }
        user.earnGold(amount)
        AppState.shared.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }
}
