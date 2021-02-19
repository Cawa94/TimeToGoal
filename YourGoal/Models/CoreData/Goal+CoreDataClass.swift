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
                else { return .dumbValue }
            return GoalType.getWithLabel(type)
        }
        set {
            self.type = newValue.label
        }
    }

    var timeTrackingType: TimeTrackingType {
        return MeasureUnit.getFrom(customTimeMeasure ?? "").timeTrackingType
    }

    var goalColor: Color {
        Color(color ?? "orangeColor")
    }

    var goalUIColor: UIColor {
        UIColor(named: color ?? "orangeColor") ?? .goalColor
    }

    var goalIcon: String {
        icon ?? goalType.image
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
        if timeRequired != 0, atLeastOneDayWorking {
            if timeTrackingType == .hoursWithMinutes {
                let dayHours = [sunday.asHoursAndMinutes, monday.asHoursAndMinutes, tuesday.asHoursAndMinutes,
                                wednesday.asHoursAndMinutes, thursday.asHoursAndMinutes, friday.asHoursAndMinutes,
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
            } else {
                let dayTimes = [sunday, monday, tuesday, wednesday, thursday, friday, saturday]

                var daysRequired = -1
                var decreasingTotal = self.timeRequired - self.timeCompleted
                var dayNumber = Date().dayNumber

                while decreasingTotal > 0 {
                    daysRequired += 1
                    decreasingTotal = decreasingTotal - dayTimes[dayNumber - 1]
                    dayNumber += 1
                    if dayNumber == 8 {
                        dayNumber = 1
                    }
                }

                self.daysRequired = Int16(daysRequired)

                return Date().adding(days: daysRequired)
            }
        } else {
            return Date()
        }
    }

    var isCompleted: Bool {
        switch timeTrackingType {
        case .hoursWithMinutes:
            return !(self.timeRequired.asHoursAndMinutes.remove(self.timeCompleted.asHoursAndMinutes) > Date().zeroHours)
        default:
            return !(self.timeRequired - self.timeCompleted > 0)
        }
    }

    var isValid: Bool {
        return createdAt != nil
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
            case "redGoal":
                return [.redGoal, .redGradient1, .redGradient2, .redGradient2, .redGradient1, .redGoal]
            case "grayGoal":
                return [.grayGoal, .grayGradient1, .grayGradient2, .grayGradient2, .grayGradient1, .grayGoal]
            case "yellowGoal":
                return [.yellowGoal, .yellowGradient1, .yellowGradient2, .yellowGradient2, .yellowGradient1, .yellowGoal]
            case "brownGoal":
                return [.brownGoal, .brownGradient1, .brownGradient2, .brownGradient2, .brownGradient1, .brownGoal]
            case "pinkGoal":
                return [.pinkGoal, .pinkGradient1, .pinkGradient2, .pinkGradient2, .pinkGradient1, .pinkGoal]
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
        case "redGoal":
            return [.redGoal, .redGradient1, .redGradient2]
        case "grayGoal":
            return [.grayGoal, .grayGradient1, .grayGradient2]
        case "yellowGoal":
            return [.yellowGoal, .yellowGradient1, .yellowGradient2]
        case "brownGoal":
            return [.brownGoal, .brownGradient1, .brownGradient2]
        case "pinkGoal":
            return [.pinkGoal, .pinkGradient1, .pinkGradient2]
        default:
            return [.orangeGoal, .orangeGradient1, .orangeGradient2]
        }
    }

    var smallRectGradientColors: [Color] {
        switch self.color {
        case "orangeGoal":
            return [.orangeGradient1, .orangeGoal, .orangeGradient1]
        case "blueGoal":
            return [.blueGradient1, .blueGoal, .blueGradient1]
        case "greenGoal":
            return [.greenGradient1, .greenGoal, .greenGradient1]
        case "purpleGoal":
            return [.purpleGradient1, .purpleGoal, .purpleGradient1]
        case "redGoal":
            return [.redGradient1, .redGoal, .redGradient1]
        case "grayGoal":
            return [.grayGradient1, .grayGoal, .grayGradient1]
        case "yellowGoal":
            return [.yellowGradient1, .yellowGoal, .yellowGradient1]
        case "brownGoal":
            return [.brownGradient1, .brownGoal, .brownGradient1]
        case "pinkGoal":
            return [.pinkGradient1, .pinkGoal, .pinkGradient1]
        default:
            return [.orangeGradient1, .orangeGoal, .orangeGradient1]
        }
    }

    func dayPercentageAt(date: Date) -> CGFloat {
        let toWork: Double
        switch date.dayNumber {
        case 1:
            toWork = max(sunday, 1)
        case 2:
            toWork = max(monday, 1)
        case 3:
            toWork = max(tuesday, 1)
        case 4:
            toWork = max(wednesday, 1)
        case 5:
            toWork = max(thursday, 1)
        case 6:
            toWork = max(friday, 1)
        case 7:
            toWork = max(saturday, 1)
        default:
            toWork = max(monday, 1)
        }

        var worked: Double = 0
        for progress in self.progress?.compactMap { $0 as? Progress }.filter({ $0.date?.formattedAsDateString == date.formattedAsDateString }) ?? [] {
            worked += progress.hoursOfWork
        }

        return CGFloat(worked/toWork * 100)
    }

    func workOn(date: Date) -> Bool {
        switch date.dayNumber {
        case 1:
            return workOnSunday
        case 2:
            return workOnMonday
        case 3:
            return workOnTuesday
        case 4:
            return workOnWednesday
        case 5:
            return workOnThursday
        case 6:
            return workOnFriday
        case 7:
            return workOnSaturday
        default:
            return false
        }
    }

    func resetAllInfo() {
        self.customTimeMeasure = nil
        self.monday = 0.0
        self.tuesday = 0.0
        self.wednesday = 0.0
        self.thursday = 0.0
        self.friday = 0.0
        self.saturday = 0.0
        self.sunday = 0.0
        self.name = nil
        self.supportDefinition = nil
        self.timeRequired = 0.0
        self.whatDefinition = nil
        self.whatWillChangeDefinition = nil
        self.whyDefinition = nil
    }

}
