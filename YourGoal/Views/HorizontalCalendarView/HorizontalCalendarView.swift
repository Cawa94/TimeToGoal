//
//  HorizontalCalendarView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI

public class HorizontalCalendarViewModel: ObservableObject {

    @Published var goal: Goal?

    var days: [WeekDay] {
        let startOfWeek = Date().startOfWeek ?? Date()

        let monday = startOfWeek
        let tuesday = startOfWeek.adding(days: 1)
        let wednesday = startOfWeek.adding(days: 2)
        let thursday = startOfWeek.adding(days: 3)
        let friday = startOfWeek.adding(days: 4)
        let saturday = startOfWeek.adding(days: 5)
        let sunday = startOfWeek.adding(days: 6)

        return [
            WeekDay(id: 0, date: monday, isToday: Date().dayNumber == 2, isWorkingDay: goal?.workOnMonday),
            WeekDay(id: 1, date: tuesday, isToday: Date().dayNumber == 3, isWorkingDay: goal?.workOnTuesday),
            WeekDay(id: 2, date: wednesday, isToday: Date().dayNumber == 4, isWorkingDay: goal?.workOnWednesday),
            WeekDay(id: 3, date: thursday, isToday: Date().dayNumber == 5, isWorkingDay: goal?.workOnThursday),
            WeekDay(id: 4, date: friday, isToday: Date().dayNumber == 6, isWorkingDay: goal?.workOnFriday),
            WeekDay(id: 5, date: saturday, isToday: Date().dayNumber == 7, isWorkingDay: goal?.workOnSaturday),
            WeekDay(id: 6, date: sunday, isToday: Date().dayNumber == 1, isWorkingDay: goal?.workOnSunday)
        ]
    }

}

struct HorizontalCalendarView: View {

    @ObservedObject var viewModel = HorizontalCalendarViewModel()

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
/*
struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView(viewModel: HorizontalCalendarViewModel(goal: .constant(Goal())))
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
*/
