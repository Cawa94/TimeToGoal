//
//  AllGoalsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 8/12/20.
//

import SwiftUI

struct ListSection: Identifiable {

    var id: Int64
    var title: String
    var goals: [Goal]?

}

public class AllGoalsViewModel: ObservableObject {

    @Published var goals: [Goal] {
        didSet {
            self.listSections = [ListSection(id: 0,
                                             title: "all_goals_doing".localized(),
                                             goals: goals.filter { !$0.isArchived }),
                                 ListSection(id: 1,
                                             title: "all_goals_archived".localized(),
                                             goals: goals.filter { $0.isArchived })]
        }
    }
    @Published var challenges: [Challenge]
    @Published var pressedRow: [Int: [Bool]] = [:]

    @Binding var refreshAllGoals: Bool
    @Binding var activeSheet: ActiveSheet?

    var listSections: [ListSection]

    init(goals: [Goal], challenges: [Challenge], refreshAllGoals: Binding<Bool>, activeSheet: Binding<ActiveSheet?>) {
        self.goals = goals
        self.challenges = challenges
        self._refreshAllGoals = refreshAllGoals
        self._activeSheet = activeSheet

        self.listSections = [ListSection(id: 0,
                                         title: "all_goals_doing".localized(),
                                         goals: goals.filter { !$0.isArchived }),
                             ListSection(id: 1,
                                         title: "all_goals_archived".localized(),
                                         goals: goals.filter { $0.isArchived })]

        var arrayNotArchived: [Bool] = []
        for _ in goals.filter({ !$0.isArchived }) {
            arrayNotArchived.append(false)
        }

        var arrayArchived: [Bool] = []
        for _ in goals.filter({ $0.isArchived }) {
            arrayArchived.append(false)
        }

        pressedRow[0] = arrayNotArchived
        pressedRow[1] = arrayArchived
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
                VStack {
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

                    List {
                        ForEach(0..<viewModel.listSections.count, id: \.self) { sectionIndex in
                            if let goals = viewModel.listSections[sectionIndex].goals, !goals.isEmpty {
                                Section(header: Text(viewModel.listSections[sectionIndex].title).applyFont(.title4)) {
                                    ForEach(0..<goals.count, id: \.self) { index in
                                        GoalListRow(viewModel: .init(goal: goals[index],
                                                                     challenges: viewModel.challenges))
                                            .scaleEffect((viewModel.pressedRow[sectionIndex]?[index] ?? false) ? 0.9 : 1.0)
                                            .onTapGesture {
                                                selectedIndex = index
                                                showMainGoalView = true
                                            }
                                            .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                                withAnimation(.easeInOut(duration: 0.2)) {
                                                    viewModel.pressedRow[sectionIndex]?[index] = pressing
                                                }
                                            }, perform: {})
                                    }
                                }
                            }
                        }
                    }.listStyle(GroupedListStyle())

                }.navigationBarHidden(true)
                .navigationBarTitle("")
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

    func removeItems(at offsets: IndexSet, from section: ListSection) {
        offsets.forEach{ offset in
            if let goal = section.goals?[offset] {
                viewModel.goals.removeAll(where: { $0.id == goal.id })
                viewModel.refreshAllGoals = true
                PersistenceController.shared.container.viewContext.delete(goal)
                PersistenceController.shared.saveContext()
            }
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
