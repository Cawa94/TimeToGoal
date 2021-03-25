//
//  NewGoalFirstView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class NewGoalFirstViewModel: ObservableObject {

    @Published var showGoalsPage = false
    @Published var showHabitsPage = false
    @Published var goalButtonPressed = false
    @Published var habitButtonPressed = false

    @Published var newGoal: Goal
    @Published var challenges: [Challenge]

    init(challenges: [Challenge]) {
        self.challenges = challenges

        newGoal = Goal(context: PersistenceController.shared.container.viewContext)
        newGoal.color = "orangeGoal"
    }

}

struct NewGoalFirstView: View {

    @ObservedObject var viewModel: NewGoalFirstViewModel

    @Binding var activeSheet: ActiveSheet?

    @ViewBuilder
    var body: some View {
        NavigationView {
            BackgroundView(color: .defaultBackground) {
                GeometryReader { container in
                    ZStack {
                        NavigationLink(destination: NewGoalHabitsView(viewModel: .init(habits: GoalType.allGoals,
                                                                                       goal: viewModel.newGoal,
                                                                                       challenges: viewModel.challenges),
                                                                      activeSheet: $activeSheet,
                                                                      isPresented: $viewModel.showGoalsPage),
                                       isActive: $viewModel.showGoalsPage) {
                            EmptyView()
                        }.hidden()

                        NavigationLink(destination: NewGoalHabitsCategoriesView(viewModel: .init(goal: viewModel.newGoal,
                                                                                                 challenges: viewModel.challenges),
                                                                                activeSheet: $activeSheet,
                                                                                isPresented: $viewModel.showHabitsPage),
                                       isActive: $viewModel.showHabitsPage) {
                            EmptyView()
                        }.hidden()

                        Color.defaultBackground

                        VStack {
                            Spacer()
                                .frame(height: 10)

                            Text("add_goal_type_title")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 10)
                                .lineLimit(2)
                                .applyFont(.largeTitle)

                            Spacer()
                                .frame(height: 30)

                            habitSection
                                .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                            .stroke(Color.grayBorder, lineWidth: 1))
                                .background(Color.defaultBackground
                                                .cornerRadius(.defaultRadius)
                                                .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
                                )
                                .scaleEffect(viewModel.habitButtonPressed ? 0.9 : 1.0)
                                .onTapGesture {
                                    viewModel.showHabitsPage = true
                                }
                                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        viewModel.habitButtonPressed = pressing
                                    }
                                }, perform: {})

                            Spacer()
                                .frame(height: 50)

                            goalSection
                                .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                            .stroke(Color.grayBorder, lineWidth: 1))
                                .background(Color.defaultBackground
                                                .cornerRadius(.defaultRadius)
                                                .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
                                )
                                .scaleEffect(viewModel.goalButtonPressed ? 0.9 : 1.0)
                                .onTapGesture {
                                    viewModel.showGoalsPage = true
                                }
                                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        viewModel.goalButtonPressed = pressing
                                    }
                                }, perform: {})

                            Spacer()
                        }.padding([.leading, .trailing], 20)
                    }.navigationBarTitle("add_goal_first_title", displayMode: .large)
                    .navigationBarItems(trailing: closeButton)
                }
            }
        }
    }

    var habitSection: some View {
        VStack {
            Text("global_smart_habit")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .applyFont(.largeTitle)
            
            Text("add_goal_smart_habit_definition")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .applyFont(.title3)
        }.padding(20)
    }

    var goalSection: some View {
        VStack {
            Text("global_smart_goal")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .applyFont(.largeTitle)

            Text("add_goal_smart_goal_definition")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .applyFont(.title3)
        }.padding(20)
    }

    var closeButton: some View {
        Button(action: {
            self.activeSheet = nil
        }) {
            Image("close")
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 15)
        }
    }
}
/*
struct NewGoalFirstView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalFirstView(viewModel: .init(), activeSheet: .constant(nil))
    }
}
*/
