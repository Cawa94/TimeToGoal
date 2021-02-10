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

    static let allValues: [GoalType] = [
        .init(id: 0, label: "run", name: "Vai a correre", image: "run_0",
              categoryId: [0], measureUnits: [.session, .km, .hour], ofGoalSentence: "di corsa"),
        
        .init(id: 1, label: "walk", name: "Fai una camminata", image: "run_1",
              categoryId: [0], measureUnits: [.session, .km, .hour], ofGoalSentence: "di camminata"),
        
        .init(id: 2, label: "yoga", name: "Fai yoga", image: "run_2",
              categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "di yoga"),
        
        .init(id: 3, label: "study", name: "Studia", image: "run_0",
              categoryId: [1, 3], measureUnits: [.session, .hour], ofGoalSentence: "di studio"),
        
        .init(id: 4, label: "new_language", name: "Impara una nuova lingua", image: "run_1",
              categoryId: [1, 3], measureUnits: [.session, .hour], ofGoalSentence: "di studio"),
        
        .init(id: 5, label: "reading", name: "Leggi", image: "run_2",
              categoryId: [1, 3], measureUnits: [.session, .page, .hour], ofGoalSentence: "di lettura", timeSentence: "Leggerò"),
        
        .init(id: 6, label: "drink_water", name: "Bevi", image: "run_0",
              categoryId: [0], measureUnits: [.time], timeSentence: "Berrò"),
        
        .init(id: 7, label: "excercise", name: "Fai esercizio", image: "run_1",
              categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "di esercizio"),
        
        .init(id: 8, label: "teeth", name: "Lavati i denti", image: "run_2",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mi laverò i denti"),
        
        .init(id: 9, label: "meditate", name: "Medita", image: "run_0",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di meditazione"),
        
        .init(id: 10, label: "eat_helthy", name: "Mangia salutare", image: "run_1",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mangerò in maniera salutare"),
        
        .init(id: 11, label: "your_bed", name: "Fai il letto", image: "run_2",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Farò il letto"),
        
        .init(id: 12, label: "wake_early", name: "Svegliati presto", image: "run_0",
              categoryId: [0, 1, 3], measureUnits: [.singleTime], timeSentence: "Mi sveglierò presto"),
        
        .init(id: 13, label: "bed_early", name: "Vai a letto presto", image: "run_1",
              categoryId: [0, 1, 3], measureUnits: [.singleTime], timeSentence: "Andrò a letto presto"),
        
        .init(id: 14, label: "time_family", name: "Passa del tempo con altre persone", image: "run_2",
              categoryId: [2], measureUnits: [.time, .hour], ofGoalSentence: "passate con altre persone", timeSentence: "Passerò il mio tempo con altre persone"),
        
        .init(id: 15, label: "time_alone", name: "Passa del tempo da solo", image: "run_0",
              categoryId: [1, 3], measureUnits: [.time, .hour], ofGoalSentence: "passate con me stesso", timeSentence: "Passerò il mio tempo con me stesso"),
        
        .init(id: 16, label: "writing", name: "Scrivi", image: "run_1",
              categoryId: [3], measureUnits: [.session, .hour, .page], ofGoalSentence: "di scrittura"),
        
        .init(id: 17, label: "play_instrment", name: "Suona uno strumento", image: "run_2",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di suonata"),
        
        .init(id: 18, label: "cook", name: "Cucina", image: "run_0",
              categoryId: [5], measureUnits: [.time], timeSentence: "Cucinerò"),
        
        .init(id: 19, label: "sing", name: "Canta", image: "run_1",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di canto"),
        
        .init(id: 20, label: "project", name: "Lavora sul tuo progetto", image: "run_2",
              categoryId: [1, 3], measureUnits: [.session, .hour], ofGoalSentence: "di lavoro"),
        
        .init(id: 21, label: "podcast", name: "Ascolta un podcast", image: "run_0",
              categoryId: [1, 3], measureUnits: [.session, .hour], ofGoalSentence: "di ascolto"),
        
        .init(id: 22, label: "something_new", name: "Prova qualcosa di nuovo", image: "run_1",
              categoryId: [3], measureUnits: [.singleTime], timeSentence: "Proverò qualcosa di nuovo"),
        
        .init(id: 23, label: "eat_fruit", name: "Mangia la frutta", image: "run_2",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mangerò la frutta"),
        
        .init(id: 24, label: "eat_vegetables", name: "Mangia la verdura", image: "run_0",
              categoryId: [0], measureUnits: [.time], timeSentence: "Mangerò la verdura"),
        
        .init(id: 25, label: "visualization", name: "Pratica la visualizzazione", image: "run_1",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di meditazione"),
        
        .init(id: 26, label: "affirmations", name: "Pratica le affermazioni", image: "run_2",
              categoryId: [1], measureUnits: [.session, .hour], ofGoalSentence: "di affermazioni"),
        
        .init(id: 27, label: "journal", name: "Scrivi nel diario", image: "run_0",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "Scriverò nel mio diario"),
        
        .init(id: 28, label: "self_reflects", name: "Rifletti sulla giornata", image: "run_1",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "Rifletterò sulla giornata"),
        
        .init(id: 29, label: "plan_week", name: "Pianifica la settimana", image: "run_2",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "Pianificherò la settimana"),
        
        .init(id: 30, label: "avoid_smoke", name: "Evita di fumare", image: "run_2",
              categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò di fumare"),
        
        .init(id: 31, label: "avoid_sugar", name: "Evita di mangiare zuccheri", image: "run_2",
              categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò di mangiare zuccheri"),
        
        .init(id: 32, label: "avoid_drink", name: "Evita di bere", image: "run_2",
              categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò di bere"),
        
        .init(id: 33, label: "avoid_caffeine", name: "Evita la caffeina", image: "run_2",
              categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò la caffeina"),
        
        .init(id: 34, label: "breath", name: "Pratica la respirazione", image: "run_2",
              categoryId: [0, 1], measureUnits: [.session, .hour], ofGoalSentence: "di respirazione"),
        
        .init(id: 35, label: "go_out", name: "Esci di casa", image: "run_2",
              categoryId: [0, 1], measureUnits: [.time], timeSentence: "Uscirò di casa"),
        
        .init(id: 36, label: "gratitude", name: "Pratica la gratitudine", image: "run_2",
              categoryId: [1], measureUnits: [.session], ofGoalSentence: "di gratitudine"),
        
        //.init(id: 37, label: "write", name: "Scrivi", image: "run_2",
        //categoryId: [0], measureUnits: [.session, .km], ofGoalSentence: "di corsa"),
        
        .init(id: 38, label: "paint", name: "Dipingi", image: "run_2",
              categoryId: [3], measureUnits: [.session, .hour], ofGoalSentence: "di pittura"),
        
        .init(id: 39, label: "swim", name: "Nuota", image: "run_2",
              categoryId: [0], measureUnits: [.session, .hour, .km], ofGoalSentence: "di nuoto"),
        
        .init(id: 40, label: "bicycle", name: "Vai in bicicletta", image: "run_2",
              categoryId: [0], measureUnits: [.session, .hour, .km], ofGoalSentence: "in bicicletta"),
        
        .init(id: 41, label: "track_expenses", name: "Traccia le spese", image: "run_2",
              categoryId: [3, 5], measureUnits: [.time], timeSentence: "Traccerò le mie spese"),
        
        //.init(id: 42, label: "avoid_spending", name: "Evita spese superflue", image: "run_2",
        //      categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò spese superflue"),
        
        .init(id: 43, label: "avoid_eat_out", name: "Evita di mangiare fuori", image: "run_2",
              categoryId: [4], measureUnits: [.time], timeSentence: "Eviterò di mangiare fuori"),
        
        .init(id: 44, label: "plan_meals", name: "Pianifica il diario alimentare", image: "run_2",
              categoryId: [3, 5], measureUnits: [.singleTime], timeSentence: "Pianificherò il diario alimentare"),
        
        .init(id: 45, label: "write_friends", name: "Scrivi agli amici", image: "run_2",
              categoryId: [2], measureUnits: [.time], timeSentence: "Scriverò agli amici"),
        
        .init(id: 46, label: "show_love", name: "Sii affettuoso", image: "run_2",
              categoryId: [2], measureUnits: [.time], timeSentence: "Sarò affettuoso"),
        
        .init(id: 47, label: "take_trash", name: "Butta la spazzatura", image: "run_2",
              categoryId: [5], measureUnits: [.time], timeSentence: "Butterò la spazzatura"),
        
        .init(id: 48, label: "laundry", name: "Fai la lavatrice", image: "run_2",
              categoryId: [5], measureUnits: [.time], timeSentence: "Farò la lavatrice"),
        
        .init(id: 49, label: "clean_house", name: "Pulisci la casa", image: "run_2",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Pulirò la casa"),
        
        .init(id: 50, label: "gardening", name: "Cura il giardino", image: "run_2",
              categoryId: [5], measureUnits: [.singleTime], timeSentence: "Curerò il giardino"),
        
        .init(id: 51, label: "avoid_socials", name: "Evita i social media", image: "run_2",
              categoryId: [4], measureUnits: [.singleTime], timeSentence: "Eviterò i social media"),
        
        .init(id: 52, label: "plan_day", name: "Pianifica la giornata", image: "run_2",
              categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "Pianificherò la giornata"),
        
        .init(id: 53, label: "custom", name: "Personalizzato", image: "run_2",
              categoryId: [5], measureUnits: [.session, .km, .page, .hour, .time, .singleTime])

      ]

    static var dumbValue: GoalType {
        .init(id: 0, label: "nothing", name: "", image: "", measureUnits: [], isHabit: false)
    }

    static func getWithLabel(_ label: String) -> GoalType {
        return GoalType.allValues.first(where: { $0.label == label }) ?? .dumbValue
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
