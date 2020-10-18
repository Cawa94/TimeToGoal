//
//  Color+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 01/10/2020.
//

import Foundation
import SwiftUI

extension Color {

    static let pageBackground = Color.white
    static var goalColor = Color(UserDefaults.standard.goalColor ?? "orangeGoal")

}

extension Color {

    // Black
    static let blackBackground = Color("blackBackground")

    // Gray
    static let grayFields      = Color("grayFields")

}

extension UIColor {

    static let pageBackground = UIColor.white
    static var goalColor = UIColor.named(UserDefaults.standard.goalColor ?? "orangeGoal")

}

extension UIColor {

    // Black
    static let blackBackground = UIColor.named("blackBackground")

    // Gray
    static let grayFields      = UIColor.named("grayFields")

    private static func named(_ name: String) -> UIColor {
        return UIColor(named: name) ?? UIColor()
    }

}
