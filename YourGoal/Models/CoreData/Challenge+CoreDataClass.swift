//
//  Challenge+CoreDataClass.swift
//  
//
//  Created by Yuri Cavallin on 17/2/21.
//
//

import Foundation
import CoreData

@objc(Challenge)
public class Challenge: NSManagedObject {

    var percentageCompleted: Double {
        if let profileChallenge = ProfileChallenge.allValues.first(where: { $0.id == self.id }) {
            return min((self.progressMade / profileChallenge.goalToReach) * 100, 100)
        }
        return 0
    }

    var isCompleted: Bool {
        percentageCompleted >= 0
    }

}
