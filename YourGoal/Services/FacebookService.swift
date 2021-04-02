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
        #if RELEASE
            let parameters = [
                AppEvents.ParameterName.contentType.rawValue: content
            ]

            AppEvents.logEvent(.viewedContent, parameters: parameters)
        #endif
    }

    // User completed a full week/month of an habit
    static func logAchieveLevelEvent(level: String) {
        #if RELEASE
            let parameters = [
                AppEvents.ParameterName.level.rawValue: level
            ]

            AppEvents.logEvent(.achievedLevel, parameters: parameters)
        #endif
    }

    // User created his first habit. ContentId = goalTypeId
    static func logCompleteTutorialEvent(contentId: String) {
        #if RELEASE
            let parameters = [
                AppEvents.ParameterName.contentID.rawValue: contentId
            ]

            AppEvents.logEvent(.completedTutorial, parameters: parameters)
        #endif
    }

}
