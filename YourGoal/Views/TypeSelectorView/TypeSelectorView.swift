//
//  TypeSelectorView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import SwiftUI

public class TypeSelectorViewModel: ObservableObject {

    @Binding var goal: Goal
    @Published var goalTypesModels: [TypeCellViewModel]

    init(goal: Binding<Goal>) {
        self._goal = goal
        self.goalTypesModels = GoalType.allValues.enumerated().map {
            TypeCellViewModel(id: $0.offset,
                              type: $0.element,
                              color: goal.wrappedValue.goalColor,
                              isSelected: goal.wrappedValue.goalType == $0.element)
        }
    }

}

struct TypeSelectorView: View {

    @ObservedObject var viewModel: TypeSelectorViewModel

    var body: some View {
        HStack(content: {
            ForEach(viewModel.goalTypesModels, id: \.id) { typeModel in
                Button(action: {
                    viewModel.goal.goalType = typeModel.type
                    viewModel.goal = viewModel.goal
                }) {
                    TypeCellView(viewModel: typeModel)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            }
        }).frame(width: .infinity, height: 45, alignment: .center)
    }
}
/*
struct TypeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelectorView(viewModel: .init(goal: Goal()))
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
*/
