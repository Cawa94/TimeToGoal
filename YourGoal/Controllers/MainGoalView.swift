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
            showFireworks = isDetailsView ? false : goal?.isCompleted ?? false
            #if RELEASE
                if goal?.isCompleted ?? false {
                    if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        SKStoreReviewController.requestReview(in: scene)
                    }
                }
            #endif
        }
    }
    @Published var allGoals: [Goal] // Used to show allGoals page
    @Published var progressViewModel: GoalProgressViewModel
    @Published var calendarViewModel: HorizontalCalendarViewModel
    @Published var showingTrackGoal = false
    @Published var showFireworks = false
    @Published var showingEditGoal = false
    @Published var showingJournal = false
    @Published var showingAllGoals = false
    @Published var showMotivation = false

    @Binding var activeSheet: ActiveSheet?
    @Binding var refreshAllGoals: Bool

    var isDetailsView = false

    init(goal: Goal?, allGoals: [Goal]? = nil, activeSheet: Binding<ActiveSheet?>, refreshAllGoals: Binding<Bool>, isDetailsView: Bool = false) {
        self.goal = goal
        self.allGoals = allGoals ?? []
        self._activeSheet = activeSheet
        self._refreshAllGoals = refreshAllGoals
        self.progressViewModel = GoalProgressViewModel(goal: goal)
        self.calendarViewModel = HorizontalCalendarViewModel(goal: goal)
        self.isDetailsView = isDetailsView
    }

    var timeRemaining: String {
        if goal?.goalType.timeTrackingType == .hoursWithMinutes {
            let dateRemaining = Double(goal?.timeRequired ?? 0).asHoursAndMinutes
                .remove(Double(goal?.timeCompleted ?? 0).asHoursAndMinutes)
            if dateRemaining > Date().zeroHours {
                return dateRemaining.formattedAsHoursString
            } else {
                return "0"
            }
        } else {
            let timeRemaining = Double(goal?.timeRequired ?? 0) - Double(goal?.timeCompleted ?? 0)
            if timeRemaining > 0 {
                return goal?.goalType.timeTrackingType == .double
                    ? "\(timeRemaining.stringWithTwoDecimals)" : "\(timeRemaining.stringWithoutDecimals)"
            } else {
                return "0"
            }
        }
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

                    Text(viewModel.goal?.name ?? "global_new_goal".localized())
                        .fontWeight(.bold)
                        .foregroundColor(.textForegroundColor)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 10)
                        .lineLimit(2)
                        .applyFont(.largeTitle)

                    Spacer()
                        .frame(height: 15)

                    Text("\"\(viewModel.goal?.whyDefinition ?? "")\"")
                        .italic()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.textForegroundColor)
                        .padding([.leading, .trailing], 10)
                        .lineLimit(3)
                        .applyFont(.smallQuote)

                    Spacer()

                    GoalProgressView(viewModel: viewModel.progressViewModel)
                        .padding([.leading, .trailing], 30)

                    Spacer()
                        .frame(height: 15)

                    VStack {
                        if (viewModel.goal?.isCompleted ?? false) && !viewModel.isDetailsView {
                            archiveGoalButton
                                .padding([.leading, .trailing], 15)
                            Spacer()
                                .frame(height: 15)
                        } else if viewModel.goal == nil {
                            newGoalButton
                                .padding([.leading, .trailing], 15)
                            Spacer()
                                .frame(height: 15)
                            if !viewModel.allGoals.isEmpty {
                                allGoalsButton
                                    .padding([.leading, .trailing], 15)
                            }
                        } else if viewModel.isDetailsView {
                            journalButton
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

                    if !viewModel.isDetailsView {
                        Spacer()
                            .frame(height: DeviceFix.isRoundedScreen ? 100 : 65)
                    }
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
            }.navigationBarTitle("\(viewModel.goal?.name ?? "")", displayMode: .inline)
            .navigationBarHidden(!viewModel.isDetailsView)
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
                    Text("main_track_progress")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .applyFont(.button)
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
                FirebaseService.logEvent(.addGoalButton)
                viewModel.activeSheet = .newGoal
            }) {
                HStack {
                    Spacer()
                    Text("global_add_goal")
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
            }.accentColor(viewModel.goal?.goalColor)
        }
    }

    var archiveGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.goal?.isArchived = true
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
                    Text("global_details")
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.goal?.goalColor)
                        .applyFont(.button)
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
                    Text("global_journal")
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.goal?.goalColor)
                        .applyFont(.button)
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

    var allGoalsButton: some View {
        HStack {
            Button(action: {
                viewModel.showingAllGoals.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("all_goals_title")
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.goal?.goalColor)
                        .applyFont(.button)
                    Spacer()
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.orangeGoal)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(.orangeGoal)
            .sheet(isPresented: $viewModel.showingAllGoals, onDismiss: {
                
            }, content: {
                AllGoalsView(viewModel: .init(goals: viewModel.allGoals,
                                              refreshAllGoals: $viewModel.refreshAllGoals,
                                              isPresented: $viewModel.showingAllGoals))
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
