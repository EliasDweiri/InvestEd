import Testing
import Foundation
@testable import InvestEd

/// Pure logic on the AppUser model + the streak date helper.
struct UserModelTests {

    private func newUser() -> AppUser { AppUser.newUserDefault }

    @Test func levelIsEveryHundredXP() {
        var u = newUser()
        u.xp = 0;   #expect(u.level == 1)
        u.xp = 99;  #expect(u.level == 1)
        u.xp = 100; #expect(u.level == 2)
        u.xp = 250; #expect(u.level == 3)
    }

    @Test func earningGoldAddsToBalance() {
        var u = newUser()
        u.cents = 0
        u.earnGold(30)
        #expect(u.goldBalance == 30)
        u.earnGold(5)
        #expect(u.goldBalance == 35)
    }

    @Test func spendingGoldRespectsBalance() {
        var u = newUser()
        u.cents = 50
        #expect(u.spendGold(60) == false, "shouldn't be able to overspend")
        #expect(u.goldBalance == 50, "a failed spend leaves the balance untouched")
        #expect(u.spendGold(20) == true)
        #expect(u.goldBalance == 30)
    }

    @Test func addXPAccumulatesLifetimeAndWeekly() {
        var u = newUser()
        u.xp = 0
        u.weeklyXP = 0
        u.weekAnchor = nil
        u.addXP(40)
        #expect(u.xp == 40)
        #expect(u.currentWeeklyXP == 40, "first XP of the week starts the weekly tally")
        u.addXP(10)
        #expect(u.xp == 50)
        #expect(u.currentWeeklyXP == 50)
    }

    @Test func daysBetweenCountsCalendarDays() {
        let cal = Calendar.current
        let today = cal.startOfDay(for: Date())
        let tomorrow = cal.date(byAdding: .day, value: 1, to: today)!
        let inThreeDays = cal.date(byAdding: .day, value: 3, to: today)!
        #expect(today.daysBetween(tomorrow) == 1)
        #expect(today.daysBetween(inThreeDays) == 3)
        #expect(today.daysBetween(today) == 0)
    }
}
