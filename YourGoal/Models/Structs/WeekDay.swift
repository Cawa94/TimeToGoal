//
//  WeekDay.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 04/11/2020.
//

import Foundation
import SwiftUI

struct WeekDay: Identifiable {

    var id: Int64
    var number: String
    var name: String
    var month: String
    var isToday: Bool
    var isWorkingDay: Bool
    var isInFuture: Bool
    var goalColor: Color
    var isValidGoal: Bool
    var goal: Goal?

    init(id: Int64, date: Date, isToday: Bool, isWorkingDay: Bool? = nil, goalColor: String? = nil, goal: Goal? = nil) {
        let numberFormatter = DateFormatter()
        numberFormatter.dateFormat = "d"
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.languageCode ?? "en")

        self.id = id
        self.number = numberFormatter.string(from: date)
        self.name = calendar.veryShortWeekdaySymbols[date.dayNumber - 1]
        self.month = calendar.shortMonthSymbols[date.monthNumber - 1]
        self.isToday = isToday
        self.isWorkingDay = isWorkingDay ?? false
        self.isInFuture = date > Date()
        self.goalColor = Color(goalColor ?? "orangeGoal")
        self.isValidGoal = isWorkingDay != nil
        self.goal = goal
    }

}
