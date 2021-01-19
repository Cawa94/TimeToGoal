//
//  GoalListRow.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 8/12/20.
//

import SwiftUI

public class GoalListRowModel: ObservableObject {

    @Published var goal: Goal

    init(goal: Goal) {
        self.goal = goal
    }

}

struct GoalListRow: View {
    
    @ObservedObject var viewModel: GoalListRowModel

    var body: some View {
        if viewModel.goal.isArchived {
            NavigationLink(destination: JournalView(viewModel: .init(goal: viewModel.goal,
                                                                     isPresented: .constant(true)))) {
                rowContent
            }
        } else {
            rowContent
        }
    }

    var rowContent: some View {
        HStack() {
            viewModel.goal.goalType.icon
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40)
                .foregroundColor(viewModel.goal.goalColor)
                .padding([.top, .bottom], 10)

            Spacer()
                .frame(width: 15)

            Text(viewModel.goal.name ?? "")
                .fontWeight(.semibold)
                .applyFont(.title3)

            Spacer()

            if !viewModel.goal.isArchived {
                percentageText
            }
        }
    }

    var percentageText: some View {
        Text("\(((viewModel.goal.timeCompleted / viewModel.goal.timeRequired) * 100), specifier: "%.2f")%")
            .fontWeight(.semibold)
            .applyFont(.title3)
    }

}
/*
struct GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalListRow()
    }
}
*/
