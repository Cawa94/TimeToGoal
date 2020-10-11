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

}

struct GoalProgressView: View {

    @ObservedObject var viewModel = GoalProgressViewModel()

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
                Text(Double((viewModel.goal?.timeRequired ?? 0) - (viewModel.goal?.timeCompleted ?? 0)).stringWithTwoDecimals)
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
                Text("main_will_reach_goal".localized())
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.textForegroundColor)
                Text("\((viewModel.goal?.updatedCompletionDate ?? Date()).formattedAsDate)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)
                    .padding(.bottom, 20)
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
