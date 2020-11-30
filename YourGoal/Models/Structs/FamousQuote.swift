//
//  FamousQuote.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/11/20.
//

import Foundation
import SwiftUI

struct FamousQuote {

    static var possibleValues = 50

    var sentence: String
    var author: String

    static func getOneRandom() -> FamousQuote {
        let randomIndex = Array(1...FamousQuote.possibleValues).randomElement()
        return FamousQuote(sentence: "\"\("motivational_sentence_\(randomIndex ?? 0)".localized())\"",
                           author: "motivational_author_\(randomIndex ?? 0)".localized())
    }

}
