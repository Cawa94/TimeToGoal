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
    var habits: [HabitType]

    static var allValues: [HabitCategory] = [
        .init(id: 0, name: "Body", subtitle: "Run, train, yoga",
              image: Image("star"), habits: [
                .init(id: 0, name: "Corsa", image: Image("run_0"), categoryId: 0),
                .init(id: 1, name: "Camminata", image: Image("run_1"), categoryId: 0),
                .init(id: 2, name: "Yoga", image: Image("run_2"), categoryId: 0)
              ]),
        .init(id: 1, name: "Mind", subtitle: "Reading, meditation, study",
              image: Image("book_2"), habits: []),
        .init(id: 2, name: "Spirit", subtitle: "Something else, even more, and more",
              image: Image("training_2"), habits: [])
    ]

}
