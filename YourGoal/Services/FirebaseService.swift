//
//  FirebaseService.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/10/2020.
//

import Foundation
import Firebase

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
                               parameters: ["name": (goal.name as NSObject?) ?? "nil",
                                            "time_required": (goal.timeRequired as NSObject?) ?? "nil",
                                            "color": (goal.color as NSObject?) ?? "nil",
                                            "monday": goal.mondayHours as NSObject,
                                            "tuesday": goal.tuesdayHours as NSObject,
                                            "wednesday": goal.wednesdayHours as NSObject,
                                            "thursday": goal.thursdayHours as NSObject,
                                            "friday": goal.fridayHours as NSObject,
                                            "saturday": goal.saturdayHours as NSObject,
                                            "sunday": goal.sundayHours as NSObject,
                                            "date_extimated": (goal.completionDateExtimated as NSObject?) ?? "nil",
                                            "created_at": (goal.createdAt as NSObject?) ?? "nil",
                                            "completed_at": (goal.completedAt as NSObject?) ?? "nil",
                                            "days_required": goal.daysRequired as NSObject,
                                            "time_completed": goal.timeCompleted as NSObject,
                                            "times_been_tracked": goal.mondayHours as NSObject,
                                            "event_date": Date() as NSObject])
        } else {
            Analytics.logEvent(conversion.rawValue, parameters: ["event_date": Date() as NSObject])
        }
    }

    static func logEvent(_ event: Event, parameters: [String: NSObject]? = nil) {
        let defaultParameters: [String: NSObject] = ["event_date": Date() as NSObject]
        if let parameters = parameters {
            Analytics.logEvent(event.rawValue, parameters: parameters.merged(with: defaultParameters))
        } else {
            Analytics.logEvent(event.rawValue, parameters: defaultParameters)
        }
        
    }

}
