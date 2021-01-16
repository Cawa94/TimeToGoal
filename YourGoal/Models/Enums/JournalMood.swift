//
//  JournalMood.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 5/12/20.
//

import Foundation

enum JournalMood: String {

    case veryHappy
    case happy
    case normal
    case sad
    case verySad

    static let allValues: [JournalMood] = [.veryHappy, .happy, .normal, .sad, .verySad]

}

extension JournalMood {

    var emoji: String {
        switch self {
        case .veryHappy:
            return "cool"
        case .happy:
            return "happy"
        case .normal:
            return "neutral"
        case .sad:
            return "sad"
        case .verySad:
            return "disappointed"
        }
    }

}
