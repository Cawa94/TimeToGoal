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

    @Published var goal: Goal? {
        didSet {
            progressViewModel.goal = goal
            calendarViewModel.goal = goal
            showFireworks = goal?.isCompleted ?? false
            if goal?.isCompleted ?? false {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }
        }
    }

    @Published var progressViewModel = GoalProgressViewModel()
    @Published var calendarViewModel = HorizontalCalendarViewModel()
    @Published var showingTrackGoal = false
    @Published var showFireworks = false
    @Published var showingEditGoal = false
    @Published var showingJournal = true
    @Published var showMotivation = false

    @Binding var activeSheet: ActiveSheet?
    @Binding var refreshAllGoals: Bool

    var isFirstGoal: Bool

    init(goal: Goal?, isFirstGoal: Bool = false, activeSheet: Binding<ActiveSheet?>, refreshAllGoals: Binding<Bool>) {
        self.goal = goal
        self.isFirstGoal = isFirstGoal
        self._activeSheet = activeSheet
        self._refreshAllGoals = refreshAllGoals
    }

}

struct MainGoalView: View {

    @ObservedObject var viewModel: MainGoalViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .pageBackground) {
            ZStack {
                Color.pageBackground

                VStack {
                    Spacer()
                        .frame(height: 15)

                    HorizontalCalendarView(viewModel: viewModel.calendarViewModel)
                        .padding([.leading, .trailing])

                    Spacer()
                        .frame(height: DeviceFix.isRoundedScreen ? 30 : 15)

                    Text(viewModel.goal?.name ?? "global_new_goal".localized())
                        .font(.title)
                        .bold()
                        .foregroundColor(.textForegroundColor)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 10)
                    if !((viewModel.goal?.isCompleted ?? false) || viewModel.goal == nil) {
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            Spacer()
                            Text("\("global_estimated".localized()):")
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.textForegroundColor)
                            Text("\(viewModel.goal?.completionDateExtimated?.formattedAsDateString ?? "")")
                                .font(.title3)
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.textForegroundColor)
                            Spacer()
                        }
                    }

                    Spacer()
                        .frame(height: 30)

                    GoalProgressView(viewModel: viewModel.progressViewModel)
                        .padding([.leading, .trailing], 30)

                    Spacer()
                        .frame(height: 30)
                    
                    VStack {
                        if (viewModel.goal?.isCompleted ?? false) || viewModel.goal == nil {
                            newGoalButton
                                .padding([.leading, .trailing], 15)
                            Spacer()
                                .frame(height: 15)
                        } else {
                            trackTimeButton
                                .padding([.leading, .trailing], 15)
                            Spacer()
                                .frame(height: 15)
                            HStack {
                                editGoalButton
                                    .padding([.leading], 15)
                                    .padding([.trailing], 5)
                                journalButton
                                    .padding([.leading], 5)
                                    .padding([.trailing], 15)
                            }
                        }
                    }

                    Spacer()
                        .frame(height: DeviceFix.isRoundedScreen ? 100 : 65)
                }

                if viewModel.showingTrackGoal {
                    TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal, currentGoal: $viewModel.goal)
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
            }
        }
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if !(viewModel.goal?.isCompleted ?? true) {
                        FirebaseService.logEvent(.trackTimeButton)
                        viewModel.showingTrackGoal.toggle()
                    }
                }
            }) {
                HStack {
                    Spacer()
                    Text("main_track_progress".localized())
                        .bold()
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .background(LinearGradient(gradient: Gradient(colors: viewModel.goal?.rectGradientColors ?? Color.rainbow),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

    var newGoalButton: some View {
        HStack {
            Button(action: {
                if let goal = viewModel.goal, goal.isCompleted {
                    goal.isArchived = true
                    PersistenceController.shared.saveContext()
                    viewModel.refreshAllGoals = true
                } else {
                    FirebaseService.logEvent(.addGoalButton)
                    viewModel.activeSheet = .newGoal
                }
            }) {
                HStack {
                    Spacer()
                    Text(viewModel.goal?.isCompleted ?? false ? "global_archive".localized() : "global_add_goal".localized())
                        .bold()
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .background(LinearGradient(gradient: Gradient(colors: viewModel.goal?.rectGradientColors ?? Color.rainbow),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

    var editGoalButton: some View {
        HStack {
            Button(action: {
                FirebaseService.logEvent(.editGoalButton)
                viewModel.showingEditGoal.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("Dettagli".localized())
                        .bold()
                        .foregroundColor(viewModel.goal?.goalColor)
                        .font(.title3)
                    Spacer()
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(viewModel.goal?.goalColor)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(viewModel.goal?.goalColor)
            .sheet(isPresented: $viewModel.showingEditGoal, onDismiss: {
                /*if let goal = goals.first(where: { $0.id == viewModel.goal?.id }), goal.isValid {
                    viewModel.goal = goal
                }*/
            }, content: {
                AddNewGoalView(viewModel: .init(existingGoal: viewModel.goal),
                               activeSheet: .constant(nil),
                               isPresented: $viewModel.showingEditGoal)
            })
        }
    }

    var journalButton: some View {
        HStack {
            Button(action: {
                //FirebaseService.logEvent(.editGoalButton)
                viewModel.showingJournal.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("Diario".localized())
                        .bold()
                        .foregroundColor(viewModel.goal?.goalColor)
                        .font(.title3)
                    Spacer()
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(viewModel.goal?.goalColor)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(viewModel.goal?.goalColor)
            .sheet(isPresented: $viewModel.showingJournal, onDismiss: {
                /*if let goal = goals.first(where: { $0.id == viewModel.goal?.id }), goal.isValid {
                    viewModel.goal = goal
                }*/
            }, content: {
                if let goal = viewModel.goal {
                    JournalView(viewModel: .init(goal: goal,
                                                 isPresented: $viewModel.showingJournal))
                }
            })
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
