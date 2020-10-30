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

}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    var goalsRequest: FetchRequest<Goal>
    var goals: FetchedResults<Goal> { goalsRequest.wrappedValue }

    init() {
        self.goalsRequest = FetchRequest(
            entity: Goal.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Goal.editedAt, ascending: true)
            ]
        )
    }

    @ViewBuilder
    var body: some View {
        VStack {
            TabView {
                ForEach(Array(viewModel.goals), id: \.self) { goal in
                    MainGoalView(mainGoalViewModel: .init(goal: goal,
                                                          showingAddNewGoal: $viewModel.showingAddNewGoal))
                }
                MainGoalView(mainGoalViewModel: .init(goal: nil,
                                                      isFirstGoal: viewModel.goals.isEmpty,
                                                      showingAddNewGoal: $viewModel.showingAddNewGoal))
            }
            .ignoresSafeArea()
            .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .colorScheme(.light)
            .onAppear(perform: {
                viewModel.goals = goals.filter { $0.isValid }
            })
            .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
                viewModel.goals = goals.filter { $0.isValid }
            }, content: {
                AddNewGoalView(viewModel: .init(),
                               isPresented: $viewModel.showingAddNewGoal)
            })
            Spacer()
                .frame(height: 10)
        }.ignoresSafeArea()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
