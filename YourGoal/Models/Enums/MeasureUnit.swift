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

    var timeTrackingType: TimeTrackingType {
        switch self {
        case .session, .page:
            return .infinite
        case .km:
            return .double
        }
    }

    var namePlural: String {
        switch self {
        case .session:
            return "sessioni"
        case .page:
            return "pagine"
        case .km:
            return "Km"
        }
    }

    var nameSingle: String {
        switch self {
        case .session:
            return "sessioni"
        case .page:
            return "pagine"
        case .km:
            return "Km"
        }
    }

    var timeRequiredQuestion: String {
        switch self {
        case .session:
            return "Quante sessioni farai al giorno?"
        case .page:
            return "Quante pagine leggerai al giorno?"
        case .km:
            return "Quanti km correrai al giorno?"
        }
    }

}
