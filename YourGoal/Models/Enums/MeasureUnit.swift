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
            return "measure_unit_session".localized()
        case .page:
            return "measure_unit_page".localized()
        case .km:
            return "measure_unit_km".localized()
        case .hour:
            return "measure_unit_hour".localized()
        case .time:
            return "measure_unit_time".localized()
        case .singleTime:
            return "measure_unit_single_time".localized()
        }
    }

    static func getFrom(_ rawValue: String) -> MeasureUnit {
        switch rawValue {
        case "measure_unit_session".localized():
            return .session
        case "measure_unit_page".localized():
            return .page
        case "measure_unit_km".localized():
            return .km
        case "measure_unit_hour".localized():
            return .hour
        case "measure_unit_time".localized():
            return .time
        case "measure_unit_single_time".localized():
            return .singleTime
        default:
            return .session
        }
    }

}
