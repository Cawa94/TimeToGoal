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
    var goalColor: Color

    init(id: Int64, date: Date, isToday: Bool, isWorkingDay: Bool?, goalColor: String?) {
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
        self.goalColor = Color(goalColor ?? "orangeGoal")
    }

}

struct DayCellView: View {

    let weekDay: WeekDay

    @ViewBuilder
    var body: some View {
        VStack {
            /*if weekDay.isWorkingDay {
                /*ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(weekDay.goalColor)*/
                    Text(weekDay.name)
                        //.bold()
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding([.bottom, .top], 6)
                //}
            } else {*/
                Text(weekDay.name)
                    //.fontWeight(.semibold)
                    .padding([.bottom, .top], 6)
                    .foregroundColor(Color.black.opacity(0.5))
            //}

            if weekDay.isToday {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(weekDay.goalColor)
                    Text(weekDay.number)
                        .fontWeight(weekDay.isWorkingDay ? .bold : .regular )
                        .padding([.bottom, .top], 6)
                        .foregroundColor(weekDay.isWorkingDay ? weekDay.goalColor : .black)
                }
            } else {
                Text(weekDay.number)
                    .fontWeight(weekDay.isWorkingDay ? .bold : .regular )
                    .padding([.top, .bottom], 6)
                    .foregroundColor(weekDay.isWorkingDay ? weekDay.goalColor : .black)
            }
        }
    }
}

struct DayCellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(weekDay: .init(id: 0, date: Date(), isToday: true, isWorkingDay: true, goalColor: "greenGoal"))
            .previewLayout(.fixed(width: 50, height: 85))
        DayCellView(weekDay: .init(id: 0, date: Date(), isToday: true, isWorkingDay: false, goalColor: "orangeGoal"))
            .previewLayout(.fixed(width: 50, height: 85))
    }
}
