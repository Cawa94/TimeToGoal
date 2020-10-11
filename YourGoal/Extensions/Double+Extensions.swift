//
//  Double+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 05/10/2020.
//

import Foundation

extension Double {

    var stringWithTwoDecimals: String {
        self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }

    var stringWithoutDecimals: String {
        String(format: "%.0f", self)
    }

    var asHourWithMinutes: Date {
        var components = DateComponents()
        components.day = 0
        components.hour = Int(self)
        components.minute = Int(Double(self.truncatingRemainder(dividingBy: 1) * 100).stringWithoutDecimals) ?? 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var asDaysWithHoursAndMinutes: Date {
        var components = DateComponents()
        debugPrint("\(Int(self / 24)) - \(Int(self.truncatingRemainder(dividingBy: 24))) - \(Int(Double(self.truncatingRemainder(dividingBy: 1) * 100).stringWithoutDecimals) ?? 0)")
        components.day = Int(self / 24)
        components.hour = Int(self.truncatingRemainder(dividingBy: 24))
        components.minute = Int(Double(self.truncatingRemainder(dividingBy: 1) * 100).stringWithoutDecimals) ?? 0
        return Calendar.current.date(from: components) ?? Date()
    }

}
