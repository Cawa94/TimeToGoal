//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

enum Page {
    case goals
    case journal
    case home
    case statistics
    case profile
}

public class ContentViewModel: ObservableObject {

    @Published var goals: [Goal] = []
    @Published var journal: [JournalPage] = []
    @Published var activeSheet: ActiveSheet? = UserDefaults.standard.showTutorial ?? true ? .tutorial : nil
    @Published var refreshAllGoals = false
    @Published var refreshJournal = false
    @Published var currentPage: Page = .home
    @Published var goalsButtonPressed = false // to animate button on tap

}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()
    @StateObject var viewRouter = ViewRouter()

    static var showedQuote = false

    var goalsRequest: FetchRequest<Goal>
    var goals: FetchedResults<Goal> { goalsRequest.wrappedValue }

    var journalRequest: FetchRequest<JournalPage>
    var journal: FetchedResults<JournalPage> { journalRequest.wrappedValue }

    init() {
        self.goalsRequest = FetchRequest(
            entity: Goal.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Goal.editedAt, ascending: false)
            ]
        )

        self.journalRequest = FetchRequest(
            entity: JournalPage.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \JournalPage.date, ascending: false)
            ]
        )
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    switch viewRouter.currentPage {
                    case .goals:
                        AllGoalsView(viewModel: .init(goals: viewModel.goals,
                                                      refreshAllGoals: $viewModel.refreshAllGoals,
                                                      activeSheet: $viewModel.activeSheet))
                    case .journal:
                        JournalView(viewModel: .init(journal: viewModel.journal,
                                                     refreshJournal: $viewModel.refreshJournal))
                            .onDisappear(perform: {
                                viewModel.refreshJournal = true
                            })
                    case .home:
                        HomeView(viewModel: .init(goals: viewModel.goals,
                                                  refreshAllGoals: $viewModel.refreshAllGoals))
                        
                    case .statistics:
                        StatisticsView(viewModel: .init())
                    case .profile:
                        ProfileView(viewModel: .init())
                    }
                    HStack(spacing: 35) {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .goals,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "home")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .journal,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "journal")
                        ZStack {
                            Circle()
                                .foregroundColor(.defaultBackground)
                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                .shadow(radius: 2)
                            Image(viewRouter.currentPage == .home ? "goals" : "goals_off")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/6-20 , height: geometry.size.width/6-20)
                        }.offset(y: -geometry.size.height/6/4)
                        .scaleEffect(viewModel.goalsButtonPressed ? 0.8 : 1.0)
                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.goalsButtonPressed = pressing
                            }
                            viewRouter.currentPage = .home
                        }, perform: {})
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .statistics,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "statistics")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .profile,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "profile")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/8)
                    .background(Color.defaultBackground.shadow(radius: 1))
                }
             }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            viewModel.refreshAllGoals = true
            viewModel.refreshJournal = true
        })
        .onReceive(viewModel.$refreshAllGoals, perform: {
            if $0 {
                viewModel.goals = goals.filter { $0.isValid }
                viewModel.refreshAllGoals = false
            }
        })
        .onReceive(viewModel.$refreshJournal, perform: {
            if $0 {
                viewModel.journal = journal.map { $0 }
                viewModel.refreshJournal = false
            }
        })
        .fullScreenCover(item: $viewModel.activeSheet, onDismiss: {
            UserDefaults.standard.showTutorial = false
            for invalidGoal in goals.filter({ !$0.isValid }) {
                PersistenceController.shared.container.viewContext.delete(invalidGoal)
            }
            PersistenceController.shared.saveContext()
            viewModel.refreshAllGoals = true
        }, content: { item in
            switch item {
            case .tutorial:
                TutorialView(activeSheet: $viewModel.activeSheet)
            case .newGoal:
                AddNewGoalView(viewModel: .init(),
                               activeSheet: $viewModel.activeSheet,
                               isPresented: .constant(true))
            }
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
