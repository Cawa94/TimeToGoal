import Foundation

extension Date {

    var customId: Int64 {
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self) - 2000
        return Int64("\(day)\(month)\(year)") ?? 0
    }

    var formattedAsDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        return dateFormatter.string(from: self)
    }

    var formattedAsHoursString: String {
        let days = Calendar.current.component(.day, from: self)
        var hours = Calendar.current.component(.hour, from: self) - 1 // to compensate for adding 1 in .asHoursAndMinutes
        if days != 31 { // by default day it's always set at 31. If it's different it means it's more than 24 hours of time
            hours += days * 24
        }
        let minutes = Calendar.current.component(.minute, from: self)
        return minutes != 0 ? "\(hours).\(minutes)" : "\(hours)"
    }

    var withoutHours: Date {
        var components = DateComponents()
        components.day = Calendar.current.component(.day, from: self)
        components.month = Calendar.current.component(.month, from: self)
        components.year = Calendar.current.component(.year, from: self)
        components.hour = 1
        components.minute = 1
        return Calendar.current.date(from: components) ?? Date()
    }

    func adding(days: Int) -> Date {
        guard let nextDate = Calendar.current.date(byAdding: .day, value: days, to: self)
            else { return self }
        return nextDate
    }

    var isMonday: Bool {
        dayNumber == 2
    }

    var isToday: Bool {
        self.withoutHours == Date().withoutHours
    }

    var dayNumber: Int {
        Calendar.current.component(.weekday, from: self)
    }

    var monthDay: Int {
        Calendar.current.component(.day, from: self)
    }

    var monthNumber: Int {
        Calendar.current.component(.month, from: self)
    }

    var weekOfYear: Int {
        Calendar.current.component(.weekOfYear, from: self)
    }

    var startOfWeek: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear, .minute, .hour], from: self))
    }

    var startOfMonth: Date? {
        Calendar.current.date(from:  Calendar.current.dateComponents([.year, .month], from: self))
    }

    var endOfMonth: Date? {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth ?? Date())
    }

    var endOfWeek: Date? {
        startOfWeek?.adding(days: 6)
    }

    var zeroHours: Date {
        0.00.asHoursAndMinutes
    }

    func remove(_ date: Date) -> Date {
        let difference = (self.timeIntervalSince(0.00.asHoursAndMinutes) - date.timeIntervalSince(0.00.asHoursAndMinutes))
        return Date(timeInterval: difference, since: 0.00.asHoursAndMinutes)
    }

    var isEvening: Bool {
        let hours = Calendar.current.component(.hour, from: self)
        return hours >= 17
    }

}

extension Date: Strideable {

    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }

}

extension Calendar {

    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(startingAfter: interval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }

}
