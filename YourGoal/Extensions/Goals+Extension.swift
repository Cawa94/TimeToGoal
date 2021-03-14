//
//  Goals+Extension.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/1/21.
//

import Foundation

extension Sequence where Element == Goal {

    func goalsWorkOn(date: Date) -> [Goal] {
        self.filter { $0.workOn(date: date) && !($0.isArchived) }
    }

    func areAllCompletedOn(date: Date) -> Bool {
        return goalsWorkOn(date: date).filter { !($0.isCompletedAt(date: date)) }.isEmpty
    }

    var currentStreak: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = self.sorted(by: { ($0.createdAt ?? Date()) < ($1.createdAt ?? Date()) })
            .first?.createdAt ?? formatter.date(from: "2021/01/01 23:00") ?? Date()
        let endDate = Date()
        let goalInterval = DateInterval(start: startDate, end: endDate)
        let calendar = Calendar.current
        let days = calendar.generateDates(
            inside: goalInterval,
            matching: DateComponents(hour: 1, minute: 1, second: 0)
        )

        var record = 0

        for date in days {
            if !(goalsWorkOn(date: date).isEmpty), areAllCompletedOn(date: date) {
                var nextDayIndex = 1
                var currentStreak = 1
                var isInStreak = true
                while isInStreak {
                    let nextDay = date.adding(days: nextDayIndex)
                    if !(goalsWorkOn(date: nextDay).isEmpty), areAllCompletedOn(date: nextDay) {
                        currentStreak += 1
                        nextDayIndex += 1
                    } else if goalsWorkOn(date: nextDay).isEmpty {
                        nextDayIndex += 1
                    } else {
                        isInStreak = false
                    }
                }
                if date.isToday, record == 0 {
                    record = currentStreak
                } else if !date.isToday {
                    record = currentStreak
                }
            }
        }

        return record
    }

    var perfectWeeks: Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = self.sorted(by: { ($0.createdAt ?? Date()) < ($1.createdAt ?? Date()) })
            .first?.createdAt ?? formatter.date(from: "2021/01/01 23:00") ?? Date()
        let endDate = Date()
        let goalInterval = DateInterval(start: startDate, end: endDate)
        let calendar = Calendar.current
        let days = calendar.generateDates(
            inside: goalInterval,
            matching: DateComponents(hour: 1, minute: 1, second: 0)
        )

        var perfectWeeks = 0

        for week in Dictionary(grouping: days, by: { $0.weekOfYear }) {
            var areAllCompleted = true
            for date in week.value {
                if !(goalsWorkOn(date: date).isEmpty), !areAllCompletedOn(date: date) {
                    areAllCompleted = false
                }
            }
            if areAllCompleted {
                perfectWeeks += 1
            }
        }

        return perfectWeeks
    }

}
