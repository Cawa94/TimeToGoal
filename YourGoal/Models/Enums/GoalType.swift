//
//  GoalType.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import Foundation
import SwiftUI

enum GoalType: String {

    case book
    case run
    case training
    case project
    case custom

    static let allValues: [GoalType] = [.project, .book, .run, .training, .custom]

}

extension GoalType {

    var icon: Image {
        return Image(self.rawValue)
    }

    var timeTrackingType: TimeTrackingType {
        switch self {
        case .book, .run, .training, .custom:
            return .infinite
        case .project:
            return .hoursWithMinutes
        }
    }

    var title: String {
        switch self {
        case .book:
            return "Lettura"
        case .run:
            return "Corsa"
        case .training:
            return "Allenamento"
        case .project:
            return "Progetto"
        case .custom:
            return "Personalizzato"
        }
    }

    var measureUnit: String {
        switch self {
        case .book:
            return "pagine"
        case .run:
            return "km"
        case .training:
            return "sessioni"
        case .project:
            return "ore"
        case .custom:
            return ""
        }
    }

    var mainQuestion: String {
        switch self {
        case .book:
            return "Che libro leggerai?"
        case .run:
            return "Per quale motivo ti allenerai?"
        case .training:
            return "Per quale motivo ti allenerai?"
        case .project:
            return "Che progetto vuoi realizzare?"
        case .custom:
            return "Dai un nome al tuo obiettivo"
        }
    }

    var timeRequiredQuestion: String {
        switch self {
        case .book:
            return "Quante pagine devi leggere?"
        case .run:
            return "Quanti km vuoi correre?"
        case .training:
            return "Quante sessioni di allenamento vuoi fare?"
        case .project:
            return "Quante ore di tempo richiede?"
        case .custom:
            return "%@ richiesti per raggiungerlo"
        }
    }

    var timeForDayQuestion: String {
        switch self {
        case .book:
            return "Quante pagine leggerai al giorno?"
        case .run:
            return "Quanti km correrai ogni giorno?"
        case .training:
            return "Quante sessioni farai ogni giorni?"
        case .project:
            return "Quante ore ci lavorerai ogni giorno?"
        case .custom:
            return "%@ al giorno"
        }
    }

}
