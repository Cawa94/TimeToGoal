//
//  HomeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class HomeViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var journal: [JournalPage]
    @Published var profile: Profile?
    @Published var indexSelectedGoal: Int = 0
    @Published var showingTrackGoal = false
    @Published var showMotivation = false

    @Binding var activeSheet: ActiveSheet?
    @Binding var refreshAllGoals: Bool
    
    let quote = FamousQuote.getOneRandom()
    let headerText: String

    init(goals: [Goal], journal: [JournalPage], profile: Profile?,
         activeSheet: Binding<ActiveSheet?>, refreshAllGoals: Binding<Bool>) {
        self.goals = goals.filter { !$0.isArchived }
        self.journal = journal
        self.profile = profile
        self._activeSheet = activeSheet
        self._refreshAllGoals = refreshAllGoals
        
        if let name = profile?.name, !name.isEmpty {
            headerText = "\(Date().isEvening ? "Buonasera" : "Buongiorno") \(name)"
        } else {
            headerText = goals.isEmpty ? "Benvenuto" : "Bentornato"
        }
    }

}

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ZStack {
                    Color.defaultBackground

                    VStack {
                        Spacer()
                            .frame(height: DeviceFix.isRoundedScreen ? 60 : 20)

                        HStack {
                            Text(viewModel.headerText)
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.navigationLargeTitle)

                            Spacer()
/*
                            ZStack {
                                Circle()
                                    .foregroundColor(.defaultBackground)
                                    .frame(width: 55, height: 55)
                                    .shadow(radius: 2)
                                Image(viewModel.profile?.image ?? "man_0")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }.padding(.trailing, 15)*/
                        }

                        HStack {
                            Text("I tuoi obiettivi")
                                .foregroundColor(.grayLight)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.title4)
                            Spacer()
                        }

                        Spacer()
                            .frame(height: 0)

                        if !viewModel.goals.isEmpty {
                            TabView {
                                ForEach(0..<viewModel.goals.count) { index in
                                    VStack {
                                        GoalSmallProgressView(viewModel: .init(goal: viewModel.goals[index],
                                                                               showingTrackGoal: $viewModel.showingTrackGoal,
                                                                               indexSelectedGoal: $viewModel.indexSelectedGoal,
                                                                               activeSheet: $viewModel.activeSheet,
                                                                               goalIndex: index))
                                            .frame(height: container.size.height/3.2)
                                        Spacer()
                                    }
                                }
                                .padding([.leading, .trailing], 5)
                            }
                            .frame(width: UIScreen.main.bounds.width, height: container.size.height/3.2 + 45)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .colorScheme(.light)
                        } else {
                            GoalSmallProgressView(viewModel: .init(goal: nil,
                                                                   showingTrackGoal: $viewModel.showingTrackGoal,
                                                                   indexSelectedGoal: $viewModel.indexSelectedGoal,
                                                                   activeSheet: $viewModel.activeSheet,
                                                                   goalIndex: nil))
                                .padding([.leading, .trailing], 5)
                                .frame(width: UIScreen.main.bounds.width, height: container.size.height/3.2)
                        }

                        Spacer()
                            .frame(height: 5)

                        HStack {
                            Text("La tua settimana")
                                .foregroundColor(.grayLight)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.title4)
                            Spacer()
                        }

                        Spacer()
                            .frame(height: 15)

                        StatisticsSmallView(viewModel: .init(goals: viewModel.goals,
                                                             journal: viewModel.journal))
                            .padding([.leading, .trailing], 25)
                            .frame(height: container.size.height/3)

                        Spacer()
                    }

                    if viewModel.showingTrackGoal {
                        TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal,
                                            currentGoal: viewModel.goals[viewModel.indexSelectedGoal])
                            .transition(.move(edge: .bottom))
                            .onReceive(viewModel.$showingTrackGoal, perform: { isShowing in
                                if !isShowing {
                                    if !ContentView.showedQuote {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            ContentView.showedQuote = true
                                            viewModel.showMotivation = true
                                        }
                                    }
                                }
                            })
                    }
                    
                    if viewModel.showMotivation {
                        MotivationalView(viewModel: .init(isPresented: $viewModel.showMotivation))
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.75)))
                    }
                }
            }
        }
    }

}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/
