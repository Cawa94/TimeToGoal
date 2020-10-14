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

    var isCompleted: Bool {
        return goal?.isCompleted ?? false
    }

    var hoursRemaining: String {
        let dateRemaining = Double(goal?.timeRequired ?? 0).asHoursAndMinutes
            .remove(Double(goal?.timeCompleted ?? 0).asHoursAndMinutes)
        if dateRemaining > Date().zeroHours {
            return dateRemaining.formattedAsHoursString
        } else {
            return "0"
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

    @ObservedObject var viewModel = GoalProgressViewModel()

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.pageBackground

            Circle()
                .trim(from: 0.0,
                      to: CGFloat(min(Double((viewModel.goal?.timeCompleted ?? 0) / (viewModel.goal?.timeRequired ?? 1)), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 40.0,
                                           lineCap: .round,
                                           lineJoin: .round))
                .background(Circle().stroke(lineWidth: 40.0).opacity(0.3).foregroundColor(Color.goalColor))
                .foregroundColor(Color.goalColor)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut(duration: 1))
                .padding()

            VStack {
                Spacer()
                Text(viewModel.hoursRemaining)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)
                Text("main_hours_required".localized())
                    .font(.title)
                    .bold()
                    .foregroundColor(.textForegroundColor)
                    .padding(.bottom, 10)
                Spacer()
                    .frame(height: 5)
                if viewModel.goal == nil {
                    Text("main_add_new_goal".localized())
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                } else if viewModel.isCompleted {
                    Text("main_weel_done".localized())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.textForegroundColor)
                    Text("main_goal_completed".localized())
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                } else {
                    Text("main_will_reach_goal".localized())
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                    Text(viewModel.completionDate)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(viewModel.isLateThanOriginal ? .red : .textForegroundColor)
                        .padding(.bottom, 20)
                }
                Spacer()
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
