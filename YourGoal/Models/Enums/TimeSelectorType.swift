//
//  TimeSelectorType.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 04/11/2020.
//

import Foundation

enum TimeTrackingType: String {

    case hoursWithMinutes
    case double
    case infinite

    var values: [Double] {
        switch self {
        case .hoursWithMinutes:
            var hoursArray: [Double] = []
            for hour in 0...23 {
                for minutes in [00, 15, 30, 45] {
                    hoursArray.append(Double("\(hour).\(minutes)") ?? 0.00)
                }
            }
            return hoursArray
        case .infinite, .double:
            var hoursArray: [Double] = []
            for hour in 0...100 {
                hoursArray.append(Double(hour))
            }
            return hoursArray
        }
    }

}
