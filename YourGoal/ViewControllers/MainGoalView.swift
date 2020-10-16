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
            //Color.goalColor = Color(goal?.color ?? "greenGoal")
            //UIColor.goalColor = UIColor(named: goal?.color ?? "greenGoal") ?? .goalColor
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
                    Spacer(minLength: 10)

                    HorizontalCalendarView(viewModel: viewModel.calendarViewModel)
                        .padding([.leading, .trailing])

                    Spacer(minLength: 25)

                    Text(viewModel.goal?.name ?? "main_my_goal".localized())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.textForegroundColor)

                    Spacer()

                    GoalProgressView(viewModel: viewModel.progressViewModel)
                        .padding([.leading, .trailing], 30)

                    Spacer()
                        .frame(height: 20)
                    
                    VStack {
                        if (viewModel.goal?.isCompleted ?? false) || viewModel.goal == nil {
                            newGoalButton
                                .padding([.leading, .trailing], 15)
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
                .background(Color.goalColor)
                .cornerRadius(.defaultRadius)
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
                    Text("global_new_goal".localized())
                        .bold()
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .fill(Color.goalColor)
                )
            }.accentColor(.goalColor)
            .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
                viewModel.goal = goals.last
            }, content: {
                AddNewGoalView(viewModel: .init(),
                               isPresented: $viewModel.showingAddNewGoal)
                    .environment(\.managedObjectContext,
                                 PersistenceController.shared.container.viewContext)
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
                    /*Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.goalColor)*/
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
                )
            }.accentColor(.goalColor)
            .sheet(isPresented: $viewModel.showingAddNewGoal, onDismiss: {
                viewModel.goal = goals.last
            }, content: {
                AddNewGoalView(viewModel: .init(existingGoal: viewModel.goal),
                               isPresented: $viewModel.showingAddNewGoal)
                    .environment(\.managedObjectContext,
                                 PersistenceController.shared.container.viewContext)
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
