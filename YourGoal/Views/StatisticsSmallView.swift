//
//  StatisticsSmallView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/1/21.
//

import SwiftUI

public class StatisticsSmallViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var journal: [JournalPage]

    init(goals: [Goal], journal: [JournalPage]) {
        self.goals = goals
        self.journal = journal
    }

    var weekDates: [Date] {
        let startOfWeek = Date().startOfWeek ?? Date()
        var datesArray: [Date] = []

        for index in 0...6 {
            datesArray.append(startOfWeek.adding(days: index))
        }

        return datesArray
    }

    func dayShortFor(date: Date) -> String {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.languageCode ?? "en")
        return calendar.veryShortWeekdaySymbols[date.dayNumber - 1]
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

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.defaultBackground

            HStack(spacing: 20) {
                ForEach(viewModel.weekDates, id: \.self) { date in
                    VStack(spacing: 5) {
                        GeometryReader { container in
                            ZStack {
                                let goalsOnDate = viewModel.goals.goalsWorkOn(date: date)
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
                                                        .frame(height: CGFloat(barHeight/100 * (100 - (goal.dayPercentageAt(date: date)))))

                                                    Rectangle()
                                                        .fill(LinearGradient(gradient: Gradient(colors: goal.smallRectGradientColors),
                                                                             startPoint: .top, endPoint: .bottom))
                                                        .frame(height: min(CGFloat(barHeight/100 * (goal.dayPercentageAt(date: date))), barHeight))
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
                        }
                        Text(viewModel.dayShortFor(date: date))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.grayText)
                            .applyFont(.title2)
                    }
                }
            }
        }
    }

}

/*
struct StatisticsSmallView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsSmallView()
    }
}
*/
