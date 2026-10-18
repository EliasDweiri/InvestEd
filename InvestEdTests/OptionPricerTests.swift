import Testing
import Foundation
@testable import InvestEd

/// The Black-Scholes pricer behind the Options Playground and the interactive
/// options lesson. These are the properties a learner is being taught, so they
/// must hold.
struct OptionPricerTests {

    private var oneMonth: Date { Date().addingTimeInterval(30 * 24 * 3600) }

    @Test func callsAndPutsHavePositiveTimeValue() {
        #expect(OptionPricer.value(kind: .call, spot: 100, strike: 100, expiry: oneMonth) > 0)
        #expect(OptionPricer.value(kind: .put, spot: 100, strike: 100, expiry: oneMonth) > 0)
    }

    @Test func callValueRisesWithSpot() {
        let low = OptionPricer.value(kind: .call, spot: 100, strike: 100, expiry: oneMonth)
        let high = OptionPricer.value(kind: .call, spot: 110, strike: 100, expiry: oneMonth)
        #expect(high > low, "a call should be worth more as the stock rises")
    }

    @Test func putValueRisesAsSpotFalls() {
        let atMoney = OptionPricer.value(kind: .put, spot: 100, strike: 100, expiry: oneMonth)
        let deeper = OptionPricer.value(kind: .put, spot: 90, strike: 100, expiry: oneMonth)
        #expect(deeper > atMoney, "a put should be worth more as the stock falls")
    }

    @Test func intrinsicValueIsCorrect() {
        #expect(OptionPricer.intrinsic(kind: .call, spot: 110, strike: 100) == 10)
        #expect(OptionPricer.intrinsic(kind: .call, spot: 90, strike: 100) == 0)
        #expect(OptionPricer.intrinsic(kind: .put, spot: 90, strike: 100) == 10)
        #expect(OptionPricer.intrinsic(kind: .put, spot: 110, strike: 100) == 0)
    }

    @Test func breakevenIsStrikePlusOrMinusPremium() {
        #expect(OptionPricer.breakeven(kind: .call, strike: 100, premium: 5) == 105)
        #expect(OptionPricer.breakeven(kind: .put, strike: 100, premium: 5) == 95)
    }

    /// Textbook Black-Scholes value: S = K = 100, one year, r = 4%, sigma = 30%
    /// gives a call worth about $13.75 and a put worth about $9.83.
    @Test func matchesKnownBlackScholesValues() {
        let now = Date()
        let oneYear = now.addingTimeInterval(365 * 24 * 3600)
        let call = OptionPricer.value(kind: .call, spot: 100, strike: 100, expiry: oneYear, now: now)
        let put = OptionPricer.value(kind: .put, spot: 100, strike: 100, expiry: oneYear, now: now)
        #expect(abs(call - 13.7533) < 0.01)
        #expect(abs(put - 9.8322) < 0.01)
    }

    /// Put-call parity — C - P = S - K*e^(-rt) — must hold for any inputs,
    /// or the simulator would allow risk-free "free money" trades.
    @Test(arguments: [(80.0, 100.0), (100.0, 100.0), (130.0, 100.0), (55.0, 60.0)])
    func putCallParityHolds(spot: Double, strike: Double) {
        let now = Date()
        let expiry = now.addingTimeInterval(90 * 24 * 3600)
        let t = 90.0 / 365.0
        let call = OptionPricer.value(kind: .call, spot: spot, strike: strike, expiry: expiry, now: now)
        let put = OptionPricer.value(kind: .put, spot: spot, strike: strike, expiry: expiry, now: now)
        let parity = spot - strike * exp(-OptionPricer.riskFreeRate * t)
        #expect(abs((call - put) - parity) < 0.0001)
    }

    @Test func atExpiryValueEqualsIntrinsic() {
        let now = Date()
        let call = OptionPricer.value(kind: .call, spot: 120, strike: 100, expiry: now, now: now)
        #expect(abs(call - 20) < 0.0001, "at expiry an ITM call is worth its intrinsic value")
        let worthless = OptionPricer.value(kind: .call, spot: 80, strike: 100, expiry: now, now: now)
        #expect(worthless == 0, "at expiry an OTM call is worthless")
    }
}
