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
        let dayHours = [sundayHours.asHoursAndMinutes,
                        mondayHours.asHoursAndMinutes,
                        tuesdayHours.asHoursAndMinutes,
                        wednesdayHours.asHoursAndMinutes,
                        thursdayHours.asHoursAndMinutes,
                        fridayHours.asHoursAndMinutes,
                        saturdayHours.asHoursAndMinutes]

        var daysRequired = -1
        var decreasingTotal = self.timeRequired.asHoursAndMinutes.remove(self.timeCompleted.asHoursAndMinutes)
        var dayNumber = Date().dayNumber

        while decreasingTotal > Date().zeroHours {
            daysRequired += 1
            decreasingTotal = decreasingTotal.remove(dayHours[dayNumber - 1])
            dayNumber += 1
            if dayNumber == 8 {
                dayNumber = 1
            }
        }

        self.daysRequired = Int16(daysRequired)

        return Date().adding(days: daysRequired)
    }

    var isCompleted: Bool {
        return !(self.timeRequired.asHoursAndMinutes.remove(self.timeCompleted.asHoursAndMinutes) > Date().zeroHours)
    }

    var isValid: Bool {
        if !(name?.isEmpty ?? true), timeRequired != 0, atLeastOneDayWorking {
            return true
        }
        return false
    }

    var atLeastOneDayWorking: Bool {
        mondayHours != 0 || tuesdayHours != 0 || wednesdayHours != 0 || thursdayHours != 0
            || fridayHours != 0 || saturdayHours != 0 || sundayHours != 0
    }

}
