//
//  UserDefaults+ShowTutorial.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 14/10/2020.
//

import Foundation

private extension String {

    static let showTutorial = "show_tutorial"

}

extension UserDefaults {

    var showTutorial: Bool? {
        get { object(forKey: .showTutorial) as? Bool }
        set { setValue(newValue, forKey: .showTutorial) }
    }

}
