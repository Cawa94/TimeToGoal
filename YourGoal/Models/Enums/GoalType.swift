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
        case .book, .training, .custom:
            return .infinite
        case .run:
            return .double
        case .project:
            return .hoursWithMinutes
        }
    }

    var title: String {
        switch self {
        case .book:
            return "goal_book_title"
        case .run:
            return "goal_run_title"
        case .training:
            return "goal_training_title"
        case .project:
            return "goal_project_title"
        case .custom:
            return "goal_custom_title"
        }
    }

    var measureUnit: String {
        switch self {
        case .book:
            return "goal_book_measure_unit"
        case .run:
            return "goal_run_measure_unit"
        case .training:
            return "goal_training_measure_unit"
        case .project:
            return "goal_project_measure_unit"
        case .custom:
            return "goal_custom_measure_unit"
        }
    }

    var mainQuestion: String {
        switch self {
        case .book:
            return "goal_book_main_question"
        case .run:
            return "goal_run_main_question"
        case .training:
            return "goal_training_main_question"
        case .project:
            return "goal_project_main_question"
        case .custom:
            return "goal_custom_main_question"
        }
    }

    var timeRequiredQuestion: String {
        switch self {
        case .book:
            return "goal_book_time_required"
        case .run:
            return "goal_run_time_required"
        case .training:
            return "goal_training_time_required"
        case .project:
            return "goal_project_time_required"
        case .custom:
            return "goal_custom_time_required"
        }
    }

    var timeForDayQuestion: String {
        switch self {
        case .book:
            return "goal_book_time_for_day"
        case .run:
            return "goal_run_time_for_day"
        case .training:
            return "goal_training_time_for_day"
        case .project:
            return "goal_project_time_for_day"
        case .custom:
            return "goal_custom_time_for_day"
        }
    }

    var timeSpentQuestion: String {
        switch self {
        case .book:
            return "goal_book_time_spent"
        case .run:
            return "goal_run_time_spent"
        case .training:
            return "goal_training_time_spent"
        case .project:
            return "goal_project_time_spent"
        case .custom:
            return "goal_custom_time_spent"
        }
    }

}
