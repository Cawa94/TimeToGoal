//
//  HabitTypeRow.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class HabitTypeRowModel: ObservableObject {

    @Published var habit: GoalType

    init(habit: GoalType) {
        self.habit = habit
    }

}

struct HabitTypeRow: View {

    @ObservedObject var viewModel: HabitTypeRowModel

    var body: some View {
        HStack() {
            Text(viewModel.habit.name)
                .fontWeight(.semibold)
                .applyFont(.largeTitle)
                .foregroundColor(.grayText)

            Spacer()

            Image(viewModel.habit.image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 40)
                .padding([.top, .bottom], 10)

        }
        .padding(20)
        .background(Color.defaultBackground
                        .cornerRadius(.defaultRadius)
                        .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
        )
    }

}
/*
struct HabitTypeRow_Previews: PreviewProvider {
    static var previews: some View {
        HabitTypeRow()
    }
}
*/
