//
//  Goal+CoreDataClass.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 01/10/2020.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Goal)
public class Goal: NSManagedObject {

    var goalType: GoalType {
        get {
            guard let type = self.type
                else { return .custom}
            return GoalType(rawValue: type) ?? .custom
        }
        set {
            self.type = newValue.rawValue
        }
    }

    var goalColor: Color {
        Color(color ?? "orangeColor")
    }

    var workOnMonday: Bool {
        self.monday > 0
    }

    var workOnTuesday: Bool {
        self.tuesday > 0
    }

    var workOnWednesday: Bool {
        self.wednesday > 0
    }

    var workOnThursday: Bool {
        self.thursday > 0
    }

    var workOnFriday: Bool {
        self.friday > 0
    }

    var workOnSaturday: Bool {
        self.saturday > 0
    }

    var workOnSunday: Bool {
        self.sunday > 0
    }

    var updatedCompletionDate: Date {
        let dayHours = [sunday.asHoursAndMinutes,
                        monday.asHoursAndMinutes,
                        tuesday.asHoursAndMinutes,
                        wednesday.asHoursAndMinutes,
                        thursday.asHoursAndMinutes,
                        friday.asHoursAndMinutes,
                        saturday.asHoursAndMinutes]

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
        monday != 0 || tuesday != 0 || wednesday != 0 || thursday != 0
            || friday != 0 || saturday != 0 || sunday != 0
    }

    var circleGradientColors: [Color] {
        if self.isValid {
            switch self.color {
            case "orangeGoal":
                return [.orangeGoal, .orangeGradient1, .orangeGradient2, .orangeGradient2, .orangeGradient1, .orangeGoal]
            case "blueGoal":
                return [.blueGoal, .blueGradient1, .blueGradient2, .blueGradient2, .blueGradient1, .blueGoal]
            case "greenGoal":
                return [.greenGoal, .greenGradient1, .greenGradient2, .greenGradient2, .greenGradient1, .greenGoal]
            case "purpleGoal":
                return [.purpleGoal, .purpleGradient1, .purpleGradient2, .purpleGradient2, .purpleGradient1, .purpleGoal]
            case "yellowGoal":
                return [.yellowGoal, .yellowGradient1, .yellowGradient2, .yellowGradient2, .yellowGradient1, .yellowGoal]
            case "grayGoal":
                return [.grayGoal, .grayGradient1, .grayGradient2, .grayGradient2, .grayGradient1, .grayGoal]
            default:
                return []
            }
        } else {
            return Color.rainbowClosed
        }
    }

    var rectGradientColors: [Color] {
        switch self.color {
        case "orangeGoal":
            return [.orangeGoal, .orangeGradient1, .orangeGradient2]
        case "blueGoal":
            return [.blueGoal, .blueGradient1, .blueGradient2]
        case "greenGoal":
            return [.greenGoal, .greenGradient1, .greenGradient2]
        case "purpleGoal":
            return [.purpleGoal, .purpleGradient1, .purpleGradient2]
        case "yellowGoal":
            return [.yellowGoal, .yellowGradient1, .yellowGradient2]
        case "grayGoal":
            return [.grayGoal, .grayGradient1, .grayGradient2]
        default:
            return [.orangeGoal, .orangeGradient1, .orangeGradient2]
        }
    }

}
