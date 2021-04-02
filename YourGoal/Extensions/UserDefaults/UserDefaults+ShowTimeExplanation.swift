//
//  UserDefaults+ShowSmartExplanation.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import Foundation

private extension String {

    static let showTimeExplanation = "show_time_explanation"

}

extension UserDefaults {

    var showTimeExplanation: Bool? {
        get { object(forKey: .showTimeExplanation) as? Bool }
        set { setValue(newValue, forKey: .showTimeExplanation) }
    }

}
