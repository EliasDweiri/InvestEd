import Foundation
import Combine
import SwiftUI

@MainActor
final class PortfolioViewModel: ObservableObject {
    @Published var errorMessage: String?

    private var appState: AppState { AppState.shared }

    func holding(for symbol: String) -> Holding? {
        appState.currentUser?.holdings.first(where: { $0.symbol == symbol })
    }

    func totalHoldingsValue(stocks: [Stock]) -> Double {
        guard let user = appState.currentUser else { return 0 }
        return user.holdings.reduce(0) { total, holding in
            let price = stocks.first(where: { $0.symbol == holding.symbol })?.currentPrice ?? holding.averageCost
            return total + (holding.shares * price)
        }
    }

    func totalPortfolioValue(stocks: [Stock]) -> Double {
        (appState.currentUser?.cashBalance ?? 0) + totalHoldingsValue(stocks: stocks) + totalOptionsValue(stocks: stocks)
    }

    // MARK: - Options (simulated)

    var optionPositions: [OptionPosition] {
        appState.currentUser?.optionPositions ?? []
    }

    /// Theoretical per-share value of a position right now, using the live
    /// underlying price when we have one.
    func optionValue(_ position: OptionPosition, stocks: [Stock]) -> Double {
        let spot = stocks.first(where: { $0.symbol == position.symbol })?.currentPrice
        guard let spot else { return position.premiumPaid } // no quote — hold at cost
        return OptionPricer.value(kind: position.kind, spot: spot, strike: position.strike, expiry: position.expiry)
    }

    func totalOptionsValue(stocks: [Stock]) -> Double {
        optionPositions.reduce(0) { $0 + optionValue($1, stocks: stocks) * 100 * Double($1.contracts) }
    }

    func buyOption(symbol: String, kind: OptionKind, strike: Double, expiry: Date, contracts: Int, premium: Double) {
        guard var user = appState.currentUser else { return }
        let cost = premium * 100 * Double(contracts)
        guard contracts > 0, premium > 0 else {
            errorMessage = "Pick at least one contract."
            return
        }
        guard cost <= user.cashBalance else {
            errorMessage = "You don't have enough cash. This trade costs \(cost.formatted(.currency(code: "USD")))."
            return
        }
        user.cashBalance -= cost

        let position = OptionPosition(
            id: UUID().uuidString, symbol: symbol, kind: kind, strike: strike,
            expiry: expiry, contracts: contracts, premiumPaid: premium, openDate: Date()
        )
        var positions = user.optionPositions ?? []
        positions.insert(position, at: 0)
        user.optionPositions = positions

        user.transactions.insert(
            Transaction(id: UUID().uuidString, symbol: position.displayName, type: .buy,
                        shares: Double(contracts), pricePerShare: premium * 100, date: Date()),
            at: 0
        )

        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }

    /// Sells a position back at its current theoretical value.
    func closeOption(_ position: OptionPosition, stocks: [Stock]) {
        guard var user = appState.currentUser,
              let index = user.optionPositions?.firstIndex(where: { $0.id == position.id }) else { return }
        let perShare = optionValue(position, stocks: stocks)
        let proceeds = perShare * 100 * Double(position.contracts)

        user.cashBalance += proceeds
        user.optionPositions?.remove(at: index)
        user.transactions.insert(
            Transaction(id: UUID().uuidString, symbol: position.displayName, type: .sell,
                        shares: Double(position.contracts), pricePerShare: perShare * 100, date: Date()),
            at: 0
        )

        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }

    /// Settles anything past its expiry date at intrinsic value — worthless
    /// options simply disappear, in-the-money ones pay out automatically.
    func settleExpiredOptions(stocks: [Stock]) {
        guard var user = appState.currentUser,
              let positions = user.optionPositions, !positions.isEmpty else { return }
        let expired = positions.filter { $0.isExpired }
        guard !expired.isEmpty else { return }

        for position in expired {
            let spot = stocks.first(where: { $0.symbol == position.symbol })?.currentPrice ?? position.strike
            let perShare = OptionPricer.intrinsic(kind: position.kind, spot: spot, strike: position.strike)
            let proceeds = perShare * 100 * Double(position.contracts)
            user.cashBalance += proceeds
            user.transactions.insert(
                Transaction(id: UUID().uuidString, symbol: "\(position.displayName) (expired)", type: .sell,
                            shares: Double(position.contracts), pricePerShare: perShare * 100, date: Date()),
                at: 0
            )
        }
        user.optionPositions = positions.filter { !$0.isExpired }

        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }

    func buy(symbol: String, shares: Double, price: Double) {
        guard var user = appState.currentUser else { return }
        let cost = shares * price
        guard shares > 0, cost <= user.cashBalance else {
            errorMessage = "You don't have enough cash for this trade."
            return
        }
        user.cashBalance -= cost

        if let index = user.holdings.firstIndex(where: { $0.symbol == symbol }) {
            let existing = user.holdings[index]
            let newShares = existing.shares + shares
            let newAvgCost = ((existing.shares * existing.averageCost) + cost) / newShares
            user.holdings[index] = Holding(symbol: symbol, shares: newShares, averageCost: newAvgCost)
        } else {
            user.holdings.append(Holding(symbol: symbol, shares: shares, averageCost: price))
        }

        user.transactions.insert(
            Transaction(id: UUID().uuidString, symbol: symbol, type: .buy, shares: shares, pricePerShare: price, date: Date()),
            at: 0
        )

        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }

    func sell(symbol: String, shares: Double, price: Double) {
        guard var user = appState.currentUser else { return }
        guard let index = user.holdings.firstIndex(where: { $0.symbol == symbol }),
              shares > 0, user.holdings[index].shares >= shares else {
            errorMessage = "You don't own enough shares to sell that amount."
            return
        }

        user.cashBalance += shares * price
        user.holdings[index].shares -= shares
        if user.holdings[index].shares <= 0.0001 {
            user.holdings.remove(at: index)
        }

        user.transactions.insert(
            Transaction(id: UUID().uuidString, symbol: symbol, type: .sell, shares: shares, pricePerShare: price, date: Date()),
            at: 0
        )

        appState.currentUser = user
        try? FirestoreService.shared.saveUser(user)
    }
}
