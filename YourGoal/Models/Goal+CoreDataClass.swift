//
//  Goal+CoreDataClass.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 01/10/2020.
//
//

import Foundation
import CoreData

@objc(Goal)
public class Goal: NSManagedObject {

    var workOnMonday: Bool {
        self.mondayHours > 0
    }

    var workOnTuesday: Bool {
        self.tuesdayHours > 0
    }

    var workOnWednesday: Bool {
        self.wednesdayHours > 0
    }

    var workOnThursday: Bool {
        self.thursdayHours > 0
    }

    var workOnFriday: Bool {
        self.fridayHours > 0
    }

    var workOnSaturday: Bool {
        self.saturdayHours > 0
    }

    var workOnSunday: Bool {
        self.sundayHours > 0
    }

}
