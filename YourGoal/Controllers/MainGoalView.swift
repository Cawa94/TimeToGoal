//
//  MainGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI
import StoreKit

private extension Color {

    static let textForegroundColor: Color = .black

}

public class MainGoalViewModel: ObservableObject {

    @Published var goal: Goal {
        didSet {
            progressViewModel.goal = goal
            showFireworks = goal.isCompleted
            #if RELEASE
                if goal?.isCompleted ?? false {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
            #endif
        }
    }
    @Published var challenges: [Challenge]
    @Published var progressViewModel: GoalProgressViewModel
    @Published var showingTrackGoal = false
    @Published var showFireworks = false
    @Published var showingEditGoal = false
    @Published var showingJournal = false
    @Published var showingAllGoals = false
    @Published var showMotivation = false

    @Binding var activeSheet: ActiveSheet?
    @Binding var refreshAllGoals: Bool

    init(goal: Goal, challenges: [Challenge], activeSheet: Binding<ActiveSheet?>, refreshAllGoals: Binding<Bool>) {
        self.goal = goal
        self.challenges = challenges
        self._activeSheet = activeSheet
        self._refreshAllGoals = refreshAllGoals
        self.progressViewModel = GoalProgressViewModel(goal: goal)
    }

}

struct MainGoalView: View {

    @ObservedObject var viewModel: MainGoalViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            ZStack {
                Color.defaultBackground

                VStack {
                    Spacer()
                        .frame(height: 10)

                    Text(viewModel.goal.name ?? "placeholder_first_goal".localized())
                        .foregroundColor(.textForegroundColor)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 10)
                        .lineLimit(2)
                        .applyFont(.largeTitle)

                    if DeviceFix.is65Screen {
                        Spacer()
                            .frame(height: 15)
                    }

                    Text("\"\(viewModel.goal.whyDefinition ?? "placeholder_why_definition".localized())\"")
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                        .padding([.leading, .trailing], 10)
                        .lineLimit(smallQuotesLines)
                        .applyFont(.title4)

                    Spacer()

                    GoalProgressView(viewModel: GoalProgressViewModel(goal: viewModel.goal))
                        .padding([.leading, .trailing], 30)

                    Spacer()
                        .frame(height: 15)

                    VStack {
                        if (viewModel.goal.isCompleted) && !(viewModel.goal.isArchived) {
                            archiveGoalButton
                                .padding([.leading, .trailing], 15)
                        } else if !(viewModel.goal.isCompleted) {
                            trackTimeButton
                                .padding([.leading, .trailing], 15)
                            editGoalButton
                                .padding([.leading, .trailing], 15)
                        }
                    }

                    Spacer()
                        .frame(height: 35)
                }

                if viewModel.showingTrackGoal {
                    TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal, currentGoal: viewModel.goal)
                        .transition(.move(edge: .bottom))
                        .onReceive(viewModel.$showingTrackGoal, perform: { isShowing in
                            if !isShowing {
                                viewModel.goal = viewModel.goal
                                if !ContentView.showedQuote {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        ContentView.showedQuote = true
                                        viewModel.showMotivation = true
                                    }
                                }
                            }
                        })
                }

                if viewModel.showFireworks {
                    FireworksView(isPresented: $viewModel.showFireworks)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }

                if viewModel.showMotivation {
                    MotivationalView(viewModel: .init(isPresented: $viewModel.showMotivation))
                        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.75)))
                }
            }.navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if !(viewModel.goal.isCompleted) {
                        FirebaseService.logEvent(.trackTimeButton)
                        viewModel.showingTrackGoal = true
                        viewModel.refreshAllGoals = true
                    }
                }
            }) {
                HStack {
                    Spacer()
                    Text("main_track_progress")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .applyFont(.button)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .background(LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal.goalColor)
        }
    }

    var archiveGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.goal.isArchived = true
                PersistenceController.shared.saveContext()
                viewModel.refreshAllGoals = true
            }) {
                HStack {
                    Spacer()
                    Text("global_archive")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .applyFont(.button)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .background(LinearGradient(gradient: Gradient(colors: Color.rainbow),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal.goalColor)
        }
    }

    var editGoalButton: some View {
        HStack {
            Button(action: {
                FirebaseService.logEvent(.editGoalButton)
                viewModel.showingEditGoal = true
            }) {
                HStack {
                    Spacer()
                    Text("global_details")
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.goal.goalColor)
                        .applyFont(.button)
                    Spacer()
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(viewModel.goal.goalColor)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(viewModel.goal.goalColor)
            .fullScreenCover(isPresented: $viewModel.showingEditGoal, content: {
                NewGoalTimeView(viewModel: .init(goal: viewModel.goal,
                                                 challenges: viewModel.challenges,
                                                 isNew: false),
                                activeSheet: .constant(nil),
                                isPresented: $viewModel.showingEditGoal)
            })
        }
    }

    var smallQuotesLines: Int {
        if DeviceFix.isSmallScreen {
            return 2
        } else if DeviceFix.is65Screen {
            return 4
        } else if DeviceFix.isRoundedScreen {
            return 3
        } else {
            return 2
        }
    }

}
/*
struct MainGoalView_Previews: PreviewProvider {
    static var previews: some View {
        MainGoalView(viewModel: .init(goal: .constant(Goal())))
    }
}
*/
