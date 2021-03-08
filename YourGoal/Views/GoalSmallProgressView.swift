//
//  GoalSmallProgressView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/1/21.
//

import SwiftUI

private extension CGFloat {

    static let circleWidth: CGFloat = 20

}

public class GoalSmallProgressViewModel: ObservableObject {

    @Published var goal: Goal?
    @Published var challenges: [Challenge]

    @Binding var activeSheet: ActiveSheet?
    @Binding var showingTrackGoal: Bool
    @Binding var goalToRenew: Goal?
    @Binding var indexSelectedGoal: Int
    @Binding var hasTrackedGoal: Bool

    var goalIndex: Int?

    init(goal: Goal?, challenges: [Challenge], showingTrackGoal: Binding<Bool>, goalToRenew: Binding<Goal?>,
         indexSelectedGoal: Binding<Int>, activeSheet: Binding<ActiveSheet?>, hasTrackedGoal: Binding<Bool>, goalIndex: Int?) {
        self.goal = goal
        self.challenges = challenges
        self._showingTrackGoal = showingTrackGoal
        self._goalToRenew = goalToRenew
        self._indexSelectedGoal = indexSelectedGoal
        self._activeSheet = activeSheet
        self._hasTrackedGoal = hasTrackedGoal
        self.goalIndex = goalIndex
    }

    var isCompleted: Bool {
        return goal?.isCompleted ?? false
    }

    var timeRemaining: String {
        if goal?.timeTrackingType == .hoursWithMinutes {
            let dateRemaining = Double(goal?.timeRequired ?? 0).asHoursAndMinutes
                .remove(Double(goal?.timeCompleted ?? 0).asHoursAndMinutes)
            if dateRemaining > Date().zeroHours {
                return dateRemaining.formattedAsHoursString
            } else {
                return "0"
            }
        } else {
            let timeRemaining = Double(goal?.timeRequired ?? 0) - Double(goal?.timeCompleted ?? 0)
            if timeRemaining > 0 {
                return goal?.timeTrackingType == .double
                    ? "\(timeRemaining.stringWithTwoDecimals)" : "\(timeRemaining.stringWithoutDecimals)"
            } else {
                return "0"
            }
        }
    }

    var completionDate: String {
        return (goal?.updatedCompletionDate ?? Date()).formattedAsDateString
    }

    var isLateThanOriginal: Bool {
        return goal?.updatedCompletionDate.withoutHours ?? Date() > goal?.completionDateExtimated?.withoutHours ?? Date()
    }

}

struct GoalSmallProgressView: View {

    @ObservedObject var viewModel: GoalSmallProgressViewModel

    @State private var feedback = UINotificationFeedbackGenerator()

