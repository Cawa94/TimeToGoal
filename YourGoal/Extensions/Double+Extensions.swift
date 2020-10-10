//
//  Double+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 05/10/2020.
//

import Foundation

extension Double {

    var stringWithTwoDecimals: String {
        self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }

    var stringWithoutDecimals: String {
        String(format: "%.0f", self)
    }

}
