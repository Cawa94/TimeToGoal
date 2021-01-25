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

    @Binding var refreshAllGoals: Bool

    var listSections: [ListSection]

    init(goals: [Goal], refreshAllGoals: Binding<Bool>) {
        self.goals = goals
        self._refreshAllGoals = refreshAllGoals
        self.listSections = [ListSection(id: 0,
                                         title: "all_goals_doing".localized(),
                                         goals: goals.filter { !$0.isArchived }),
                             ListSection(id: 1,
                                         title: "all_goals_archived".localized(),
                                         goals: goals.filter { $0.isArchived })]
    }

}

struct AllGoalsView: View {

    @ObservedObject var viewModel: AllGoalsViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            NavigationView {
                List {
                    ForEach(viewModel.listSections) { section in
                        if let goals = section.goals, !goals.isEmpty {
                            Section(header: Text(section.title).applyFont(.title3)) {
                                ForEach(goals) { goal in
                                    GoalListRow(viewModel: .init(goal: goal))
                                }
                                .onDelete(perform: { offsets in
                                    self.removeItems(at: offsets, from: section)
                                })
                            }
                        }
                    }
                }.listStyle(GroupedListStyle())
                .navigationBarTitle("all_goals_title", displayMode: .large)
            }
        }
    }

    func removeItems(at offsets: IndexSet, from section: ListSection) {
        offsets.forEach{ offset in
            if let goal = section.goals?[offset] {
                viewModel.goals.removeAll(where: { $0.id == goal.id })
                viewModel.goals = viewModel.goals
                PersistenceController.shared.container.viewContext.delete(goal)
                PersistenceController.shared.saveContext()
                viewModel.refreshAllGoals = true
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
