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

public class MainGoalViewModel: ObservableObject {

    @Published var goal: Goal? {
        didSet {
            progressViewModel.goal = goal
            calendarViewModel.goal = goal
        }
    }

    @Published var progressViewModel = GoalProgressViewModel()
    @Published var calendarViewModel = HorizontalCalendarViewModel()

}

struct MainGoalView: View {

    @ObservedObject var viewModel = MainGoalViewModel()

    var body: some View {
        ZStack {
            Color.pageBackground
                .ignoresSafeArea()
            VStack {
                Spacer(minLength: 10)

                HorizontalCalendarView(viewModel: viewModel.calendarViewModel)
                    .padding([.leading, .trailing])

                Spacer(minLength: 25)

                Text(viewModel.goal?.name ?? "Il Mio Obiettivo")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)

                Spacer()

                GoalProgressView(viewModel: viewModel.progressViewModel)
                    .padding([.leading, .trailing], 7)

                Spacer(minLength: 25)
            }
        }
    }
}
/*
struct MainGoalView_Previews: PreviewProvider {
    static var previews: some View {
        MainGoalView(viewModel: .init(goal: .constant(Goal())))
    }
}
*/
