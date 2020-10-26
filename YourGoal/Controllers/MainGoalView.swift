//
//  MainGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

private extension Color {

    static let textForegroundColor: Color = .black

}

public class MainGoalViewModel: ObservableObject {

    @Published var goal: Goal? {
        didSet {
            progressViewModel.goal = goal
            calendarViewModel.goal = goal
            showFireworks = goal?.isCompleted ?? false
        }
    }

    @Published var progressViewModel = GoalProgressViewModel()
    @Published var calendarViewModel = HorizontalCalendarViewModel()

    @Published var showingTrackGoal = false
    @Published var showingAddNewGoal = false
    @Published var showFireworks = false

}

struct MainGoalView: View {

    var goalsRequest: FetchRequest<Goal>
    var goals: FetchedResults<Goal> { goalsRequest.wrappedValue }

    @ObservedObject var viewModel = MainGoalViewModel()

    init() {
        self.goalsRequest = FetchRequest(
            entity: Goal.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Goal.createdAt, ascending: true)
            ]
        )
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .pageBackground) {
            ZStack {
                Color.pageBackground
                    .ignoresSafeArea()

                VStack {
                    Spacer()
                        .frame(height: 15)

                    HorizontalCalendarView(viewModel: viewModel.calendarViewModel)
                        .padding([.leading, .trailing])

                    Spacer()
                        .frame(height: DeviceFix.isSmallScreen ? 15 : 30)

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
                            editGoalButton
                                .padding([.leading, .trailing], 15)
                        }
                    }

                    Spacer()
                        .frame(height: 15)
                }

                if viewModel.showingTrackGoal {
                    TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal, currentGoal: $viewModel.goal)
                        .transition(.move(edge: .bottom))
                        .onReceive(viewModel.$showingTrackGoal, perform: { isShowing in
                            if !isShowing {
                                viewModel.goal = viewModel.goal
                            }
                        })
                }

                if viewModel.showFireworks {
                    FireworksView(isPresented: $viewModel.showFireworks)
                        .ignoresSafeArea()
                        .allowsHitTesting(false)
                }
            }
        }.onAppear(perform: {
            viewModel.goal = goals.last
            if viewModel.goal == nil {
                viewModel.showingAddNewGoal = true
            }
        })
        .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
            if goals.last?.isValid ?? false {
                viewModel.goal = goals.last
            } else if let goal = goals.last {
                PersistenceController.shared.container.viewContext.delete(goal)
            }
        }, content: {
            AddNewGoalView(viewModel: ((viewModel.goal?.isCompleted ?? false) || viewModel.goal == nil)
                            ? .init() : .init(existingGoal: viewModel.goal),
                           isPresented: $viewModel.showingAddNewGoal)
        })
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if !(viewModel.goal?.isCompleted ?? true) {
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
            }.accentColor(.goalColor)
        }
    }

    var newGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.showingAddNewGoal.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("global_add_goal".localized())
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
            }.accentColor(.goalColor)
            .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
                if goals.last?.isValid ?? false {
                    viewModel.goal = goals.last
                } else if let goal = goals.last {
                    PersistenceController.shared.container.viewContext.delete(goal)
                }
            }, content: {
                AddNewGoalView(viewModel: .init(),
                               isPresented: $viewModel.showingAddNewGoal)
            })
        }
    }

    var editGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.showingAddNewGoal.toggle()
            }) {
                HStack {
                    Spacer()
                    Text("main_edit_goal".localized())
                        .bold()
                        .foregroundColor(.goalColor)
                        .font(.title3)
                    Spacer()
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(.goalColor)
            .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
                if goals.last?.isValid ?? false {
                    viewModel.goal = goals.last
                } else if let goal = goals.last {
                    PersistenceController.shared.container.viewContext.delete(goal)
                }
            }, content: {
                AddNewGoalView(viewModel: .init(existingGoal: viewModel.goal),
                               isPresented: $viewModel.showingAddNewGoal)
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
