//
//  Goals+Extension.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/1/21.
//

import Foundation

extension Sequence where Element == Goal {

    func goalsWorkOn(date: Date) -> [Goal] {
        self.filter { $0.workOn(date: date) }
    }

}
