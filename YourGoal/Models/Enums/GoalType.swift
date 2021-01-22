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

    var defaultIcon: String {
        return "\(self.rawValue)_0"
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
            return "goal_book_title".localized()
        case .run:
            return "goal_run_title".localized()
        case .training:
            return "goal_training_title".localized()
        case .project:
            return "goal_project_title".localized()
        case .custom:
            return "goal_custom_title".localized()
        }
    }

    var measureUnit: String {
        switch self {
        case .book:
            return "goal_book_measure_unit".localized()
        case .run:
            return "goal_run_measure_unit".localized()
        case .training:
            return "goal_training_measure_unit".localized()
        case .project:
            return "goal_project_measure_unit".localized()
        case .custom:
            return "goal_custom_measure_unit".localized()
        }
    }

    var mainQuestion: String {
        switch self {
        case .book:
            return "goal_book_main_question".localized()
        case .run:
            return "goal_run_main_question".localized()
        case .training:
            return "goal_training_main_question".localized()
        case .project:
            return "goal_project_main_question".localized()
        case .custom:
            return "goal_custom_main_question".localized()
        }
    }

    var whyQuestion: String {
        switch self {
        case .book:
            return "goal_book_why_question".localized()
        case .run:
            return "goal_run_why_question".localized()
        case .training:
            return "goal_training_why_question".localized()
        case .project:
            return "goal_project_why_question".localized()
        case .custom:
            return "goal_custom_why_question".localized()
        }
    }

    var whatWillChangeQuestion: String {
        switch self {
        case .book:
            return "goal_book_what_change_question".localized()
        case .run:
            return "goal_run_what_change_question".localized()
        case .training:
            return "goal_training_what_change_question".localized()
        case .project:
            return "goal_project_what_change_question".localized()
        case .custom:
            return "goal_custom_what_change_question".localized()
        }
    }

    var supportQuestion: String {
        switch self {
        case .book:
            return "goal_book_support_question".localized()
        case .run:
            return "goal_run_support_question".localized()
        case .training:
            return "goal_training_support_question".localized()
        case .project:
            return "goal_project_support_question".localized()
        case .custom:
            return "goal_custom_support_question".localized()
        }
    }

    var timeRequiredQuestion: String {
        switch self {
        case .book:
            return "goal_book_time_required".localized()
        case .run:
            return "goal_run_time_required".localized()
        case .training:
            return "goal_training_time_required".localized()
        case .project:
            return "goal_project_time_required".localized()
        case .custom:
            return "goal_custom_time_required".localized()
        }
    }

    var timeForDayQuestion: String {
        switch self {
        case .book:
            return "goal_book_time_for_day".localized()
        case .run:
            return "goal_run_time_for_day".localized()
        case .training:
            return "goal_training_time_for_day".localized()
        case .project:
            return "goal_project_time_for_day".localized()
        case .custom:
            return "goal_custom_time_for_day".localized()
        }
    }

    var timeSpentQuestion: String {
        switch self {
        case .book:
            return "goal_book_time_spent".localized()
        case .run:
            return "goal_run_time_spent".localized()
        case .training:
            return "goal_training_time_spent".localized()
        case .project:
            return "goal_project_time_spent".localized()
        case .custom:
            return "goal_custom_time_spent".localized()
        }
    }

}
