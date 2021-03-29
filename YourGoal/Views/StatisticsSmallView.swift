//
//  StatisticsSmallView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/1/21.
//

import SwiftUI

public class StatisticsSmallViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var hasTrackedGoal: Bool

    init(goals: [Goal], hasTrackedGoal: Bool) {
        self.goals = goals
        self.hasTrackedGoal = hasTrackedGoal
    }

    var weekDates: [Date] {
        let startOfWeek = Date().startOfWeek?.withoutHours ?? Date()
        var datesArray: [Date] = []

        for index in 0...6 {
            datesArray.append(startOfWeek.adding(days: index).withoutHours)
        }

        return datesArray
    }

    var daysShort: [String] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        var daysArray: [String] = []

        for date in weekDates {
            daysArray.append(calendar.veryShortWeekdaySymbols[date.dayNumber - 1])
        }

        return daysArray
    }

}

struct StatisticsSmallView: View {

    @ObservedObject var viewModel: StatisticsSmallViewModel

    @State var mondayGoals: [Goal] = []
    @State var tuesdayGoals: [Goal] = []
    @State var wednesdayGoals: [Goal] = []
    @State var thursdayGoals: [Goal] = []
    @State var fridayGoals: [Goal] = []
    @State var saturdayGoals: [Goal] = []
    @State var sundayGoals: [Goal] = []

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.defaultBackground

            HStack(spacing: 20) {
                DayBarView(viewModel: .init(date: viewModel.weekDates[0],
                                            columnScale: viewModel.weekDates[0].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $mondayGoals)
                DayBarView(viewModel: .init(date: viewModel.weekDates[1],
                                            columnScale: viewModel.weekDates[1].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $tuesdayGoals)
                DayBarView(viewModel: .init(date: viewModel.weekDates[2],
                                            columnScale: viewModel.weekDates[2].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $wednesdayGoals)
                DayBarView(viewModel: .init(date: viewModel.weekDates[3],
                                            columnScale: viewModel.weekDates[3].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $thursdayGoals)
                DayBarView(viewModel: .init(date: viewModel.weekDates[4],
                                            columnScale: viewModel.weekDates[4].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $fridayGoals)
                DayBarView(viewModel: .init(date: viewModel.weekDates[5],
                                            columnScale: viewModel.weekDates[5].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $saturdayGoals)
                DayBarView(viewModel: .init(date: viewModel.weekDates[6],
                                            columnScale: viewModel.weekDates[6].withoutHours == Date().withoutHours ? 1.1 : 1,
                                            hasTrackedGoal: viewModel.hasTrackedGoal),
                           goalsOnDate: $sundayGoals)
            }
        }.onReceive(viewModel.$goals, perform: { goals in
            self.mondayGoals = goals.goalsWorkOn(date: viewModel.weekDates[0])
            self.tuesdayGoals = goals.goalsWorkOn(date: viewModel.weekDates[1])
            self.wednesdayGoals = goals.goalsWorkOn(date: viewModel.weekDates[2])
            self.thursdayGoals = goals.goalsWorkOn(date: viewModel.weekDates[3])
            self.fridayGoals = goals.goalsWorkOn(date: viewModel.weekDates[4])
            self.saturdayGoals = goals.goalsWorkOn(date: viewModel.weekDates[5])
            self.sundayGoals = goals.goalsWorkOn(date: viewModel.weekDates[6])
        })
    }

}

public class DayBarViewModel: ObservableObject {

    @Published var date: Date
    @Published var columnScale: CGFloat
    @Published var hasTrackedGoal: Bool

    init(date: Date, columnScale: CGFloat, hasTrackedGoal: Bool) {
        self.date = date
        self.columnScale = columnScale
        self.hasTrackedGoal = hasTrackedGoal
    }

}

struct DayBarView: View {

    @ObservedObject var viewModel: DayBarViewModel

    @Binding var goalsOnDate: [Goal]

    func dayShortFor(date: Date) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        return calendar.veryShortWeekdaySymbols[date.dayNumber - 1]
    }

    @ViewBuilder
    var body: some View {
        VStack(spacing: DeviceFix.is65Screen ? 15 : 10) {
            GeometryReader { container in
                ZStack {
                    if goalsOnDate.count > 0 {
                        let barHeight = CGFloat(container.size.height / CGFloat(goalsOnDate.count))

                        VStack(spacing: 0) {
                            ForEach(goalsOnDate) { goal in
                                ZStack {
                                    let cornerRadius: CGFloat = goal == goalsOnDate.first || goal == goalsOnDate.last ? .defaultRadius : 0
                                    let corners: UIRectCorner = goal == goalsOnDate.first ? [.topLeft, .topRight] : [.bottomLeft, .bottomRight]
                                    VStack {
                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: goal.smallRectGradientColors),
                                                                 startPoint: .top, endPoint: .bottom))
                                            .frame(height: barHeight)
                                            .opacity(0.3)
                                            .cornerRadius(cornerRadius, corners: goalsOnDate.count == 1
                                                            ? [.topLeft, .topRight, .bottomLeft, .bottomRight] : corners)
                                    }

                                    VStack {
                                        Spacer()
                                            .frame(height: CGFloat(barHeight/100 * (100 - (goal.dayPercentageAt(date: viewModel.date)))))

                                        Rectangle()
                                            .fill(LinearGradient(gradient: Gradient(colors: goal.smallRectGradientColors),
                                                                 startPoint: .top, endPoint: .bottom))
                                            .frame(height: min(CGFloat(barHeight/100 * (goal.dayPercentageAt(date: viewModel.date))), barHeight))
                                            .cornerRadius(cornerRadius, corners: goalsOnDate.count == 1
                                                            ? [.topLeft, .topRight, .bottomLeft, .bottomRight] : corners)
                                    }
                                }
                            }
                        }
                    } else {
                        let barHeight = container.size.height

                        RoundedRectangle(cornerRadius: .defaultRadius, style: .continuous)
                            .fill(Color.grayBorder)
                            .frame(height: barHeight)
                            .opacity(0.3)
                    }
                }.clipShape(RoundedRectangle(cornerRadius: .defaultRadius))
            }.scaleEffect(viewModel.columnScale)

            Text(dayShortFor(date: viewModel.date))
                .multilineTextAlignment(.center)
                .foregroundColor(.grayText)
                .applyFont(.title2)
        }.onReceive(viewModel.$hasTrackedGoal, perform: { hasTrackedGoal in
            if hasTrackedGoal, viewModel.date.withoutHours == Date().withoutHours {
                goalsOnDate = goalsOnDate.compactMap { $0 }

                if !goalsOnDate.isEmpty, goalsOnDate.areAllCompletedOn(date: viewModel.date) {
                    viewModel.columnScale = 0.95
                    withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 1.5, initialVelocity: 1)) {
                        viewModel.columnScale = 1.1
                    }
                }
            }
        })
    }

}

/*
struct StatisticsSmallView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSmallView()
    }
}
*/
