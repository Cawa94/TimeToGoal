//
//  MeasureUnit.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 6/2/21.
//

import Foundation

enum MeasureUnit: String {

    case session
    case km
    case page
    case hour
    case time
    case singleTime

    var timeTrackingType: TimeTrackingType {
        switch self {
        case .session, .page, .time:
            return .infinite
        case .km:
            return .double
        case .hour:
            return .hoursWithMinutes
        case .singleTime:
            return .boolean
        }
    }

    var namePlural: String {
        switch self {
        case .session:
            return "sessioni"
        case .page:
            return "pagine"
        case .km:
            return "km"
        case .hour:
            return "ore"
        case .time:
            return "volte"
        case .singleTime:
            return "giorni"
        }
    }

    // !!!!!! remember to replace both namePlural values and getFrom() with same identical localized values

    static func getFrom(_ rawValue: String) -> MeasureUnit {
        switch rawValue {
        case "sessioni":
            return .session
        case "pagine":
            return .page
        case "km":
            return .km
        case "ore":
            return .hour
        case "volte":
            return .time
        case "giorni":
            return .singleTime
        default:
            return .session
        }
    }

}
