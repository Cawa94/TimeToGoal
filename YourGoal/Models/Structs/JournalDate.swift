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
    var date: Date
    var hasNotes: Bool
    var emoji: String?

    init(id: Int64, date: Date, hasNotes: Bool, emoji: String?) {
        self.id = id
        self.date = date
        self.hasNotes = hasNotes
        self.emoji = emoji
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

}
