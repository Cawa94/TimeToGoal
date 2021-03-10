//
//  ActiveSheet.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/11/20.
//

import SwiftUI

enum ActiveSheet: Identifiable { // Used to present controllers

    case tutorial, newGoal

    var id: Int {
        hashValue
    }

}
