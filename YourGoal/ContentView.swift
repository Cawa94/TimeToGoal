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
            ForEach(viewModel.goals + [nil], id: \.self) { goal in
                MainGoalView(viewModel: .init(goal: goal,
                                              isFirstGoal: viewModel.goals.isEmpty,
                                              showingAddNewGoal: $viewModel.showingAddNewGoal,
                                              refreshAllGoals: $viewModel.refreshAllGoals))
                    /*.tabItem {
                        if let color = goal?.goalColor {
                            Image("book_icon")
                                .frame(width: 5, height: 5)
                                .accentColor(color)
                        } else {
                            Image("training_icon")
                                .frame(width: 5, height: 5)
                                .accentColor(.gray)
                        }
                    }*/
            }
        }
        .id(viewModel.goals.count)
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .colorScheme(.light)
        .onAppear(perform: {
            viewModel.goals = goals.filter { $0.isValid && !$0.isArchived }
        })
        .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
            for invalidGoal in goals.filter({ !$0.isValid }) {
                PersistenceController.shared.container.viewContext.delete(invalidGoal)
            }
            viewModel.goals = goals.filter { $0.isValid && !$0.isArchived }
        }, content: {
            AddNewGoalView(viewModel: .init(),
                           isPresented: $viewModel.showingAddNewGoal)
        })
        .onReceive(viewModel.$refreshAllGoals, perform: {
            if $0 {
                viewModel.goals = goals.filter { $0.isValid && !$0.isArchived }
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
