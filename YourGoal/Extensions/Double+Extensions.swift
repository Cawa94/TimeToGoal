//
//  Double+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 05/10/2020.
//

import Foundation

extension Double {

    var stringWithTwoDecimals: String {
        String(format: "%.2f", self)
    }

    var stringWithoutDecimals: String {
        String(format: "%.0f", self)
    }

}
