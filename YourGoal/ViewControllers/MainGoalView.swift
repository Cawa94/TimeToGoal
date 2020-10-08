//
//  MainGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

private extension Color {

    static let textForegroundColor: Color = .black

}

struct MainGoalView: View {

    @Binding var currentGoal: Goal?

    var body: some View {
        ZStack {
            Color.pageBackground
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 10)

                HorizontalCalendarView(viewModel: HorizontalCalendarViewModel(goal: $currentGoal))
                    .padding([.leading, .trailing])

                Spacer(minLength: 25)

                Text(currentGoal?.name ?? "Il Mio Obiettivo")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)

                Spacer()

                GoalProgressView(goal: $currentGoal).padding(15.0)

                Spacer(minLength: 50)
            }
        }
    }
}

struct MainGoalView_Previews: PreviewProvider {
    static var previews: some View {
        MainGoalView(currentGoal: .constant(Goal()))
    }
}

