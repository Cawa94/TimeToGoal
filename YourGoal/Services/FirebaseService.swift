//
//  FirebaseService.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/10/2020.
//

import Foundation
import Firebase
import UIKit

struct FirebaseService {

    enum Event: String {
        case updateCompletionDate = "update_completion_date"
        case trackTimeButton = "track_time_button"
        case addGoalButton = "add_goal_button"
        case editGoalButton = "edit_goal_button"
        case timeTracked = "time_tracked"
    }

    enum Conversion: String {
        case goalCreated = "goal_created"
        case goalCompleted = "goal_completed"
    }

    static func logConversion(_ conversion: Conversion, goal: Goal?) {
        if let goal = goal {
            Analytics.logEvent(conversion.rawValue,
                               parameters: ["name": (goal.name as String?) ?? "nil",
                                            "time_required": (goal.timeRequired as NSNumber?) ?? "nil",
                                            "type": goal.goalType.name as String,
                                            "time_measure": (goal.customTimeMeasure as String?) ?? "nil",
                                            "color": (goal.color as String?) ?? "nil",
                                            "monday": goal.monday as NSNumber,
                                            "tuesday": goal.tuesday as NSNumber,
                                            "wednesday": goal.wednesday as NSNumber,
                                            "thursday": goal.thursday as NSNumber,
                                            "friday": goal.friday as NSNumber,
                                            "saturday": goal.saturday as NSNumber,
                                            "sunday": goal.sunday as NSNumber,
                                            "days_required": goal.daysRequired as NSNumber,
                                            "what_definition": (goal.whatDefinition as String?) ?? "nil",
                                            "support_definition": (goal.supportDefinition as String?) ?? "nil",
                                            "why_definition": (goal.whyDefinition as String?) ?? "nil",
                                            "what_will_change_definition": (goal.whatWillChangeDefinition as String?) ?? "nil",
                                            "times_been_tracked": goal.timesHasBeenTracked as NSNumber])
        } else {
            Analytics.logEvent(conversion.rawValue, parameters: ["event_date": Date() as NSObject])
        }
    }

    static func logEvent(_ event: Event, parameters: [String: NSObject]? = nil) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }

}
