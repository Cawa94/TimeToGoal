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

    static let allValues: [GoalType] = [.custom, .book, .run, .training, .project]

}

extension GoalType {

    var icon: Image {
        return Image(self.rawValue)
    }

}
