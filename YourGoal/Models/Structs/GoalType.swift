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

        .init(id: 0, label: "run", name: "Vai a correre", image: "exercise_6",
              categoryId: [0], measureUnits: [.session, .km, .hour], ofGoalSentence: "di corsa"),

        .init(id: 1, label: "walk", name: "Fai una camminata", image: "exercise_13",
              categoryId: [0], measureUnits: [.session, .km, .hour], ofGoalSentence: "di camminata"),

        .init(id: 2, label: "yoga", name: "Fai yoga", image: "exercise_19",
              categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "di yoga"),

        .init(id: 3, label: "study", name: "Studia", image: "learn_0",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di studio"),

        .init(id: 4, label: "new_language", name: "Impara una nuova lingua", image: "learn_2",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di studio"),

        .init(id: 5, label: "reading", name: "Leggi", image: "book_2",
              categoryId: [1, 3], measureUnits: [.session, .page, .hour], ofGoalSentence: "di lettura", timeSentence: "Leggerò"),

        .init(id: 6, label: "drink_water", name: "Bevi", image: "custom_2",
              categoryId: [0], measureUnits: [.time], timeSentence: "Berrò"),

        .init(id: 7, label: "excercise", name: "Fai esercizio", image: "exercise_17",
              categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "di esercizio"),

        .init(id: 8, label: "teeth", name: "Lavati i denti", image: "custom_1",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mi laverò i denti"),

        .init(id: 9, label: "meditate", name: "Medita", image: "exercise_2",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di meditazione"),

        .init(id: 10, label: "eat_helthy", name: "Mangia salutare", image: "vegetable_2",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mangerò in maniera salutare"),

        .init(id: 11, label: "your_bed", name: "Fai il letto", image: "home_1",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Farò il letto"),

        .init(id: 12, label: "wake_early", name: "Svegliati presto", image: "clock_2",
              categoryId: [0, 1, 3], measureUnits: [.singleTime], timeSentence: "Mi sveglierò presto"),

        .init(id: 13, label: "bed_early", name: "Vai a letto presto", image: "mind_0",
              categoryId: [0, 1, 3], measureUnits: [.singleTime], timeSentence: "Andrò a letto presto"),

        .init(id: 14, label: "time_family", name: "Passa del tempo con altre persone", image: "love_1",
              categoryId: [2], measureUnits: [.time, .hour], ofGoalSentence: "passate con altre persone", timeSentence: "Passerò il mio tempo con altre persone"),

        .init(id: 15, label: "time_alone", name: "Passa del tempo da solo", image: "music_2",
              categoryId: [1], measureUnits: [.time, .hour], ofGoalSentence: "passate con me stesso", timeSentence: "Passerò il mio tempo con me stesso"),

        .init(id: 16, label: "writing", name: "Scrivi un post", image: "write_7",
              categoryId: [3], measureUnits: [.session, .hour, .page], ofGoalSentence: "di scrittura"),

        .init(id: 17, label: "play_instrment", name: "Suona uno strumento", image: "music_9",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di suonata"),

        .init(id: 18, label: "cook", name: "Cucina", image: "cook_0",
              categoryId: [5], measureUnits: [.time], timeSentence: "Cucinerò"),

        .init(id: 19, label: "sing", name: "Canta", image: "music_6",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di canto"),

        .init(id: 20, label: "project", name: "Lavora sul tuo progetto", image: "project_5",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di lavoro"),

        .init(id: 21, label: "podcast", name: "Ascolta un podcast", image: "music_0",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di ascolto"),

        .init(id: 22, label: "something_new", name: "Prova qualcosa di nuovo", image: "adventure_1",
              categoryId: [3], measureUnits: [.singleTime], timeSentence: "Proverò qualcosa di nuovo"),

        .init(id: 23, label: "eat_fruit", name: "Mangia la frutta", image: "fruit_0",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mangerò la frutta"),

        .init(id: 24, label: "eat_vegetables", name: "Mangia la verdura", image: "vegetable_0",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mangerò la verdura"),

        .init(id: 25, label: "visualization", name: "Pratica la visualizzazione", image: "mind_1",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di visualizzazione"),

        .init(id: 26, label: "affirmations", name: "Pratica le affermazioni", image: "mind_7",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di affermazioni"),

        .init(id: 27, label: "journal", name: "Scrivi nel diario", image: "write_2",
              categoryId: [1, 3], measureUnits: [.session, .singleTime], ofGoalSentence: "di scrittura", timeSentence: "Scriverò nel mio diario"),

        .init(id: 28, label: "self_reflects", name: "Rifletti sulla giornata", image: "mind_6",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "Rifletterò sulla giornata"),

        .init(id: 29, label: "plan_week", name: "Pianifica la settimana", image: "plan_1",
              categoryId: [3], measureUnits: [.singleTime], timeSentence: "Pianificherò la settimana"),

        .init(id: 30, label: "avoid_smoke", name: "Evita di fumare", image: "quit_4",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "Eviterò di fumare"),

        .init(id: 31, label: "avoid_sugar", name: "Evita di mangiare zuccheri", image: "quit_3",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "Eviterò di mangiare zuccheri"),

        .init(id: 32, label: "avoid_drink", name: "Evita di bere", image: "quit_1",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "Eviterò di bere"),

        .init(id: 33, label: "avoid_caffeine", name: "Evita la caffeina", image: "quit_2",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "Eviterò la caffeina"),

        .init(id: 34, label: "breath", name: "Pratica la respirazione", image: "exercise_25",
              categoryId: [0, 1], measureUnits: [.session, .hour], ofGoalSentence: "di respirazione"),

        .init(id: 35, label: "go_out", name: "Esci di casa", image: "hobby_5",
              categoryId: [0, 1], measureUnits: [.time], timeSentence: "Uscirò di casa"),

        .init(id: 36, label: "gratitude", name: "Pratica la gratitudine", image: "exercise_26",
              categoryId: [1], measureUnits: [.session], ofGoalSentence: "di gratitudine"),

        .init(id: 37, label: "cold_shower", name: "Doccia fredda", image: "custom_3",
              categoryId: [0, 1], measureUnits: [.time], timeSentence: "Mi farò la doccia fredda"),

        .init(id: 38, label: "paint", name: "Dipingi", image: "hobby_1",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di pittura"),

        .init(id: 39, label: "swim", name: "Nuota", image: "exercise_15",
              categoryId: [0], measureUnits: [.session, .hour, .km], ofGoalSentence: "di nuoto"),

        .init(id: 40, label: "bicycle", name: "Vai in bicicletta", image: "exercise_5",
              categoryId: [0], measureUnits: [.session, .hour, .km], ofGoalSentence: "in bicicletta"),

        .init(id: 41, label: "track_expenses", name: "Traccia le spese", image: "plan_0",
              categoryId: [5], measureUnits: [.time], timeSentence: "Traccerò le mie spese"),

        .init(id: 42, label: "videocall_family", name: "Chiama la tua famiglia", image: "learn_3",
              categoryId: [2], measureUnits: [.time], timeSentence: "Chiamerò la mia famiglia"),

        .init(id: 43, label: "avoid_eat_out", name: "Evita di mangiare fuori", image: "cook_1",
              categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò di mangiare fuori"),

        .init(id: 44, label: "plan_meals", name: "Pianifica il diario alimentare", image: "plan_2",
              categoryId: [3, 5], measureUnits: [.singleTime], timeSentence: "Pianificherò il diario alimentare"),

        .init(id: 45, label: "write_friends", name: "Scrivi agli amici", image: "love_3",
              categoryId: [2], measureUnits: [.time], timeSentence: "Scriverò agli amici"),

        .init(id: 46, label: "show_love", name: "Sii affettuoso", image: "love_2",
              categoryId: [2], measureUnits: [.time], timeSentence: "Sarò affettuoso"),

        .init(id: 47, label: "take_trash", name: "Butta la spazzatura", image: "home_7",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Butterò la spazzatura"),

        .init(id: 48, label: "laundry", name: "Fai la lavatrice", image: "home_6",
              categoryId: [5], measureUnits: [.time], timeSentence: "Farò la lavatrice"),

        .init(id: 49, label: "clean_house", name: "Pulisci la casa", image: "home_3",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Pulirò la casa"),

        .init(id: 50, label: "gardening", name: "Cura il giardino", image: "home_4",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Curerò il giardino"),

        .init(id: 51, label: "avoid_socials", name: "Evita i social media", image: "quit_5",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "Eviterò i social media"),

        .init(id: 52, label: "plan_day", name: "Pianifica la giornata", image: "write_5",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "Pianificherò la giornata"),

        .init(id: 53, label: "custom", name: "Personalizzato", image: "project_0",
              categoryId: [6], measureUnits: [.session, .km, .page, .hour, .time, .singleTime]),

      ]

    static var allGoals: [GoalType] = [

        // GOALS

        .init(id: 100, label: "goal_run", name: "Cura il giardino", image: "exercise_0",
              measureUnits: [.singleTime], isHabit: false),

        .init(id: 101, label: "goal_some", name: "Evita i social media", image: "exercise_1",
              measureUnits: [.singleTime], isHabit: false),

        .init(id: 102, label: "goal_some_2", name: "Pianifica la giornata", image: "exercise_2",
              measureUnits: [.singleTime], isHabit: false),

        .init(id: 103, label: "goal_some_3", name: "Personalizzato", image: "exercise_3",
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

extension GoalType {

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
