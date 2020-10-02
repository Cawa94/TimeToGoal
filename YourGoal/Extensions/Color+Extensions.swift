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
    static let goalColor = Color.greenText

}

extension Color {

    // Black
    static let blackBackground = Color("blackBackground")

    // Gray
    static let grayFields      = Color("grayFields")

    // Green
    static let greenText       = Color("greenText")

}

extension UIColor {

    static let pageBackground = UIColor.white
    static let goalColor = UIColor.greenText

}

extension UIColor {

    // Black
    static let blackBackground = UIColor.named("blackBackground")

    // Gray
    static let grayFields      = UIColor.named("grayFields")

    // Green
    static let greenText       = UIColor.named("greenText")

    private static func named(_ name: String) -> UIColor {
        return UIColor(named: name) ?? UIColor()
    }

}
