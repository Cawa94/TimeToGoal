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
    var isToday: Bool
    var isWorkingDay: Bool
    var isInFuture: Bool
    var goalColor: Color
    var isValidGoal: Bool

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
        self.isValidGoal = isWorkingDay != nil
    }

}
