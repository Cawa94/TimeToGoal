//
//  IconSelectorView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 22/1/21.
//

import SwiftUI

public class IconSelectorViewModel: ObservableObject {

    @Binding var currentGoal: Goal
    var icons: [String] = []

    init(goal: Binding<Goal>) {
        self._currentGoal = goal
        self.icons = goalIcons
    }

    var goalIcons = ["adventure_1", "adventure_2",
                     "book_0", "book_1", "book_2", "book_3", "book_4", "book_5",
                     "clock_0", "clock_2", "clock_3", "clock_4",
                     "cook_0", "cook_1", "cook_2", "cook_3", "cook_4",
                     "custom_1", "custom_2", "custom_3",
                     "exercise_0", "exercise_1", "exercise_2", "exercise_3", "exercise_5", "exercise_6", "exercise_7", "exercise_8", "exercise_9", "exercise_10", "exercise_11", "exercise_12", "exercise_13", "exercise_14", "exercise_15", "exercise_16", "exercise_17", "exercise_19", "exercise_20", "exercise_22", "exercise_23", "exercise_24", "exercise_25", "exercise_26", "exercise_29",
                     "flower_0", "flower_1", "flower_2", "flower_3",
                     "fruit_0", "fruit_1", "fruit_2", "fruit_3", "fruit_4",
                     "hobby_0", "hobby_1", "hobby_2", "hobby_5", "hobby_6",
                     "home_0", "home_1", "home_2", "home_3", "home_4", "home_5", "home_6", "home_7",
                     "learn_0", "learn_1", "learn_2", "learn_3", "learn_4",
                     "love_0", "love_1", "love_2", "love_3",
                     "mind_0", "mind_1", "mind_4", "mind_6", "mind_7", "mind_8",
                     "music_0", "music_1", "music_2", "music_3", "music_4", "music_5", "music_6", "music_8", "music_9",
                     "plan_0", "plan_1", "plan_2",
                     "project_0", "project_1", "project_2", "project_3", "project_4", "project_5", "project_6",
                     "quit_0", "quit_1", "quit_2", "quit_3", "quit_4", "quit_5",
                     "social_0", "social_1", "social_2", "social_3", "social_5", "social_6",
                     "vegetable_0", "vegetable_1", "vegetable_2",
                     "write_0", "write_2", "write_3", "write_4", "write_5", "write_7", "write_8", "write_9"]

}

struct IconSelectorView: View {

    @ObservedObject var viewModel: IconSelectorViewModel
    @Binding var isPresented: Bool

    init(viewModel: IconSelectorViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            GeometryReader { container in
                VStack() {
                    Spacer().frame(maxWidth: .infinity)

                    HStack {

                        Spacer()

                        ZStack {
                            RoundedRectangle(cornerRadius: .defaultRadius)
                                .fill(Color.white)
                                .cornerRadius(50)

                            ScrollView(showsIndicators: false) {
                                VStack {
                                    Spacer()
                                        .frame(height: 20)

                                    ForEach(0..<viewModel.goalIcons.count/3) { row in
                                        HStack(spacing: 40) {
                                            ForEach(0..<3) { column in
                                                let index = getIndexFor(row: row, column: column)
                                                let icon = viewModel.icons[index]
                                                Button(action: {
                                                    viewModel.currentGoal.icon = icon
                                                    isPresented = false
                                                }) {
                                                    if viewModel.currentGoal.goalIcon == icon {
                                                        Image(icon)
                                                            .resizable()
                                                            .aspectRatio(1.0, contentMode: .fit)
                                                            .frame(width: 45)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: .defaultRadius)
                                                                    .stroke(viewModel.currentGoal.goalColor, lineWidth: 2)
                                                                    .padding(-8)
                                                            )
                                                        
                                                    } else {
                                                        Image(icon)
                                                            .resizable()
                                                            .aspectRatio(1.0, contentMode: .fit)
                                                            .frame(width: 45)
                                                    }
                                                }
                                            }
                                        }.frame(width: container.size.width / 1.3, height: 80)
                                        .buttonStyle(PlainButtonStyle())

                                    }

                                    Spacer()
                                        .frame(height: 20)
                                }
                            }

                        }.frame(width: container.size.width / 1.2, height: container.size.height - 150, alignment: .center)

                        Spacer()
                    }

                    Spacer().frame(maxWidth: .infinity)
                }
            }
        }
    }

    func getIndexFor(row: Int, column: Int) -> Int {
        /*
            0  1  2
          0 1  2  3
          1 4  5  6
          2 7  8  9
          3 10 11 12
          4 13 14 15
          5 16 17 18
          6 19 20 21
        */
        row * 2 + row + column
    }

}
/*
struct IconSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectorView()
    }
}
*/
