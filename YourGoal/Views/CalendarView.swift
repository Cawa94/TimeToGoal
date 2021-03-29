//
//  CalendarView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 22/2/21.
//

import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

struct WeekView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar

    let week: Date
    let content: (Date) -> DateView

    init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self.week = week
        self.content = content
    }

    private var days: [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
            else { return [] }
        return calendar.generateDates(
            inside: weekInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    var body: some View {
        HStack(spacing: 10) {
            ForEach(days, id: \.self) { date in
                HStack {
                    if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
                        self.content(date)
                    } else {
                        self.content(date).hidden()
                    }
                }
            }
        }
    }
}

struct MonthView<DateView>: View where DateView: View {

    @Environment(\.calendar) var calendar

    @Binding var interval: DateInterval

    let month: Date
    let content: (Date) -> DateView

    init(interval: Binding<DateInterval>, month: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
        self._interval = interval
        self.month = month
        self.content = content
    }

    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month)
            else { return [] }
        return calendar.generateDates(inside: monthInterval,
                                      matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    private var header: some View {
        let formatter = DateFormatter.monthAndYear
        return Text(formatter.string(from: month).capitalized)
            .applyFont(.largeTitle)
            .foregroundColor(.grayText)
    }

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Button(action: {
                    let randomLastMonthDay = interval.start.adding(days: -3)
                    guard let startDate = randomLastMonthDay.startOfMonth, let endDate = randomLastMonthDay.endOfMonth
                        else { return }
                    interval = DateInterval(start: startDate, end: endDate)
                }) {
                    Image(systemName: "chevron.left").foregroundColor(.black)
                }

                Spacer()

                header

                Spacer()

                Button(action: {
                    let randomNextMonthDay = interval.end.endOfMonth?.adding(days: 3)
                    guard let startDate = randomNextMonthDay?.startOfMonth, let endDate = randomNextMonthDay?.endOfMonth
                        else { return }
                    interval = DateInterval(start: startDate, end: endDate)
                }) {
                    Image(systemName: "chevron.right").foregroundColor(.black)
                }
            }.padding([.leading, .trailing], 35)

            ForEach(weeks, id: \.self) { week in
                WeekView(week: week, content: self.content)
            }
        }
    }
}

struct CalendarView<DateView>: View where DateView: View {

    @Environment(\.calendar) var calendar

    @Binding var interval: DateInterval

    let monthWidth: CGFloat
    let content: (Date) -> DateView

    init(interval: Binding<DateInterval>, monthWidth: CGFloat, @ViewBuilder content: @escaping (Date) -> DateView) {
        self._interval = interval
        self.monthWidth = monthWidth
        self.content = content
    }

    private var months: [Date] {
        let dates = calendar.generateDates(inside: interval,
                                           matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0))
        return dates
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                HStack {
                    ForEach(months, id: \.self) { month in
                        MonthView(interval: $interval, month: month, content: self.content)
                            .frame(width: monthWidth)
                    }
                }
            }
        }
    }

}
/*
struct CalendarView_Previews: PreviewProvider {

    static var previews: some View {
        CalendarView()
    }

}
*/
