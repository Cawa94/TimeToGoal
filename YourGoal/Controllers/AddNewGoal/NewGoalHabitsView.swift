//
//  NewGoalHabitsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class NewGoalHabitsViewModel: ObservableObject {

    @Published var showNextView = false
    @Published var habits: [HabitType]

    init(habits: [HabitType]) {
        self.habits = habits
    }

}

struct NewGoalHabitsView: View {

    @ObservedObject var viewModel: NewGoalHabitsViewModel
    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    init(viewModel: NewGoalHabitsViewModel, activeSheet: Binding<ActiveSheet?>, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._activeSheet = activeSheet
        self._isPresented = isPresented

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .defaultBackground
        UITableView.appearance().backgroundColor = .defaultBackground
    }

    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ZStack {
                    Color.defaultBackground

                    VStack {
                        Spacer()
                            .frame(height: 10)

                        List {
                            Text("Scegli un'abitudine")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing], 10)
                                .lineLimit(2)
                                .applyFont(.largeTitle)

                            ForEach(viewModel.habits) { habit in
                                ZStack {
                                    HabitTypeRow(viewModel: .init(habit: habit))
                                    NavigationLink(destination: Text("")) {
                                        EmptyView()
                                    }.buttonStyle(PlainButtonStyle())
                                    .hidden()
                                }
                            }
                        }

                        Spacer()
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
struct NewGoalHabitsView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalHabitsView()
    }
}
*/
