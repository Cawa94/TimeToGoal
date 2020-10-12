//
//  DayCellView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

struct WeekDay: Identifiable {
    var id: Int64
    var number: String
    var name: String
    var isToday: Bool
    var isWorkingDay: Bool
    var isInFuture: Bool

    init(id: Int64, date: Date, isToday: Bool, isWorkingDay: Bool?) {
        let numberFormatter = DateFormatter()
        numberFormatter.dateFormat = "d"
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.languageCode ?? "en")

        self.id = id
        self.number = numberFormatter.string(from: date)
        self.name = calendar.veryShortWeekdaySymbols[date.dayNumber - 1]
        self.isToday = isToday
        self.isWorkingDay = isWorkingDay ?? false
        self.isInFuture = date > Date()
    }

}

struct DayCellView: View {

    let weekDay: WeekDay

    @ViewBuilder
    var body: some View {
        VStack {
            if weekDay.isWorkingDay {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                    Text(weekDay.name)
                        .fontWeight(.semibold)
                        .foregroundColor(weekDay.isInFuture ? .gray : .black)
                        .padding([.bottom, .top], 6)
                }
            } else {
                Text(weekDay.name)
                    .fontWeight(.semibold)
                    .padding([.bottom, .top], 6)
                    .foregroundColor(weekDay.isInFuture ? .gray : .black)
            }

            if weekDay.isToday {
                ZStack {
                    Circle()
                        .fill(Color.goalColor)
                    Text(weekDay.number)
                        .fontWeight(.semibold)
                        .padding([.bottom, .top], 6)
                        .foregroundColor(weekDay.isInFuture ? .gray : .black)
                }
            } else {
                Text(weekDay.number)
                    .fontWeight(.semibold)
                    .padding([.top, .bottom], 6)
                    .foregroundColor(weekDay.isInFuture ? .gray : .black)
            }
        }
    }
}

struct DayCellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(weekDay: .init(id: 0, date: Date(), isToday: true, isWorkingDay: true))
            .previewLayout(.fixed(width: 50, height: 85))
        DayCellView(weekDay: .init(id: 0, date: Date(), isToday: true, isWorkingDay: false))
            .previewLayout(.fixed(width: 50, height: 85))
    }
}
