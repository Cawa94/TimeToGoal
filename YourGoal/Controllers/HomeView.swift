//
//  HomeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI
import StoreKit

public class HomeViewModel: ObservableObject {

    @Published var goals: [Goal]
    @Published var journal: [JournalPage]
    @Published var challenges: [Challenge]
    @Published var profile: Profile?
    @Published var indexSelectedGoal: Int = 0
    @Published var showingTrackGoal = false
    @Published var hasTrackedGoal = false
    @Published var showMotivation = false

    @Binding var activeSheet: ActiveSheet?
    @Binding var goalToRenew: Goal?
    
    let quote = FamousQuote.getOneRandom()
    let headerText: String

    init(goals: [Goal], journal: [JournalPage], challenges: [Challenge], profile: Profile?,
         activeSheet: Binding<ActiveSheet?>, goalToRenew: Binding<Goal?>) {
        self.goals = goals.filter { !$0.isArchived }
        self.journal = journal
        self.challenges = challenges
        self.profile = profile
        self._activeSheet = activeSheet
        self._goalToRenew = goalToRenew

        if let name = profile?.name, !name.isEmpty {
            headerText = "\(Date().isEvening ? "home_good_evening".localized() : "home_good_morning".localized()) \(name)"
        } else {
            headerText = goals.isEmpty ? "home_welcome".localized() : "home_welcome_back".localized()
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

                    VStack(spacing: 0) {
                        Spacer()
                            .frame(height: DeviceFix.isRoundedScreen ? 50 : 20)

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

                        Spacer()
                            .frame(height: 10)
                        
                        HStack {
                            Text("home_your_goals")
                                .foregroundColor(.grayLight)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.title4)
                            Spacer()
                        }

                        if !viewModel.goals.isEmpty {
                            TabView {
                                ForEach(0..<viewModel.goals.count) { index in
                                    VStack {
                                        GoalSmallProgressView(viewModel: .init(goal: viewModel.goals[index],
                                                                               challenges: viewModel.challenges,
                                                                               showingTrackGoal: $viewModel.showingTrackGoal,
                                                                               goalToRenew: $viewModel.goalToRenew,
                                                                               indexSelectedGoal: $viewModel.indexSelectedGoal,
                                                                               activeSheet: $viewModel.activeSheet,
                                                                               hasTrackedGoal: $viewModel.hasTrackedGoal,
                                                                               goalIndex: index))
                                            .frame(height: DeviceFix.is65Screen
                                                    ? container.size.height/3 : container.size.height/3.2)
                                        Spacer()
                                    }
                                }
                                .padding([.leading, .trailing], 5)
                            }
                            .frame(width: UIScreen.main.bounds.width,
                                   height: DeviceFix.is65Screen
                                    ? container.size.height/3 + 25 : container.size.height/3.2 + 45)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            .colorScheme(.light)
                        } else {
                            GoalSmallProgressView(viewModel: .init(goal: nil,
                                                                   challenges: viewModel.challenges,
                                                                   showingTrackGoal: $viewModel.showingTrackGoal,
                                                                   goalToRenew: $viewModel.goalToRenew,
                                                                   indexSelectedGoal: $viewModel.indexSelectedGoal,
                                                                   activeSheet: $viewModel.activeSheet,
                                                                   hasTrackedGoal: $viewModel.hasTrackedGoal,
                                                                   goalIndex: nil))
                                .padding([.leading, .trailing], 5)
                                .frame(width: UIScreen.main.bounds.width,
                                       height: DeviceFix.is65Screen
                                        ? container.size.height/3 : container.size.height/3.2)
                        }

                        Spacer()
                            .frame(height: 5)

                        HStack {
                            Text("home_your_week")
                                .foregroundColor(.grayLight)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.title4)
                            Spacer()
                        }

                        Spacer()
                            .frame(height: 15)

                        StatisticsSmallView(viewModel: .init(goals: viewModel.goals,
                                                             journal: viewModel.journal,
                                                             hasTrackedGoal: $viewModel.hasTrackedGoal))
                            .padding([.leading, .trailing], 25)
                            .frame(height: DeviceFix.is65Screen
                                    ? container.size.height/2.7 : container.size.height/3)

                        Spacer()
                    }

                    if viewModel.showingTrackGoal {
                        TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal,
                                            hasTrackedGoal: $viewModel.hasTrackedGoal,
                                            currentGoal: viewModel.goals[viewModel.indexSelectedGoal],
                                            challenges: viewModel.challenges)
                            .transition(.move(edge: .bottom))
                    }
                    /*
                    if viewModel.showMotivation {
                        MotivationalView(viewModel: .init(isPresented: $viewModel.showMotivation))
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.75)))
                    }*/
                }
            }
        }.onReceive(viewModel.$hasTrackedGoal, perform: { hasTrackedGoal in
            if hasTrackedGoal {
                /*if !ContentView.showedQuote {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        ContentView.showedQuote = true
                        viewModel.showMotivation = true
                    }
                }*/
                updatePerfectWeekChallenges()

                if viewModel.goals[viewModel.indexSelectedGoal].isCompleted {
                    #if RELEASE
                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            SKStoreReviewController.requestReview(in: scene)
                        }
                    #endif
                }
            }
        })
    }

    func updatePerfectWeekChallenges() {
        let perfectWeeks = Double(viewModel.goals.perfectWeeks)

        if let challenge = viewModel.challenges.first(where: { $0.id == 2 }) {
            challenge.progressMade = perfectWeeks
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 2
            challenge.progressMade = perfectWeeks
        }

        if let challenge = viewModel.challenges.first(where: { $0.id == 3 }) {
            challenge.progressMade = perfectWeeks
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 3
            challenge.progressMade = perfectWeeks
        }

        if let challenge = viewModel.challenges.first(where: { $0.id == 4 }) {
            challenge.progressMade = perfectWeeks
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 4
            challenge.progressMade = perfectWeeks
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
