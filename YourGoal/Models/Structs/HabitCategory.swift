//
//  HabitCategory.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

struct HabitCategory: Identifiable {

    var id: Int64
    var name: String
    var subtitle: String
    var image: Image
    var habits: [GoalType]

    static var allValues: [HabitCategory] = [
        .init(id: 0, name: "Body", subtitle: "Run, train, yoga",
              image: Image("star"), habits: GoalType.allValues.filter { $0.categoryId == 0 }),
        .init(id: 1, name: "Mind", subtitle: "Reading, meditation, study",
              image: Image("book_2"), habits: GoalType.allValues.filter { $0.categoryId == 1 }),
        .init(id: 2, name: "Spirit", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: GoalType.allValues.filter { $0.categoryId == 2 })
    ]

}
