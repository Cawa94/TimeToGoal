//
//  TimeFrameType.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 8/3/21.
//

import Foundation

enum TimeFrameType: String {

    case weekly
    case monthly
    case free

    static func getFrom(_ rawValue: String) -> TimeFrameType {
        switch rawValue {
        case "weekly":
            return .weekly
        case "monthly":
            return .monthly
        case "free":
            return .free
        default:
            return .free
        }
    }

}
