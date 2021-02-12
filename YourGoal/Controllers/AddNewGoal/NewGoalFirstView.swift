//
//  NewGoalFirstView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class NewGoalFirstViewModel: ObservableObject {

    @Published var showQuestionsPage = false
    @Published var showHabitsPage = false
    @Published var goalButtonPressed = false
    @Published var habitButtonPressed = false
    @Published var newGoal: Goal

    init() {
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
                        NavigationLink(destination: NewGoalHabitsView(viewModel: .init(habits: GoalType.allGoals, goal: viewModel.newGoal),
                                                                      activeSheet: $activeSheet,
                                                                      isPresented: $viewModel.showHabitsPage),
                                       isActive: $viewModel.showQuestionsPage) {
                            EmptyView()
                        }.hidden()

                        NavigationLink(destination: NewGoalHabitsCategoriesView(viewModel: .init(goal: viewModel.newGoal),
                                                                                activeSheet: $activeSheet,
                                                                                isPresented: $viewModel.showHabitsPage),
                                       isActive: $viewModel.showHabitsPage) {
                            EmptyView()
                        }.hidden()

                        Color.defaultBackground

                        VStack {
                            Spacer()
                                .frame(height: 10)

                            Text("Che cosa vuoi raggiungere?")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 10)
                                .lineLimit(2)
                                .applyFont(.largeTitle)

                            Spacer()
                                .frame(height: 30)

                            goalSection
                                .frame(width: container.size.width - 80, height: container.size.height/4)
                                .background(Color.defaultBackground
                                                .cornerRadius(.defaultRadius)
                                                .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
                                )
                                .scaleEffect(viewModel.goalButtonPressed ? 0.9 : 1.0)
                                .onTapGesture {
                                    viewModel.showQuestionsPage = true
                                }
                                .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        viewModel.goalButtonPressed = pressing
                                    }
                                }, perform: {})

                            Spacer()
                                .frame(height: 50)

                            habitSection
                                .frame(width: container.size.width - 80, height: container.size.height/4)
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
                        }
                    }.navigationBarTitle("Nuovo obiettivo", displayMode: .large)
                    .navigationBarItems(trailing: closeButton)
                }
            }
        }
    }

    var goalSection: some View {
        VStack {
            Text("SMART Goal")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .lineLimit(2)
                .applyFont(.largeTitle)
            
            Text("Progetto, libro, km")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .lineLimit(2)
                .applyFont(.title3)
        }
    }

    var habitSection: some View {
        VStack {
            Text("SMART Habit")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .lineLimit(2)
                .applyFont(.largeTitle)
            
            Text("Leggere, allenarsi, bere")
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 10)
                .lineLimit(2)
                .applyFont(.title3)
        }
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

struct NewGoalFirstView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalFirstView(viewModel: .init(), activeSheet: .constant(nil))
    }
}

struct DeferView<Content: View>: View {

    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
    }

}
