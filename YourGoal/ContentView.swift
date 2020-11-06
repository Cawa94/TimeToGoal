//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

public class ContentViewModel: ObservableObject {

    @Published var goals: [Goal] = []
    @Published var showingAddNewGoal = false
    @Published var refreshAllGoals = false
    @Published var goalsModels: [MainGoalViewModel] = []

}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    var goalsRequest: FetchRequest<Goal>
    var goals: FetchedResults<Goal> { goalsRequest.wrappedValue }

    init() {
        self.goalsRequest = FetchRequest(
            entity: Goal.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Goal.editedAt, ascending: false)
            ]
        )
    }

    @ViewBuilder
    var body: some View {
        TabView {
            ForEach(0...(viewModel.goalsModels.count), id: \.self) { index in
                if index < viewModel.goalsModels.count {
                    let model = viewModel.goalsModels[index]
                    MainGoalView(viewModel: model)
                } else {
                    MainGoalView(viewModel: .init(goal: nil,
                                                  isFirstGoal: viewModel.goals.isEmpty,
                                                  showingAddNewGoal: $viewModel.showingAddNewGoal,
                                                  refreshAllGoals: $viewModel.refreshAllGoals))
                }
            }
        }
        .id(viewModel.goals.count)
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .colorScheme(.light)
        .onAppear(perform: {
            viewModel.refreshAllGoals = true
        })
        .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
            for invalidGoal in goals.filter({ !$0.isValid }) {
                PersistenceController.shared.container.viewContext.delete(invalidGoal)
            }
            PersistenceController.shared.saveContext()
            viewModel.refreshAllGoals = true
        }, content: {
            AddNewGoalView(viewModel: .init(),
                           isPresented: $viewModel.showingAddNewGoal)
        })
        .onReceive(viewModel.$refreshAllGoals, perform: {
            if $0 {
                viewModel.goals = goals.filter { $0.isValid && !$0.isArchived }
                viewModel.goalsModels = viewModel.goals.map {
                    let goal = $0
                    let model = MainGoalViewModel(goal: goal,
                                                  isFirstGoal: viewModel.goals.isEmpty,
                                                  showingAddNewGoal: $viewModel.showingAddNewGoal,
                                                  refreshAllGoals: $viewModel.refreshAllGoals)
                    model.goal = goal
                    return model
                }
                viewModel.refreshAllGoals = false
            }
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
