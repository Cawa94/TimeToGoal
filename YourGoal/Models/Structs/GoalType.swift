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
    let ofGoalSentence: String?
    let timeSentence: String?

    init(id: Int64, label: String, name: String,
         image: String, categoryId: [Int64]? = nil, measureUnits: [MeasureUnit],
         isHabit: Bool = true, ofGoalSentence: String? = nil, timeSentence: String? = nil) {
        self.id = id
        self.label = label
        self.name = name
        self.image = image
        self.categoryId = categoryId
        self.measureUnits = measureUnits
        self.isHabit = isHabit
        self.ofGoalSentence = ofGoalSentence
        self.timeSentence = timeSentence
    }

    static let allHabits: [GoalType] = [

        // HABITS

        .init(id: 0, label: "run", name: "habit_run_name", image: "exercise_6",
              categoryId: [0], measureUnits: [.session, .km, .hour], ofGoalSentence: "habit_run_goal_sentence"),

        .init(id: 1, label: "walk", name: "habit_walk_name", image: "exercise_13",
              categoryId: [0], measureUnits: [.session, .km, .hour], ofGoalSentence: "habit_walk_goal_sentence"),

        .init(id: 2, label: "yoga", name: "habit_yoga_name", image: "exercise_19",
              categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "habit_yoga_goal_sentence"),

        .init(id: 3, label: "study", name: "habit_study_name", image: "learn_0",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "habit_study_goal_sentence"),

        .init(id: 4, label: "new_language", name: "habit_new_language_name", image: "learn_2",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "habit_new_language_goal_sentence"),

        .init(id: 5, label: "reading", name: "habit_reading_name", image: "book_2",
              categoryId: [1, 3], measureUnits: [.session, .page, .hour], ofGoalSentence: "habit_reading_goal_sentence", timeSentence: "habit_reading_time_sentence"),

        .init(id: 6, label: "drink_water", name: "habit_drink_name", image: "custom_2",
              categoryId: [0], measureUnits: [.time], timeSentence: "habit_drink_time_sentence"),

        .init(id: 7, label: "excercise", name: "habit_excercise_name", image: "exercise_17",
              categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "habit_excercise_goal_sentence"),

        .init(id: 8, label: "teeth", name: "habit_teeth_name", image: "custom_1",
              categoryId: [0], measureUnits: [.time], timeSentence: "habit_teeth_time_sentence"),

        .init(id: 9, label: "meditate", name: "habit_meditate_name", image: "exercise_2",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "habit_meditate_goal_sentence"),

        .init(id: 10, label: "eat_helthy", name: "habit_eat_helthy_name", image: "vegetable_2",
              categoryId: [0], measureUnits: [.time], timeSentence: "habit_eat_helthy_time_sentence"),

        .init(id: 11, label: "your_bed", name: "habit_your_bed_name", image: "home_1",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "habit_your_bed_time_sentence"),

        .init(id: 12, label: "wake_early", name: "habit_wake_early_name", image: "clock_2",
              categoryId: [0, 1, 3], measureUnits: [.singleTime], timeSentence: "habit_wake_early_time_sentence"),

        .init(id: 13, label: "bed_early", name: "habit_bed_early_name", image: "mind_0",
              categoryId: [0, 1, 3], measureUnits: [.singleTime], timeSentence: "habit_bed_early_time_sentence"),

        .init(id: 14, label: "time_family", name: "habit_time_family_name", image: "love_1",
              categoryId: [2], measureUnits: [.time, .hour], ofGoalSentence: "habit_time_family_goal_sentence", timeSentence: "habit_time_family_time_sentence"),

        .init(id: 15, label: "time_alone", name: "habit_time_alone_name", image: "music_2",
              categoryId: [1], measureUnits: [.time, .hour], ofGoalSentence: "habit_time_alone_goal_sentence", timeSentence: "habit_time_alone_time_sentence"),

        .init(id: 16, label: "writing", name: "habit_writing_name", image: "write_7",
              categoryId: [3], measureUnits: [.session, .hour, .page], ofGoalSentence: "habit_writing_goal_sentence"),

        .init(id: 17, label: "play_instrment", name: "habit_play_instrument_name", image: "music_9",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "habit_play_instrument_goal_sentence"),

        .init(id: 18, label: "cook", name: "habit_cook_name", image: "cook_0",
              categoryId: [5], measureUnits: [.time], timeSentence: "habit_cook_time_sentence"),

        .init(id: 19, label: "sing", name: "habit_sing_name", image: "music_6",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "habit_sing_goal_sentence"),

        .init(id: 20, label: "project", name: "habit_project_name", image: "project_5",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "habit_project_goal_sentence"),

        .init(id: 21, label: "podcast", name: "habit_podcast_name", image: "music_0",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "habit_podcast_goal_sentence"),

        .init(id: 22, label: "something_new", name: "habit_something_new_name", image: "adventure_1",
              categoryId: [3], measureUnits: [.singleTime], timeSentence: "habit_something_new_time_sentence"),

        .init(id: 23, label: "eat_fruit", name: "habit_eat_fruit_name", image: "fruit_0",
              categoryId: [0], measureUnits: [.time], timeSentence: "habit_eat_fruit_time_sentence"),

        .init(id: 24, label: "eat_vegetables", name: "habit_eat_vegetables_name", image: "vegetable_0",
              categoryId: [0], measureUnits: [.time], timeSentence: "habit_eat_vegetables_time_sentence"),

        .init(id: 25, label: "visualization", name: "habit_visualization_name", image: "mind_1",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "habit_visualization_goal_sentence"),

        .init(id: 26, label: "affirmations", name: "habit_affirmations_name", image: "mind_7",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "habit_affirmations_goal_sentence"),

        .init(id: 27, label: "journal", name: "habit_journal_name", image: "write_2",
              categoryId: [1, 3], measureUnits: [.session, .singleTime], ofGoalSentence: "habit_journal_goal_sentence", timeSentence: "habit_journal_time_sentence"),

        .init(id: 28, label: "self_reflects", name: "habit_self_reflects_name", image: "mind_6",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "habit_self_reflects_time_sentence"),

        .init(id: 29, label: "plan_week", name: "habit_plan_week_name", image: "plan_1",
              categoryId: [3], measureUnits: [.singleTime], timeSentence: "habit_plan_week_time_sentence"),

        .init(id: 30, label: "avoid_smoke", name: "habit_avoid_smoke_name", image: "quit_4",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "habit_avoid_smoke_time_sentence"),

        .init(id: 31, label: "avoid_sugar", name: "habit_avoid_sugar_name", image: "quit_3",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "habit_avoid_sugar_time_sentence"),

        .init(id: 32, label: "avoid_drink", name: "habit_avoid_drink_name", image: "quit_1",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "habit_avoid_drink_time_sentence"),

        .init(id: 33, label: "avoid_caffeine", name: "habit_avoid_caffeine_name", image: "quit_2",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "habit_avoid_caffeine_time_sentence"),

        .init(id: 34, label: "breath", name: "habit_breath_name", image: "exercise_25",
              categoryId: [0, 1], measureUnits: [.session, .hour], ofGoalSentence: "habit_breath_goal_sentence"),

        .init(id: 35, label: "go_out", name: "habit_go_out_name", image: "hobby_5",
              categoryId: [0, 1], measureUnits: [.time], timeSentence: "habit_go_out_time_sentence"),

        .init(id: 36, label: "gratitude", name: "habit_gratitude_name", image: "exercise_26",
              categoryId: [1], measureUnits: [.session], ofGoalSentence: "habit_gratitude_goal_sentence"),

        .init(id: 37, label: "cold_shower", name: "habit_cold_shower_name", image: "custom_3",
              categoryId: [0, 1], measureUnits: [.time], timeSentence: "habit_cold_shower_time_sentence"),

        .init(id: 38, label: "paint", name: "habit_paint_name", image: "hobby_1",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "habit_paint_goal_sentence"),

        .init(id: 39, label: "swim", name: "habit_swim_name", image: "exercise_15",
              categoryId: [0], measureUnits: [.session, .hour, .km], ofGoalSentence: "habit_swim_goal_sentence"),

        .init(id: 40, label: "bicycle", name: "habit_bicycle_name", image: "exercise_5",
              categoryId: [0], measureUnits: [.session, .hour, .km], ofGoalSentence: "habit_bicycle_goal_sentence"),

        .init(id: 41, label: "track_expenses", name: "habit_track_expenses_name", image: "plan_0",
              categoryId: [5], measureUnits: [.time], timeSentence: "habit_track_expenses_time_sentence"),

        .init(id: 42, label: "videocall_family", name: "habit_videocall_family_name", image: "learn_3",
              categoryId: [2], measureUnits: [.time, .singleTime], timeSentence: "habit_videocall_family_time_sentence"),

        .init(id: 43, label: "avoid_eat_out", name: "habit_avoid_eat_out_name", image: "cook_1",
              categoryId: [4], measureUnits: [.time, .singleTime], timeSentence: "habit_avoid_eat_out_time_sentence"),

        .init(id: 44, label: "plan_meals", name: "habit_plan_meals_name", image: "plan_2",
              categoryId: [3, 5], measureUnits: [.singleTime], timeSentence: "habit_plan_meals_time_sentence"),

        .init(id: 45, label: "write_friends", name: "habit_write_friends_name", image: "love_3",
              categoryId: [2], measureUnits: [.time, .singleTime], timeSentence: "habit_write_friends_time_sentence"),

        .init(id: 46, label: "show_love", name: "habit_show_love_name", image: "love_2",
              categoryId: [2], measureUnits: [.time, .singleTime], timeSentence: "habit_show_love_time_sentence"),

        .init(id: 47, label: "take_trash", name: "habit_take_trash_name", image: "home_7",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "habit_take_trash_time_sentence"),

        .init(id: 48, label: "laundry", name: "habit_laundry_name", image: "home_6",
              categoryId: [5], measureUnits: [.time, .singleTime], timeSentence: "habit_laundry_time_sentence"),

        .init(id: 49, label: "clean_house", name: "habit_clean_house_name", image: "home_3",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "habit_clean_house_time_sentence"),

        .init(id: 50, label: "gardening", name: "habit_gardening_name", image: "home_4",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "habit_gardening_time_sentence"),

        .init(id: 51, label: "avoid_socials", name: "habit_avoid_socials_name", image: "quit_5",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "habit_avoid_socials_time_sentence"),

        .init(id: 52, label: "plan_day", name: "habit_plan_day_name", image: "write_5",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "habit_plan_day_time_sentence"),

        .init(id: 1000, label: "custom", name: "goal_custom_name", image: "project_0",
            categoryId: [6], measureUnits: [.session, .km, .page, .hour, .time, .singleTime])
      ]

    static var allGoals: [GoalType] = [

        // GOALS

        .init(id: 100, label: "goal_marathon", name: "goal_marathon_name", image: "exercise_6",
              measureUnits: [.km], isHabit: false, ofGoalSentence: "goal_marathon_goal_sentence"),

        .init(id: 101, label: "goal_website", name: "goal_website_name", image: "project_4",
              measureUnits: [.hour], isHabit: false, ofGoalSentence: "goal_website_goal_sentence"),

        .init(id: 102, label: "goal_read_book", name: "goal_read_book", image: "book_5",
              measureUnits: [.page], isHabit: false, ofGoalSentence: "goal_read_book_goal_sentence", timeSentence: "Leggerò"),

        .init(id: 1001, label: "goal_custom", name: "goal_custom_name", image: "project_0",
              measureUnits: [.session, .km, .page, .hour, .time, .singleTime], isHabit: false)

    ]

    static var dumbValue: GoalType {
        .init(id: 0, label: "nothing", name: "", image: "", measureUnits: [], isHabit: false)
    }

    static func getWithLabel(_ label: String) -> GoalType {
        return GoalType.allHabits.first(where: { $0.label == label })
            ?? GoalType.allGoals.first(where: { $0.label == label })
            ?? .dumbValue
    }

}

extension GoalType: Equatable {
    
}
