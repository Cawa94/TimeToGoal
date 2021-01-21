//
//  GoalProgressView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

private extension Color {

    static let textForegroundColor: Color = .black

}

public class GoalProgressViewModel: ObservableObject {

    @Published var goal: Goal?

    init(goal: Goal?) {
        self.goal = goal
    }

    var isCompleted: Bool {
        return goal?.isCompleted ?? false
    }

    var timeRemaining: String {
        if goal?.goalType.timeTrackingType == .hoursWithMinutes {
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
                return goal?.goalType.timeTrackingType == .double
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

struct GoalProgressView: View {

    @ObservedObject var viewModel: GoalProgressViewModel

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.defaultBackground

            Circle().strokeBorder(AngularGradient(
                                    gradient: Gradient(colors: viewModel.goal?.circleGradientColors ?? Color.rainbowClosed),
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)),
                                  lineWidth: 40)
                .shadow(color: .black, radius: 5, x: 5, y: 5)
                .opacity(0.3)
                .padding(-20)

            Circle()
                .strokeBorder(AngularGradient(
                                gradient: Gradient(colors: viewModel.goal?.circleGradientColors ?? Color.rainbowClosed),
                                center: .center,
                                startAngle: .degrees(0),
                                endAngle: .degrees(360)),
                              lineWidth: 40)
                .mask(Circle()
                        .trim(from: 0.0,
                              to: CGFloat(min(Double((viewModel.goal?.timeCompleted ?? 0) / (viewModel.goal?.timeRequired ?? 1)), 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 40.0, lineCap: .round, lineJoin: .round))
                        .animation(.easeInOut(duration: 0.75))
                        .padding(20)
                )
                .rotationEffect(Angle(degrees: 270))
                .padding(-20)

            VStack {
                if viewModel.goal == nil {
                    Text("main_add_new_goal")
                        .applyFont(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                } else if viewModel.isCompleted {
                    Text("main_weel_done")
                        .fontWeight(.semibold)
                        .foregroundColor(.textForegroundColor)
                        .applyFont(.largeTitle)
                    Text("main_goal_completed")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                        .applyFont(.title2)
                } else {
                    viewModel.goal?.goalType.icon
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 58)
                    Text("main_will_reach_goal")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                        .applyFont(.title2)
                    Text(viewModel.completionDate)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.goal?.goalColor)
                        .applyFont(.largeTitle)

                    Spacer()
                        .frame(height: 3)

                    if let goal = viewModel.goal, goal.goalType == .custom {
                        Text(String(format: "main_time_required".localized(),
                                    viewModel.timeRemaining, goal.customTimeMeasure ?? ""))
                            .fontWeight(.semibold)
                            .foregroundColor(.textForegroundColor)
                            .applyFont(.title3)
                    } else {
                        Text(String(format: "main_time_required".localized(),
                                    viewModel.timeRemaining,
                                    viewModel.goal?.goalType.measureUnit ?? "\("global_hours".localized())"))
                            .applyFont(.title3)
                            .foregroundColor(.textForegroundColor)
                    }
                }
            }
        }
    }

}
/*
struct GoalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GoalProgressView(goal: .constant(Goal()))
            .previewLayout(.fixed(width: 375, height: 400))
    }
}
*/
