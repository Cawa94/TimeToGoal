//
//  GoalListRow.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 8/12/20.
//

import SwiftUI

public class GoalListRowModel: ObservableObject {

    @Published var goal: Goal
    @Published var challenges: [Challenge]

    init(goal: Goal, challenges: [Challenge]) {
        self.goal = goal
        self.challenges = challenges
    }

}

struct GoalListRow: View {

    @ObservedObject var viewModel: GoalListRowModel

    var body: some View {
        rowContent
            .listRowBackground(Color.defaultBackground)
    }

    var rowContent: some View {
        VStack(spacing: 5) {
            Text(viewModel.goal.name ?? "")
                .multilineTextAlignment(.center)
                .foregroundColor(viewModel.goal.goalColor)
                .lineLimit(2)
                .applyFont(.largeTitle)

            HStack(spacing: 0) {
                VStack(alignment: .center, spacing: 5) {
                    Image(viewModel.goal.goalIcon)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 55)

                    if !viewModel.goal.isArchived {
                        percentageText
                    }
                }

                Spacer()
                    .frame(width: 25)

                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Striscia attuale")
                            .applyFont(.title2)
                            .foregroundColor(.grayText)
                        Text("2 \(viewModel.goal.customTimeMeasure ?? "")")
                            .applyFont(.title)
                            .foregroundColor(viewModel.goal.goalColor)

                        Spacer()
                            .frame(height: 5)

                        Text("Traguardo raggiunto")
                            .applyFont(.title2)
                            .foregroundColor(.grayText)
                        Text("\(viewModel.goal.datesHasBeenCompleted?.count ?? 0) volte")
                            .applyFont(.title)
                            .foregroundColor(viewModel.goal.goalColor)
                    }

                    Spacer()
                }
            }

        }
        .padding(.top, 10)
        .padding([.bottom, .trailing], 15)
        .padding([.leading], 25)
        .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                    .stroke(Color.grayBorder, lineWidth: 1))
        .background(Color.defaultBackground
                        .cornerRadius(.defaultRadius)
                        .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
                        .listRowBackground(Color.defaultBackground)
        )
    }

    var percentageText: some View {
        Text("\(min(((viewModel.goal.timeCompleted / viewModel.goal.timeRequired) * 100), 100), specifier: "%.0f")%")
            .applyFont(.title)
            .multilineTextAlignment(.center)
    }

}
/*
struct GoalListRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalListRow()
    }
}
*/
