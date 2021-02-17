//
//  GoalListRow.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 8/12/20.
//

import SwiftUI

public class GoalListRowModel: ObservableObject {

    @Published var goal: Goal
    @Published var challenges: [Challenge]

    init(goal: Goal, challenges: [Challenge]) {
        self.goal = goal
        self.challenges = challenges
    }

}

struct GoalListRow: View {

    @ObservedObject var viewModel: GoalListRowModel

    var body: some View {
        if !viewModel.goal.isArchived {
            NavigationLink(destination: MainGoalView(viewModel: .init(goal: viewModel.goal,
                                                                      challenges: viewModel.challenges,
                                                                      activeSheet: .constant(nil),
                                                                      refreshAllGoals: .constant(true)))) {
                rowContent
            }
            .listRowBackground(Color.defaultBackground)
        } else {
            rowContent
                .listRowBackground(Color.defaultBackground)
        }
    }

    var rowContent: some View {
        HStack() {
            Image(viewModel.goal.goalIcon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40)
                .foregroundColor(viewModel.goal.goalColor)
                .padding([.top, .bottom], 10)

            Spacer()
                .frame(width: 15)

            Text(viewModel.goal.name ?? "")
                .fontWeight(.semibold)
                .applyFont(.title2)

            Spacer()

            if !viewModel.goal.isArchived {
                percentageText
            }
        }.listRowBackground(Color.defaultBackground)
    }

    var percentageText: some View {
        Text("\(((viewModel.goal.timeCompleted / viewModel.goal.timeRequired) * 100), specifier: "%.0f")%")
            .fontWeight(.semibold)
            .applyFont(.title2)
    }

}
/*
struct GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalListRow()
    }
}
*/
