//
//  HorizontalCalendarView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI

struct HorizontalCalendarViewModel {

    @Binding var goal: Goal?

    var days: [WeekDay] {
        let startOfWeek = Date().startOfWeek ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d"

        return [
            WeekDay(id: 0, number: formatter.string(from: startOfWeek),
                    name: "Lu", isToday: Date().dayNumber == 2, isWorkingDay: goal?.workOnMonday),
            WeekDay(id: 1, number: formatter.string(from: startOfWeek.adding(days: 1)),
                    name: "Ma", isToday: Date().dayNumber == 3, isWorkingDay: goal?.workOnTuesday),
            WeekDay(id: 2, number: formatter.string(from: startOfWeek.adding(days: 2)),
                    name: "Me", isToday: Date().dayNumber == 4, isWorkingDay: goal?.workOnWednesday),
            WeekDay(id: 3, number: formatter.string(from: startOfWeek.adding(days: 3)),
                    name: "Gi", isToday: Date().dayNumber == 5, isWorkingDay: goal?.workOnThursday),
            WeekDay(id: 4, number: formatter.string(from: startOfWeek.adding(days: 4)),
                    name: "Ve", isToday: Date().dayNumber == 6, isWorkingDay: goal?.workOnFriday),
            WeekDay(id: 5, number: formatter.string(from: startOfWeek.adding(days: 5)),
                    name: "Sa", isToday: Date().dayNumber == 7, isWorkingDay: goal?.workOnSaturday),
            WeekDay(id: 6, number: formatter.string(from: startOfWeek.adding(days: 6)),
                    name: "Do", isToday: Date().dayNumber == 1, isWorkingDay: goal?.workOnSunday)
        ]
    }

}

struct HorizontalCalendarView: View {

    let viewModel: HorizontalCalendarViewModel!

    var body: some View {
        HStack(content: {
            ForEach(viewModel.days) {
                DayCellView(weekDay: $0)
                    .padding(5)
                    .frame(minWidth: 0,
                           maxWidth: .infinity,
                           minHeight: 0,
                           maxHeight: .infinity)
            }
        }).frame(width: .infinity, height: 80, alignment: .center)
    }

}

struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView(viewModel: HorizontalCalendarViewModel(goal: .constant(Goal())))
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
