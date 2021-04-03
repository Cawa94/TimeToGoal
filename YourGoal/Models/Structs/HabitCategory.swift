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
        .init(id: 0, name: "habit_category_body_name", subtitle: "habit_category_body_subtitle",
              image: Image("exercise_20"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 0 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 1, name: "habit_category_mind_name", subtitle: "habit_category_mind_subtitle",
              image: Image("flower_2"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 1 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 2, name: "habit_category_relationship_name", subtitle: "habit_category_relationship_subtitle",
              image: Image("love_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 2 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 7, name: "habit_category_socials_name", subtitle: "habit_category_socials_subtitle",
              image: Image("social_3"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 7 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 3, name: "habit_category_productivity_name", subtitle: "habit_category_productivity_subtitle",
              image: Image("project_1"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 3 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 4, name: "habit_category_vice_name", subtitle: "habit_category_vice_subtitle",
              image: Image("quit_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 4 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 5, name: "habit_category_home_name", subtitle: "habit_category_home_subtitle",
              image: Image("home_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 5 }) ?? false)}.sorted { $0.name < $1.name }),
        .init(id: 6, name: "habit_category_custom_name", subtitle: "habit_category_custom_subtitle",
              image: Image("project_0"), habits: GoalType.allHabits.filter { ($0.categoryId?.contains(where: { $0 == 6 }) ?? false)}.sorted { $0.name < $1.name })
    ]

}