    @ViewBuilder
    var body: some View {
        GeometryReader { container in
            ZStack {
                Color.defaultBackground

                VStack(spacing: 0) {
                    if viewModel.goal == nil {
                        Text("Nuovo obiettivo")
                            .applyFont(.title)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.grayText)
                    } else if viewModel.isCompleted {
                        Text(viewModel.goal?.name ?? "")
                            .multilineTextAlignment(.center)
                            .foregroundColor(viewModel.goal?.goalColor)
                            .applyFont(.title)
                    } else {
                        Text(viewModel.goal?.name ?? "")
                            .multilineTextAlignment(.center)
                            .foregroundColor(viewModel.goal?.goalColor)
                            .lineLimit(2)
                            .applyFont(.title)
                    }

                    HStack {
                        ZStack {
                            Circle().strokeBorder(AngularGradient(
                                                    gradient: Gradient(colors: viewModel.goal?.circleGradientColors ?? Color.rainbowClosed),
                                                    center: .center,
                                                    startAngle: .degrees(0),
                                                    endAngle: .degrees(360)),
                                                  lineWidth: .circleWidth)
                                .shadow(color: .black, radius: 5, x: 5, y: 5)
                                .opacity(0.3)
                                .padding(-(CGFloat.circleWidth/2))

                            Circle()
                                .strokeBorder(AngularGradient(
                                                gradient: Gradient(colors: viewModel.goal?.circleGradientColors ?? Color.rainbowClosed),
                                                center: .center,
                                                startAngle: .degrees(0),
                                                endAngle: .degrees(360)),
                                              lineWidth: .circleWidth)
                                .mask(Circle()
                                        .trim(from: 0.0,
                                              to: CGFloat(min(Double((viewModel.goal?.timeCompleted ?? 0) / (viewModel.goal?.timeRequired ?? 1)), 1.0)))
                                        .stroke(style: StrokeStyle(lineWidth: .circleWidth, lineCap: .round, lineJoin: .round))
                                        .padding(CGFloat.circleWidth/2)
                                )
                                .rotationEffect(Angle(degrees: 270))
                                .padding(-(CGFloat.circleWidth/2))

                            VStack(spacing: 3) {
                                Image(viewModel.goal?.goalIcon ?? "project_0")
                                    .resizable()
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .frame(width: 50)
                                if let goal = viewModel.goal {
                                    Text(String(format: "main_time_required".localized(),
                                                viewModel.timeRemaining, goal.customTimeMeasure ?? ""))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.grayText)
                                        .applyFont(.small)
                                }
                            }.padding([.top], -4)

                        }.padding([.leading], 15)
                        .frame(width: container.size.width/100 * 40)

                        Spacer()

                        VStack {
                            if let goal = viewModel.goal {
                                if viewModel.isCompleted {
                                    Text(goal.whyDefinition ?? "")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.small)
                                        .padding([.leading, .trailing], 5)
                                    if goal.goalType.isHabit {
                                        renewGoalButton
                                    } else {
                                        archiveGoalButton
                                    }
                                } else {
                                    Text(goal.whyDefinition ?? "")
                                        .fontWeight(.bold)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                        .applyFont(.small)
                                        .lineSpacing(-20)
                                        .padding([.leading, .trailing], 5)
                                    trackTimeButton
                                }
                            } else {
                                Text("main_add_new_goal")
                                    .applyFont(.title)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.grayText)
                                newGoalButton
                            }
                        }.frame(width: container.size.width/100 * 55)

                    }
                }

                if viewModel.isCompleted {
                    FireworksView(isPresented: .constant(viewModel.isCompleted))
                        .allowsHitTesting(false)
                }
            }
        }
    }

    func updateCompleteGoalChallenge() {
        if !(viewModel.goal?.goalType.isHabit ?? false) {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 10
            challenge.progressMade = 1
        }
    }

    func updateTrackingChallenge() {
        if let challenge = viewModel.challenges.first(where: { $0.id == 7 }) {
            challenge.progressMade += 1
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 7
            challenge.progressMade = 1
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 8 }) {
            challenge.progressMade += 1
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 8
            challenge.progressMade = 1
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 9 }) {
            challenge.progressMade += 1
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 9
            challenge.progressMade = 1
        }
    }

    func createGoalProgress(time: Double) -> Progress {
        let progress = Progress(context: PersistenceController.shared.container.viewContext)
        progress.date = Date()
        progress.hoursOfWork = time
        progress.dayId = Date().customId
        return progress
    }

    func trackGoalWithSingleTime() {
        viewModel.goal?.timesHasBeenTracked += 1
        let timeTracked = Double(1)
        FirebaseService.logEvent(.timeTracked)
        viewModel.goal?.timeCompleted += timeTracked
        let progress = createGoalProgress(time: timeTracked)
        viewModel.goal?.addToProgress(progress)
        viewModel.goal?.editedAt = Date()
        if viewModel.goal?.isCompleted ?? false {
            viewModel.goal?.completedAt = Date()
            if viewModel.goal?.datesHasBeenCompleted != nil {
                viewModel.goal?.datesHasBeenCompleted?.append(Date())
            } else {
                viewModel.goal?.datesHasBeenCompleted = [Date()]
            }
            FirebaseService.logConversion(.goalCompleted, goal: viewModel.goal)
            updateCompleteGoalChallenge()
        }
        updateTrackingChallenge()
        PersistenceController.shared.saveContext()
        self.feedback.notificationOccurred(.success)
        viewModel.hasTrackedGoal = true
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if MeasureUnit.getFrom(viewModel.goal?.customTimeMeasure ?? "") == .singleTime {
                        trackGoalWithSingleTime()
                        viewModel.showingTrackGoal = false
                    } else {
                        FirebaseService.logEvent(.trackTimeButton)
                        viewModel.indexSelectedGoal = viewModel.goalIndex ?? 0
                        viewModel.showingTrackGoal = true
                    }
                }
            }) {
                Text("main_track_progress")
                    .foregroundColor(.white)
                    .applyFont(.smallButton)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .background(LinearGradient(gradient: Gradient(colors: viewModel.goal?.rectGradientColors ?? Color.rainbow),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.defaultRadius)
                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

    var archiveGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.goal?.isArchived = true
                PersistenceController.shared.saveContext()
            }) {
                Text("global_archive")
                    .foregroundColor(.white)
                    .applyFont(.smallButton)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .background(LinearGradient(gradient: Gradient(colors: Color.rainbow),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.defaultRadius)
                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

    var renewGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.goalToRenew = viewModel.goal
                viewModel.activeSheet = .renewGoal
            }) {
                Text("Nuovo traguardo")
                    .foregroundColor(.white)
                    .applyFont(.smallButton)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 15)
                    .background(LinearGradient(gradient: Gradient(colors: Color.rainbow),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.defaultRadius)
                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

    var newGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.activeSheet = .newGoal
            }) {
                Text("global_add")
                    .foregroundColor(.white)
                    .applyFont(.smallButton)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .padding([.leading, .trailing], 40)
                    .background(LinearGradient(gradient: Gradient(colors: Color.rainbow),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.defaultRadius)
                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

}
/*
struct GoalSmallProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSmallProgressView()
    }
}
*/
