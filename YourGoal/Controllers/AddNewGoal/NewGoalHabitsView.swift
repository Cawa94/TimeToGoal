//
//  NewGoalHabitsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class NewGoalHabitsViewModel: ObservableObject {

    @Published var habits: [GoalType]
    @Published var newGoal: Goal
    @Published var challenges: [Challenge]
    @Published var pressedRow: [Bool] = []

    init(habits: [GoalType], goal: Goal, challenges: [Challenge]) {
        self.habits = habits
        self.newGoal = goal
        self.challenges = challenges
        
        for _ in habits {
            pressedRow.append(false)
        }
    }

}

struct NewGoalHabitsView: View {

    @ObservedObject var viewModel: NewGoalHabitsViewModel

    @State var showTimeView = false
    @State var selectedIndex: Int?

    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    init(viewModel: NewGoalHabitsViewModel, activeSheet: Binding<ActiveSheet?>, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._activeSheet = activeSheet
        self._isPresented = isPresented
    }

    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ZStack {
                    Color.defaultBackground

                    ScrollView {
                        VStack {
                            Spacer()
                                .frame(height: 10)

                            Text("Scegli un'abitudine")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 10)
                                .lineLimit(2)
                                .applyFont(.largeTitle)
                                .listRowBackground(Color.defaultBackground)

                            if selectedIndex != nil {
                                NavigationLink(destination: NewGoalTimeView(viewModel: .init(goal: viewModel.newGoal,
                                                                                             challenges: viewModel.challenges,
                                                                                             isNew: true),
                                                                            activeSheet: $activeSheet,
                                                                            isPresented: $showTimeView),
                                               isActive: $showTimeView) {
                                    EmptyView()
                                }
                            }

                            ForEach(0..<viewModel.habits.count, id: \.self) { index in
                                ZStack {
                                    HabitTypeRow(viewModel: .init(habit: viewModel.habits[index]))
                                        .scaleEffect(viewModel.pressedRow[index] ? 0.9 : 1.0)
                                        .onTapGesture {
                                            viewModel.newGoal.goalType = viewModel.habits[index]
                                            viewModel.newGoal.name = viewModel.habits[index].name
                                            selectedIndex = index
                                            showTimeView = true
                                        }
                                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                viewModel.pressedRow[index] = pressing
                                            }
                                        }, perform: {})
                                }.padding([.top, .leading, .trailing], 20)
                            }

                            Spacer()
                        }
                    }
                }.navigationBarTitle("SMART Habit", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: "chevron.left")
                }, trailing: closeButton)
            }
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

/*
struct NewGoalHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalHabitsView()
    }
}
*/
