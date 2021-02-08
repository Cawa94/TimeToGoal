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

    var goalIcons: [String] {
        var iconsNames: [String] = []
        let maxIcons: Int
        /*if currentGoal.goalType == .custom {
            maxIcons = 12
        } else {*/
            maxIcons = 6
        //}
        for i in 0...(maxIcons - 1) {
            iconsNames.append("\(currentGoal.goalType.image)\(i)")
        }
        return iconsNames
    }

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
                        Spacer().frame(maxWidth: .infinity)
                        ZStack {
                            RoundedRectangle(cornerRadius: .defaultRadius)
                                .fill(Color.white)
                                .cornerRadius(50)

                            VStack {
                                Spacer()
                                    .frame(height: 20)

                                ForEach(0..<viewModel.goalIcons.count/3) { row in
                                    HStack(spacing: 25) {
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
                                    }.frame(height: 80)
                                    .buttonStyle(PlainButtonStyle())

                                }

                                Spacer()
                                    .frame(height: 20)
                            }

                        }.frame(width: container.size.width / 1.35, alignment: .center)
                        Spacer().frame(maxWidth: .infinity)
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
