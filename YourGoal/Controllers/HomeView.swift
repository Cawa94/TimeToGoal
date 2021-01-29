//
//  HomeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class HomeViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var lastGoal: Goal?
    @Published var showingTrackGoal = false
    @Published var showMotivation = false

    @Binding var refreshAllGoals: Bool
    
    let quote = FamousQuote.getOneRandom()

    init(goals: [Goal], refreshAllGoals: Binding<Bool>) {
        self.goals = goals.filter { !$0.isArchived }
        self.lastGoal = goals.first
        self._refreshAllGoals = refreshAllGoals
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
                            Text("Buongiorno Yuri")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.navigationLargeTitle)

                            Spacer()

                            ZStack {
                                Circle()
                                    .foregroundColor(.defaultBackground)
                                    .frame(width: 55, height: 55)
                                    .shadow(radius: 2)
                                Image("man_0")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40, height: 40)
                            }.padding(.trailing, 15)
                        }

                        Text("I tuoi obiettivi")
                            .foregroundColor(.grayLight)
                            .multilineTextAlignment(.center)
                            .applyFont(.title3)

                        Spacer()
                            .frame(height: 0)

                        GoalSmallProgressView(viewModel: .init(goal: $viewModel.lastGoal,
                                                               showingTrackGoal: $viewModel.showingTrackGoal))
                            .padding([.leading, .trailing], 5)
                            .frame(height: container.size.height/4)

                        Spacer()
                            .frame(height: 30)

                        Text("La tua settimana")
                            .foregroundColor(.grayLight)
                            .multilineTextAlignment(.center)
                            .applyFont(.title3)

                        Spacer()
                            .frame(height: 20)

                        StatisticsSmallView(viewModel: .init(goals: $viewModel.goals))
                            .padding([.leading, .trailing], 25)
                            .frame(height: container.size.height/3)

                        Spacer()
                    }

                    if viewModel.showingTrackGoal {
                        TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal, currentGoal: $viewModel.lastGoal)
                            .transition(.move(edge: .bottom))
                            .onReceive(viewModel.$showingTrackGoal, perform: { isShowing in
                                if !isShowing {
                                    viewModel.lastGoal = viewModel.lastGoal
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
