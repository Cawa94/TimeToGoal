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
    static var goalColor = Color("orangeGoal")
    static var rainbow: [Color] = [.orangeGoal, .yellowGoal, .greenGoal, .blueGoal]
    static var rainbowClosed: [Color] = rainbow + [.orangeGoal]

}

extension Color {

    // Black
    static let blackBackground = Color("blackBackground")
    static let blackShadow     = Color.black.opacity(0.3)

    // Gray
    static let grayFields      = Color("grayFields")
    static let grayGoal        = Color("grayGoal")
    static let grayGradient1   = Color("grayGradient1")
    static let grayGradient2   = Color("grayGradient2")

    // Blue
    static let blueGoal        = Color("blueGoal")
    static let blueGradient1   = Color("blueGradient1")
    static let blueGradient2   = Color("blueGradient2")

    // Green
    static let greenGoal       = Color("greenGoal")
    static let greenGradient1  = Color("greenGradient1")
    static let greenGradient2  = Color("greenGradient2")

    // Orange
    static let orangeGoal      = Color("orangeGoal")
    static let orangeGradient1 = Color("orangeGradient1")
    static let orangeGradient2 = Color("orangeGradient2")

    // Purple
    static let purpleGoal      = Color("purpleGoal")
    static let purpleGradient1 = Color("purpleGradient1")
    static let purpleGradient2 = Color("purpleGradient2")

    // Yellow
    static let yellowGoal      = Color("yellowGoal")
    static let yellowGradient1 = Color("yellowGradient1")
    static let yellowGradient2 = Color("yellowGradient2")

}

extension UIColor {

    static let pageBackground = UIColor.white
    static var goalColor = UIColor.named("orangeGoal")

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
