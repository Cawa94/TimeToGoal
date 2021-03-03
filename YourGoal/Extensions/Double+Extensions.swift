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

    var asHoursAndMinutes: Date {
        var components = DateComponents()
        components.day = Int(self / 24)
        components.hour = Int(self.truncatingRemainder(dividingBy: 24)) + 1
        components.minute = Int(Double(self.truncatingRemainder(dividingBy: 1) * 100).stringWithoutDecimals) ?? 0
        //debugPrint("SELF: \(self) - DATE: \((Calendar.current.date(from: components) ?? Date()))")
        components.year = 2020
        //debugPrint("SELF: \(self) - DATE: \((Calendar.current.date(from: components) ?? Date()))")
        return Calendar.current.date(from: components) ?? Date()
    }

}
