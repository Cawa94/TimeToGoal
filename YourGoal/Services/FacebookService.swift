//
//  FacebookService.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 31/3/21.
//

import Foundation
import FBSDKCoreKit

struct FacebookService {

    static func logViewContentEvent(content: String) {
        let parameters = [
            AppEvents.ParameterName.contentType.rawValue: content
        ]

        AppEvents.logEvent(.viewedContent, parameters: parameters)
    }

}
