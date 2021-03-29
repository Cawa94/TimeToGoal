//
//  StatisticsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class StatisticsViewModel: ObservableObject {

    @Published var goals: [Goal] = []
    @Published var challenges: [Challenge] = []

    var tempGoals: [Goal]
    var tempChallenges: [Challenge]

    init(goals: [Goal], challenges: [Challenge]) {
        self.tempGoals = goals
        self.tempChallenges = challenges
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
    @State var isLoading: Bool = true
    @State var validGoals: [Goal] = []
    @State var goalsDateInterval = DateInterval(start: Date(), end: Date())

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            ZStack {
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

                            CalendarView(interval: $goalsDateInterval, monthWidth: container.size.width) { date in
                                CalendarDayView(goals: validGoals, date: date)
                            }

                            Spacer()
                                .frame(height: DeviceFix.is65Screen ? 30 : 0)

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

                                    Text(AppDelegate.needScreenshots ? "13" : "\(recordGoalStreak)")
                                        .foregroundColor(.grayText)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.navigationLargeTitle)
                                }.frame(width: container.size.width/2 - 15)
                            }.padding(.bottom, 15)
/*
                            HStack(spacing: 15) {
                                VStack {
                                    Text("statistics_complete_goals")
                                        .foregroundColor(.grayText)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.title2)

                                    Text(AppDelegate.needScreenshots ? "2" : "\(viewModel.completedGoals)")
                                        .foregroundColor(.grayText)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.navigationLargeTitle)
                                }.frame(width: container.size.width/2 - 15)

                                VStack {
                                    Text("statistics_perfect_weeks")
                                        .foregroundColor(.grayText)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.title2)

                                    Text(AppDelegate.needScreenshots ? "4" : "\(viewModel.goals.perfectWeeks)")
                                        .foregroundColor(.grayText)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.navigationLargeTitle)
                                }.frame(width: container.size.width/2 - 15)
                            }.padding(.bottom, 15)

                            Spacer()
                                .frame(height: 5)*/
                        }
                    }
                }

                if isLoading {
                    LoadingView()
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
                viewModel.goals = viewModel.tempGoals
                validGoals = viewModel.tempGoals.filter { !$0.isArchived }
                viewModel.challenges = viewModel.tempChallenges

                goalsDateInterval = DateInterval(start: Date().startOfMonth ?? Date(), end: Date())

                currentGoalStreak = validGoals.currentStreak
                if let challenge = viewModel.challenges.first(where: { $0.id == 13 }) {
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

                isLoading = false
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
