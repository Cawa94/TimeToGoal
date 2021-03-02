//
//  AllGoalsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 8/12/20.
//

import SwiftUI

public class AllGoalsViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var challenges: [Challenge]
    @Published var pressedRow: [Bool] = []

    @Binding var refreshAllGoals: Bool
    @Binding var activeSheet: ActiveSheet?

    init(goals: [Goal], challenges: [Challenge], refreshAllGoals: Binding<Bool>, activeSheet: Binding<ActiveSheet?>) {
        let sortedGoals = goals.sorted(by: { $1.isArchived })
        self.goals = sortedGoals
        self.challenges = challenges
        self._refreshAllGoals = refreshAllGoals
        self._activeSheet = activeSheet

        for _ in sortedGoals {
            pressedRow.append(false)
        }
    }

}

struct AllGoalsView: View {

    @ObservedObject var viewModel: AllGoalsViewModel

    @State var showMainGoalView = false
    @State var selectedIndex: Int?

    @ViewBuilder
    var body: some View {
        NavigationView {
            BackgroundView(color: .defaultBackground) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack() {
                        Spacer()
                            .frame(height: 15)

                        HStack {
                            Text("all_goals_title")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.navigationLargeTitle)

                            Spacer()

                            addNewButton
                                .padding(.trailing, 15)
                        }

                        Spacer()

                        if let selectedIndex = selectedIndex {
                            NavigationLink(destination: MainGoalView(viewModel: .init(goal: viewModel.goals[selectedIndex],
                                                                                      goals: $viewModel.goals,
                                                                                      challenges: viewModel.challenges,
                                                                                      isPresented: $showMainGoalView, activeSheet: $viewModel.activeSheet,
                                                                                      refreshAllGoals: $viewModel.refreshAllGoals)),
                                           isActive: $showMainGoalView) {
                                EmptyView()
                            }
                        }

                        if let goals = viewModel.goals, !goals.isEmpty {
                            ForEach(0..<goals.count, id: \.self) { index in
                                LazyVStack {
                                    GoalListRow(viewModel: .init(goal: goals[index],
                                                                 challenges: viewModel.challenges))
                                        .scaleEffect((viewModel.pressedRow[index]) ? 0.9 : 1.0)
                                        .onTapGesture {
                                            selectedIndex = index
                                            showMainGoalView = true
                                        }
                                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                viewModel.pressedRow[index] = pressing
                                            }
                                        }, perform: {})
                                }.padding([.top, .leading, .trailing], 20)
                            }
                        }

                        Spacer()
                            .frame(height: 40)

                    }.navigationBarHidden(true)
                    .navigationBarTitle("")
                }
            }
        }
    }

    var addNewButton: some View {
        Button(action: {
            viewModel.activeSheet = .newGoal
        }) {
            Text("global_add")
                .foregroundColor(.grayText)
                .applyFont(.title4)
        }
    }

}
/*
struct AllGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        AllGoalsView()
    }
}
*/
