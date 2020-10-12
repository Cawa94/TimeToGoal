import Foundation

extension Date {

    var formattedAsDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        dateFormatter.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        return dateFormatter.string(from: self)
    }

    var formattedAsHours: String {
        let days = Calendar.current.component(.day, from: self)
        var hours = Calendar.current.component(.hour, from: self)
        if days != 31 { // sometimes days are set as 31 instead of 0
            hours += days * 24
        }
        let minutes = Calendar.current.component(.minute, from: self)
        return minutes != 0 ? "\(hours).\(minutes)" : "\(hours)"
    }

    func adding(days: Int) -> Date {
        var dayComponent = DateComponents()
        dayComponent.day = days
        guard let nextDate = Calendar.current.date(byAdding: dayComponent, to: self)
            else { return self }
        return nextDate
    }

    var dayNumber: Int {
        Calendar.current.component(.weekday, from: self)
    }

    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var zeroHours: Date {
        var components = DateComponents()
        components.day = 0
        components.hour = 0
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    func remove(_ date: Date) -> Date {
        //debugPrint("SELF: \(self.formattedWithDaysAndHours) - DATE:\(date.formattedWithDaysAndHours)")
        let differenceComponents = Calendar.current.dateComponents([.day, .hour, .minute,], from: date, to: self)
        let differenceDate = Calendar.current.date(from: differenceComponents) ?? Date()
        //debugPrint("DIFFERENCE: \(differenceDate.formattedWithDaysAndHours)")
        return differenceDate
    }

}
