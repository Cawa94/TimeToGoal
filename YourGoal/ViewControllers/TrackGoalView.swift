//
//  TrackGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

private extension Color {

    static let textForegroundColor: Color = .black

}

struct TrackGoalView: View {

    @Binding var currentGoal: Goal?

    var body: some View {
        ZStack {
            Color.pageBackground
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer(minLength: 10)
                HorizontalCalendarView(viewModel: HorizontalCalendarViewModel(goal: $currentGoal))
                    .padding([.leading, .trailing])

                Spacer()

                GoalProgressView(goal: $currentGoal).padding(15.0)

                Text(currentGoal?.name ?? "Sconosciuto")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)

                Spacer(minLength: 50)
            }
        }
    }
}

struct TrackGoalView_Previews: PreviewProvider {
    static var previews: some View {
        TrackGoalView(currentGoal: .constant(Goal()))
    }
}

