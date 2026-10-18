import Foundation

extension Double {
    /// Formats a number as US currency, e.g. 1234.5 -> "$1,234.50"
    var asCurrency: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }

    /// Formats a number as a signed percent, e.g. 2.5 -> "+2.50%", -1.2 -> "-1.20%"
    var asPercent: String {
        String(format: "%@%.2f%%", self >= 0 ? "+" : "", self)
    }
}

extension Date {
    func isSameDay(as other: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: other)
    }

    /// Whole calendar days between two dates, ignoring time-of-day.
    /// Used for streak calculations (e.g. "was the last lesson yesterday?").
    func daysBetween(_ other: Date) -> Int {
        let start = Calendar.current.startOfDay(for: self)
        let end = Calendar.current.startOfDay(for: other)
        return Calendar.current.dateComponents([.day], from: start, to: end).day ?? 0
    }
}
