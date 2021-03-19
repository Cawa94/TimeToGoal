//
//  StatisticsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class StatisticsViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var validGoals: [Goal]
    @Published var challenges: [Challenge]

    init(goals: [Goal], challenges: [Challenge]) {
        self.goals = goals
        self.validGoals = goals.filter { !$0.isArchived }
        self.challenges = challenges
    }

    var completedGoals: Int {
        goals.filter( { !$0.goalType.isHabit && $0.isCompleted }).count
    }

}

struct StatisticsView: View {

    @ObservedObject var viewModel: StatisticsViewModel

    @Environment(\.calendar) var calendar

    @State var currentGoalStreak: Int = 0
    @State var recordGoalStreak: Int = 0

    private var goalsDateInterval: DateInterval {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = viewModel.validGoals.sorted(by: { ($0.createdAt ?? Date()) < ($1.createdAt ?? Date()) })
            .first?.createdAt ?? formatter.date(from: "2021/01/01 23:00") ?? Date()
        let endDate = Date()
        return DateInterval(start: startDate, end: endDate)
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        Spacer()
                            .frame(height: DeviceFix.isRoundedScreen ? 50 : 20)

                        HStack {
                            Text("statistics_title")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.navigationLargeTitle)

                            Spacer()
                        }

                        CalendarView(interval: goalsDateInterval, monthWidth: container.size.width) { date in
                            CalendarDayView(goals: viewModel.validGoals, date: date)
                        }

                        Spacer()
                            .frame(height: 0)

                        HStack(spacing: 15) {
                            VStack {
                                Text("statistics_current_streak_days")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.title2)

                                Text("\(currentGoalStreak)")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.navigationLargeTitle)
                            }.frame(width: container.size.width/2 - 15)

                            VStack {
                                Text("statistics_record_streak_days")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.title2)

                                Text("\(recordGoalStreak)")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.navigationLargeTitle)
                            }.frame(width: container.size.width/2 - 15)
                        }.padding(.bottom, 15)

                        HStack(spacing: 15) {
                            VStack {
                                Text("statistics_complete_goals")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.title2)

                                Text("\(viewModel.completedGoals)")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.navigationLargeTitle)
                            }.frame(width: container.size.width/2 - 15)

                            VStack {
                                Text("statistics_perfect_weeks")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.title2)

                                Text("\(viewModel.goals.perfectWeeks)")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.navigationLargeTitle)
                            }.frame(width: container.size.width/2 - 15)
                        }.padding(.bottom, 15)

                        Spacer()
                            .frame(height: 5)
                    }
                }
            }
        }.onAppear {
            currentGoalStreak = viewModel.validGoals.currentStreak
            if let challenge = viewModel.challenges.first(where: { $0.id == 15 }) {
                let streakRecord = challenge.progressMade
                if currentGoalStreak > Int(streakRecord) {
                    recordGoalStreak = currentGoalStreak
                    updateChallengesWith(record: currentGoalStreak)
                } else {
                    recordGoalStreak = Int(streakRecord)
                }
            } else {
                recordGoalStreak = Int(currentGoalStreak)
                updateChallengesWith(record: currentGoalStreak)
            }
        }
    }

    func updateChallengesWith(record: Int) {
        if let challenge = viewModel.challenges.first(where: { $0.id == 13 }) {
            challenge.progressMade = Double(record)
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 13
            challenge.progressMade = Double(record)
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 14 }) {
            challenge.progressMade = Double(record)
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 14
            challenge.progressMade = Double(record)
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 15 }) {
            challenge.progressMade = Double(record)
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 15
            challenge.progressMade = Double(record)
        }
        PersistenceController.shared.saveContext()
    }

}

/*
struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
*/
