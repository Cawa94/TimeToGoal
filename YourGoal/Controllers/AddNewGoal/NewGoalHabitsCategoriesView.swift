//
//  AddNewGoalHabitsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class NewGoalHabitsCategoriesViewModel: ObservableObject {

    @Published var newGoal: Goal
    @Published var challenges: [Challenge]
    @Published var pressedRow: [Bool] = []

    init(goal: Goal, challenges: [Challenge]) {
        newGoal = goal
        self.challenges = challenges

        for _ in HabitCategory.allValues {
            pressedRow.append(false)
        }
    }

}

struct NewGoalHabitsCategoriesView: View {

    @ObservedObject var viewModel: NewGoalHabitsCategoriesViewModel

    @State var showHabitsView = false
    @State var showTimeView = false
    @State var selectedIndex: Int?

    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    init(viewModel: NewGoalHabitsCategoriesViewModel, activeSheet: Binding<ActiveSheet?>, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._activeSheet = activeSheet
        self._isPresented = isPresented
    }

    @ViewBuilder
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

                            if let index = selectedIndex {
                                if index == 6 {
                                    NavigationLink(destination: NewGoalTimeView(viewModel: .init(goal: viewModel.newGoal,
                                                                                                 challenges: viewModel.challenges,
                                                                                                 isNew: true),
                                                                                activeSheet: $activeSheet,
                                                                                isPresented: $showTimeView),
                                                   isActive: $showTimeView) {
                                        EmptyView()
                                    }
                                } else {
                                    NavigationLink(destination: NewGoalHabitsView(viewModel: .init(habits: HabitCategory.allValues[index].habits,
                                                                                                   goal: viewModel.newGoal,
                                                                                                   challenges: viewModel.challenges),
                                                                                  activeSheet: $activeSheet,
                                                                                  isPresented: $showHabitsView),
                                                   isActive: $showHabitsView) {
                                        EmptyView()
                                    }
                                }
                            }

                            ForEach(0..<HabitCategory.allValues.count) { index in
                                ZStack {
                                    HabitCategoryRow(viewModel: .init(category: HabitCategory.allValues[index]))
                                        .scaleEffect(viewModel.pressedRow[index] ? 0.9 : 1.0)
                                        .onTapGesture {
                                            selectedIndex = index
                                            if selectedIndex == 6 {
                                                viewModel.newGoal.goalType = .init(
                                                    id: 53, label: "custom", name: "Personalizzato", image: "project_0",
                                                    categoryId: [6], measureUnits: [.session, .km, .page, .hour, .time, .singleTime])
                                                showTimeView = true
                                            } else {
                                                showHabitsView = true
                                            }
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
                        self.isPresented.toggle()
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
struct AddNewGoalHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalHabitsCategoriesView(viewModel: .init(),
                                       activeSheet: .constant(nil),
                                       isPresented: .constant(true))
    }
}
*/
