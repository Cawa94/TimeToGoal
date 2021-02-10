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
        .init(id: 0, name: "Corpo", subtitle: "Run, train, yoga",
              image: Image("star"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 0 }) ?? false)}),
        .init(id: 1, name: "Mente", subtitle: "Reading, meditation, study",
              image: Image("book_2"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 1 }) ?? false)}),
        .init(id: 2, name: "Relazioni", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 2 }) ?? false)}),
        .init(id: 3, name: "Produttività", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 3 }) ?? false)}),
        .init(id: 4, name: "Vizi", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 4 }) ?? false)}),
        .init(id: 5, name: "Casa", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 5 }) ?? false)}),
        .init(id: 5, name: "Personalizzato", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: GoalType.allValues.filter { ($0.categoryId?.contains(where: { $0 == 6 }) ?? false)})
    ]

}
