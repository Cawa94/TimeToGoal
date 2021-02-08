//
//  GoalType.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import Foundation
import SwiftUI

struct GoalType: Identifiable {

    let id: Int64
    let label: String
    let name: String
    let image: String
    let categoryId: [Int64]?
    let measureUnits: [MeasureUnit]
    let isHabit: Bool

    init(id: Int64, label: String, name: String,
         image: String, categoryId: [Int64]? = nil, measureUnits: [MeasureUnit],
         isHabit: Bool = true) {
        self.id = id
        self.label = label
        self.name = name
        self.image = image
        self.categoryId = categoryId
        self.measureUnits = measureUnits
        self.isHabit = isHabit
    }

    //static let allValues: [GoalType] = [.project, .book, .run, .training, .custom]
    static let allValues: [GoalType] = [
        .init(id: 0, label: "run", name: "Corsa", image: "run_0", categoryId: [0], measureUnits: [.session, .km]),
        .init(id: 1, label: "walk", name: "Camminata", image: "run_1", categoryId: [0], measureUnits: [.session, .km]),
        .init(id: 2, label: "yoga", name: "Yoga", image: "run_2", categoryId: [0], measureUnits: [.session, .km])
      ]
/*
     
     Study online
     New language
     Reading
     Drink water
     Exercise
     Clean teeth
     Meditate
     Eat healthy
     Walk
     Do your bed
     Study
     Wake up early
     Go to bed early
     Wash your hands
     Spend time with family
     Spend time alone
     Write blog post
     Videocall your family
     Play instrument
     Try new recepit
     Sing
     Work on your project
     Yoga
     Listen to podcast
     Try something new
     Eat fruits
     Eat vegetables
     Visualization
     Affirmations
     Journalying
     Reflects on your day
     Plan your next week
     Cook for your family
     Avoid smoking
     Avoid sugar
     Avoid drinking
     Avoid caffeine
     Practice breathing
     Go outside
     Practice gratitude
     Write something
     Paint something
     Swim
     Bicycle
     Track expenses
     Avoid useless spending
     Avoid eating out
     Plan weekly meals
     Hugs and kiss
     Write to your friends
     Take out trash
     Do laundry
     Clean house
     Gardening
     Avoid social media
     Plan your day
     
     Custom
     
*/
    static var dumbValue: GoalType {
        .init(id: 0, label: "nothing", name: "", image: "", measureUnits: [], isHabit: false)
    }

    static func getWithLabel(_ label: String) -> GoalType {
        return GoalType.allValues.first(where: { $0.label == label }) ?? .dumbValue
    }

}

extension GoalType {

    var timeTrackingType: TimeTrackingType {
        return .infinite
    }

    var title: String {
        return "goal_custom_title".localized()
    }

    var measureUnit: String {
        return "goal_custom_measure_unit".localized()
    }

    var mainQuestion: String {
        return "goal_custom_main_question".localized()
    }

    var whyQuestion: String {
        return "goal_custom_why_question".localized()
    }

    var whatWillChangeQuestion: String {
        return "goal_custom_what_change_question".localized()
    }

    var supportQuestion: String {
        return "goal_custom_support_question".localized()
    }

    var timeRequiredQuestion: String {
        return "goal_custom_time_required".localized()
    }

    var timeForDayQuestion: String {
        return "goal_custom_time_for_day".localized()
    }

    var timeSpentQuestion: String {
        return "goal_custom_time_spent".localized()
    }

}

extension GoalType: Equatable {
    
}
