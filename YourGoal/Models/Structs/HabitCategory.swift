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
              image: Image("exercise_20"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 0 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 1, name: "Mente", subtitle: "Reading, meditation, study",
              image: Image("flower_2"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 1 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 2, name: "Relazioni", subtitle: "Something else, even more, and more",
              image: Image("love_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 2 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 3, name: "Produttività", subtitle: "Something else, even more, and more",
              image: Image("project_1"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 3 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 4, name: "Vizi", subtitle: "Something else, even more, and more",
              image: Image("quit_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 4 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 5, name: "Casa", subtitle: "Something else, even more, and more",
              image: Image("home_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 5 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 6, name: "Personalizzato", subtitle: "Something else, even more, and more",
              image: Image("project_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 6 }) ?? false)}.sorted { $0.name < $1.name })
    ]

}
