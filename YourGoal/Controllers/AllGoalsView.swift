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
    @Binding var activeSheet: ActiveSheet?

    var listSections: [ListSection]

    init(goals: [Goal], refreshAllGoals: Binding<Bool>, activeSheet: Binding<ActiveSheet?>) {
        self.goals = goals
        self._refreshAllGoals = refreshAllGoals
        self._activeSheet = activeSheet

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
                .applyFont(.title3)
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
