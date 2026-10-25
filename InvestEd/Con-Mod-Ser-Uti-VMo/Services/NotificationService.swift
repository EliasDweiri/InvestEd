import Foundation
import UserNotifications

/// Local notifications that protect the daily streak. Asks permission the
/// first time, then keeps one gentle reminder scheduled for the evening —
/// no spam, just a nudge before the streak expires.
final class NotificationService {
    static let shared = NotificationService()
    private init() {}

    func scheduleDailyStreakReminder() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            guard granted else { return }

            center.removePendingNotificationRequests(withIdentifiers: ["dailyStreakReminder"])

            let content = UNMutableNotificationContent()
            content.title = "Penny misses you!"
            content.body = "One quick lesson keeps your streak alive. Don't let the flame go out!"
            content.sound = .default

            var components = DateComponents()
            components.hour = 18
            components.minute = 30
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

            let request = UNNotificationRequest(identifier: "dailyStreakReminder", content: content, trigger: trigger)
            center.add(request)
        }
    }

    func cancelDailyStreakReminder() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: ["dailyStreakReminder"])
    }

    /// Fires a local notification the moment a new friend request arrives
    /// (delivered on the lock screen / notification center if the app is
    /// backgrounded; true remote push comes later with APNs).
    func notifyFriendRequest(from username: String) {
        let content = UNMutableNotificationContent()
        content.title = "New friend request!"
        content.body = "\(username) sent you a friend request. Accept it in the Friends tab."
        content.sound = .default
        let request = UNNotificationRequest(identifier: "friendRequest-\(UUID().uuidString)", content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
