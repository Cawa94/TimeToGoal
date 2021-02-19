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

    @Binding var isPresented: Bool
    @Binding var activeSheet: ActiveSheet?
    @Binding var refreshAllGoals: Bool
    @Binding var goals: [Goal]

    init(goal: Goal, goals: Binding<[Goal]>, challenges: [Challenge], isPresented: Binding<Bool>,
         activeSheet: Binding<ActiveSheet?>, refreshAllGoals: Binding<Bool>) {
        self.goal = goal
        self.challenges = challenges
        self._isPresented = isPresented
        self._activeSheet = activeSheet
        self._refreshAllGoals = refreshAllGoals
        self._goals = goals
        self.progressViewModel = GoalProgressViewModel(goal: goal)
    }

}

struct MainGoalView: View {

    @ObservedObject var viewModel: MainGoalViewModel
    @State private var feedback = UINotificationFeedbackGenerator()

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ZStack {
                    Color.defaultBackground

                    ScrollView {
                        VStack(spacing: 10) {
                            Spacer()
                                .frame(height: 15)

                            Text("\"\(viewModel.goal.whyDefinition ?? "placeholder_why_definition".localized())\"")
                                .italic()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.textForegroundColor)
                                .padding([.leading, .trailing], 10)
                                .applyFont(.title4)

                            Spacer()
                                .frame(height: 25)

                            GoalProgressView(viewModel: GoalProgressViewModel(goal: viewModel.goal))
                                .frame(width: container.size.width - 50, height: container.size.width - 50)

                            Spacer()
                                .frame(height: 25)

                            deleteGoalButton
                                .padding([.leading, .trailing], 15)

                            Spacer()
                                .frame(height: 20)
                        }
                    }

                    if viewModel.showingTrackGoal {
                        TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal,
                                            currentGoal: viewModel.goal,
                                            challenges: viewModel.challenges)
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

                }.navigationBarTitle(viewModel.goal.name ?? "", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    Button(action: {
                        self.viewModel.isPresented = false
                    }) {
                        Image(systemName: "chevron.left")
                }, trailing: editButton)
            }
        }.fullScreenCover(isPresented: $viewModel.showingEditGoal, content: {
            NavigationView {
                NewGoalTimeView(viewModel: .init(goal: viewModel.goal,
                                                 challenges: viewModel.challenges,
                                                 isNew: false),
                                activeSheet: $viewModel.activeSheet,
                                isPresented: $viewModel.showingEditGoal)
            }
        })
    }

    func updateCompleteGoalChallenge() {
        if !(viewModel.goal.goalType.isHabit) {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 10
            challenge.progressMade = 1
        }
    }

    func updateTrackingChallenge() {
        if let challenge = viewModel.challenges.first(where: { $0.id == 7 }) {
            challenge.progressMade += 1
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 7
            challenge.progressMade = 1
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 8 }) {
            challenge.progressMade += 1
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 8
            challenge.progressMade = 1
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 9 }) {
            challenge.progressMade += 1
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 9
            challenge.progressMade = 1
        }
    }

    func createGoalProgress(time: Double) -> Progress {
        let progress = Progress(context: PersistenceController.shared.container.viewContext)
        progress.date = Date()
        progress.hoursOfWork = time
        progress.dayId = Date().customId
        return progress
    }

    func trackGoalWithSingleTime() {
        viewModel.goal.timesHasBeenTracked += 1
        let timeTracked = Double(1)
        FirebaseService.logEvent(.timeTracked)
        viewModel.goal.timeCompleted += timeTracked
        let progress = createGoalProgress(time: timeTracked)
        viewModel.goal.addToProgress(progress)
        viewModel.goal.editedAt = Date()
        if viewModel.goal.isCompleted {
            viewModel.goal.completedAt = Date()
            viewModel.goal.timesHasBeenCompleted += 1
            FirebaseService.logConversion(.goalCompleted, goal: viewModel.goal)
            updateCompleteGoalChallenge()
        }
        updateTrackingChallenge()
        PersistenceController.shared.saveContext()
        self.feedback.notificationOccurred(.success)
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if MeasureUnit.getFrom(viewModel.goal.customTimeMeasure ?? "") == .singleTime {
                        trackGoalWithSingleTime()
                        viewModel.showingTrackGoal = false
                    } else {
                        FirebaseService.logEvent(.trackTimeButton)
                        viewModel.showingTrackGoal = true
                        viewModel.refreshAllGoals = true
                    }
                }
            }) {
                HStack {
                    Spacer()
                    Text("main_track_progress")
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

    var deleteGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.goals.removeAll(where: { $0.id == viewModel.goal.id })
                viewModel.refreshAllGoals = true
                PersistenceController.shared.container.viewContext.delete(viewModel.goal)
                PersistenceController.shared.saveContext()
                self.viewModel.isPresented = false
            }) {
                HStack {
                    Spacer()
                    Text("Cancella")
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

    var editButton: some View {
        Button(action: {
            viewModel.showingEditGoal = true
        }) {
            Text("Modifica")
                .foregroundColor(.grayText)
                .applyFont(.title4)
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
