//
//  JournalDate.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 5/12/20.
//

import Foundation
import SwiftUI

struct JournalDate: Identifiable {

    var id: Int64
    var goal: Goal
    var date: Date

    init(id: Int64, date: Date, goal: Goal) {
        self.id = id
        self.goal = goal
        self.date = date
    }

}

extension JournalDate {

    var number: String {
        let numberFormatter = DateFormatter()
        numberFormatter.dateFormat = "d"
        return numberFormatter.string(from: date)
    }

    var month: String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        return calendar.shortMonthSymbols[date.monthNumber - 1]
    }

    var hasNotes: Bool {
        return goal.journal?.contains(where: { ($0 as? JournalPage)?.dayId == self.id }) ?? false
    }

    var emoji: String? {
        if let page = goal.journal?.filter({ ($0 as? JournalPage)?.dayId == self.id }).first as? JournalPage,
           let mood = page.mood {
            return JournalMood(rawValue: mood)?.emoji
        }
        return nil
    }

}
