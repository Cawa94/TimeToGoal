import Foundation

extension Date {

    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
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

}
