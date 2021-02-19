//
//  ProfileChallenge.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 17/2/21.
//

import Foundation

struct ProfileChallenge: Identifiable {

    var id: Int64
    var name: String
    var image: String
    var goalToReach: Double

    init(id: Int64, name: String, image: String, goalToReach: Double) {
        self.id = id
        self.name = name
        self.image = image
        self.goalToReach = goalToReach
    }

    static var allValues: [ProfileChallenge] = [
        .init(id: 0, name: "Crea la tua prima abitudine SMART", image: "004-medal", goalToReach: 1),
        .init(id: 1, name: "Crea il tuo primo obiettivo SMART", image: "005-badge", goalToReach: 1),
        .init(id: 2, name: "Rinnova un'abitudine 50 volte", image: "008-gold cup", goalToReach: 50),
        .init(id: 3, name: "Rinnova un'abitudine 25 volte", image: "009-silver cup", goalToReach: 25),
        .init(id: 4, name: "Rinnova un'abitudine 10 volte", image: "010-bronze cup", goalToReach: 10),
        .init(id: 5, name: "Scegli un avatar per il tuo profilo", image: "012-shield", goalToReach: 1),
        .init(id: 6, name: "Inserisci il tuo nome", image: "020-badge", goalToReach: 1),
        .init(id: 7, name: "Traccia un'abitudine 100 volte", image: "001-gold medal", goalToReach: 100),
        .init(id: 8, name: "Traccia un'abitudine 50 volte", image: "002-silver medal", goalToReach: 50),
        .init(id: 9, name: "Traccia un'abitudine 20 volte", image: "003-bronze medal", goalToReach: 20),
        .init(id: 10, name: "Completa un obiettivo SMART", image: "006-ribbon", goalToReach: 1),
        .init(id: 11, name: "Crea 5 abitudini SMART", image: "007-star", goalToReach: 5),
        .init(id: 12, name: "Crea 5 obiettivi SMART", image: "011-medal", goalToReach: 5),
        .init(id: 13, name: "Scrivi 100 pagine nel tuo diario", image: "017-gold medal", goalToReach: 100),
        .init(id: 14, name: "Scrivi 50 pagine nel tuo diario", image: "018-silver medal", goalToReach: 50),
        .init(id: 15, name: "Scrivi 20 pagine nel tuo diario", image: "019-bronze medal", goalToReach: 20)
    ]

}
