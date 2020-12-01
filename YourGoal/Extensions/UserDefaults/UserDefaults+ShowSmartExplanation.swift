//
//  UserDefaults+ShowSmartExplanation.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import Foundation

private extension String {

    static let showSmartExplanation = "show_smart_explanation"

}

extension UserDefaults {

    var showSmartExplanation: Bool? {
        get { object(forKey: .showSmartExplanation) as? Bool }
        set { setValue(newValue, forKey: .showSmartExplanation) }
    }

}
