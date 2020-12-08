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
            NavigationLink(destination: MainGoalView(viewModel: .init(goal: viewModel.goal,
                                                                      activeSheet: .constant(nil),
                                                                      refreshAllGoals: .constant(false),
                                                                      isDetailsView: true))) {
                rowContent
            }
        } else {
            rowContent
        }
    }

    var rowContent: some View {
        VStack(alignment: .leading) {
            Text(viewModel.goal.name ?? "name")
            Text(viewModel.goal.type ?? "type")
        }
    }

}
/*
struct GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalListRow()
    }
}
*/
