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
        .init(id: 0, name: "challenge_first_name", image: "004-medal", goalToReach: 1),
        .init(id: 1, name: "challenge_second_name", image: "005-badge", goalToReach: 1),
        .init(id: 2, name: "challenge_third_name", image: "008-gold cup", goalToReach: 50),
        .init(id: 3, name: "challenge_fourth_name", image: "009-silver cup", goalToReach: 25),
        .init(id: 4, name: "challenge_fifth_name", image: "010-bronze cup", goalToReach: 10),
        .init(id: 5, name: "challenge_sixth_name", image: "012-shield", goalToReach: 1),
        .init(id: 6, name: "challenge_seventh_name", image: "020-badge", goalToReach: 1),
        .init(id: 7, name: "challenge_eigth_name", image: "001-gold medal", goalToReach: 100),
        .init(id: 8, name: "challenge_nineth_name", image: "002-silver medal", goalToReach: 50),
        .init(id: 9, name: "challenge_tenth_name", image: "003-bronze medal", goalToReach: 20),
        .init(id: 10, name: "challenge_eleventh_name", image: "006-ribbon", goalToReach: 1),
        .init(id: 11, name: "challenge_twelveth_name", image: "007-star", goalToReach: 5),
        .init(id: 12, name: "challenge_thirtheenth_name", image: "011-medal", goalToReach: 5),
        .init(id: 13, name: "challenge_fourteenth_name", image: "017-gold medal", goalToReach: 100),
        .init(id: 14, name: "challenge_fifteenth_name", image: "018-silver medal", goalToReach: 50),
        .init(id: 15, name: "challenge_sixteenth_name", image: "019-bronze medal", goalToReach: 20)
    ]

}
