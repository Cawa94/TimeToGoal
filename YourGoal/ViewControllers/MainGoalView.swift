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
                        .padding([.leading, .trailing], 15)

                    Spacer(minLength: 25)
                    
                    HStack {
                        Spacer()
                        if (viewModel.goal?.isCompleted ?? false) || viewModel.goal == nil {
                            newGoalButton
                                .frame(maxWidth: .infinity)
                        } else {
                            trackTimeButton
                                .frame(maxWidth: .infinity)
                            editGoalButton
                                .frame(maxWidth: .infinity)
                        }
                        Spacer()
                    }

                    Spacer(minLength: 40)
                }

                if viewModel.showingTrackGoal {
                    TrackHoursSpentView(isPresented: $viewModel.showingTrackGoal, currentGoal: $viewModel.goal)
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
                if !(viewModel.goal?.isCompleted ?? true) {
                    viewModel.showingTrackGoal.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.goalColor)
                    Text("main_track_progress".localized())
                        .bold()
                        .foregroundColor(.goalColor)
                        .font(.title2)
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                )
            }.accentColor(.goalColor)
        }
    }

    var newGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.showingAddNewGoal.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.goalColor)
                    Text("global_new_goal".localized())
                        .bold()
                        .foregroundColor(.goalColor)
                        .font(.title)
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
                    Image(systemName: "plus.rectangle.fill")
                        .foregroundColor(.goalColor)
                    Text("main_edit_goal".localized())
                        .bold()
                        .foregroundColor(.goalColor)
                        .font(.title3)
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
