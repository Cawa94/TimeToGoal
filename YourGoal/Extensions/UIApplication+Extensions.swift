//
//  UIApplication+Extensions.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 10/10/2020.
//

import Foundation
import UIKit

extension UIApplication {

    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
