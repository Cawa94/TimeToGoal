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
            Color.goalColor = Color(goal?.color ?? "greenGoal")
            UIColor.goalColor = UIColor(named: goal?.color ?? "greenGoal") ?? .goalColor
        }
    }

    @Published var progressViewModel = GoalProgressViewModel()
    @Published var calendarViewModel = HorizontalCalendarViewModel()
    @Published var showingTrackGoal = false

}

struct MainGoalView: View {

    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goal.createdAt, ascending: true)
        ]
    ) var goals: FetchedResults<Goal>

    @ObservedObject var viewModel = MainGoalViewModel()

    @State var showingAddNewGoal = false

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
                        trackTimeButton
                            .frame(maxWidth: .infinity)
                        newGoalButton
                            .frame(maxWidth: .infinity)
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
            }
        }.onAppear(perform: {
            viewModel.goal = goals.last
            UITableView.appearance().backgroundColor = UIColor.pageBackground
            UITableView.appearance().sectionIndexBackgroundColor = UIColor.pageBackground
            UITableView.appearance().sectionIndexColor = UIColor.pageBackground
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
                    Image(systemName: "plus.rectangle.fill").foregroundColor(.goalColor)
                    Text("main_track_progress".localized()).bold().foregroundColor(.goalColor)
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
                self.showingAddNewGoal.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.rectangle.fill").foregroundColor(.goalColor)
                    Text("global_new_goal".localized()).bold().foregroundColor(.goalColor)
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                )
            }.accentColor(.goalColor)
            .sheet(isPresented: $showingAddNewGoal, onDismiss: {
                viewModel.goal = goals.last
            }, content: {
                AddNewGoalView(isPresented: $showingAddNewGoal)
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
