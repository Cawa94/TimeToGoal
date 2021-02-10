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

    @Binding var showingTrackGoal: Bool
    @Binding var indexSelectedGoal: Int

    var goalIndex: Int?

    init(goal: Goal?, showingTrackGoal: Binding<Bool>,
         indexSelectedGoal: Binding<Int>, goalIndex: Int?) {
        self.goal = goal
        self._showingTrackGoal = showingTrackGoal
        self._indexSelectedGoal = indexSelectedGoal
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

    @ViewBuilder
    var body: some View {
        GeometryReader { container in
            ZStack {
                Color.defaultBackground

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

                        Image(viewModel.goal?.goalIcon ?? "")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .frame(width: 50)

                    }.padding([.leading], 15)
                    .frame(width: container.size.width/100 * 40)

                    Spacer()

                    VStack {
                        if viewModel.goal == nil {
                            Text("main_add_new_goal")
                                .applyFont(.title)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.grayText)
                        } else if viewModel.isCompleted {
                            Text(viewModel.goal?.name ?? "")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.grayText)
                                .applyFont(.title2)
                            Text("main_goal_completed")
                                .foregroundColor(.grayText)
                                .applyFont(.title)
                        } else {
                            Text(viewModel.goal?.name ?? "")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.grayText)
                                .lineLimit(2)
                                .applyFont(.title2)
                            Text(viewModel.completionDate)
                                .fontWeight(.bold)
                                .foregroundColor(viewModel.goal?.goalColor)
                                .applyFont(.title)
                            trackTimeButton
                        }
                    }.frame(width: container.size.width/100 * 55)

                }
            }
        }
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if !(viewModel.goal?.isCompleted ?? true) {
                        FirebaseService.logEvent(.trackTimeButton)
                        viewModel.indexSelectedGoal = viewModel.goalIndex ?? 0
                        viewModel.showingTrackGoal = true
                    }
                }
            }) {
                Text("main_track_progress")
                    .fontWeight(.semibold)
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
                HStack {
                    Spacer()
                    Text("global_archive")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .applyFont(.smallButton)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 10)
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
