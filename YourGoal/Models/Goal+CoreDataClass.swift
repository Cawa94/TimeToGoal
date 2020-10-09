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

    var updatedCompletionDate: Date {
        let dayHours = [sundayHours, mondayHours, tuesdayHours, wednesdayHours, thursdayHours, fridayHours, saturdayHours]
        var daysRequired = -1
        var decreasingTotal = timeRequired
        var dayNumber = Date().dayNumber

        while decreasingTotal > 0 {
            daysRequired += 1
            decreasingTotal -= dayHours[dayNumber - 1]
            dayNumber += 1
            if dayNumber == 8 {
                dayNumber = 1
            }
        }

        return Date().adding(days: daysRequired)
    }

}
