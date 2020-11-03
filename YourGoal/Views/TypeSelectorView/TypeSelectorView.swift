//
//  TypeSelectorView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import SwiftUI

public class TypeSelectorViewModel: ObservableObject {

    @Published var goal: Goal?

    var goalTypes = GoalType.allValues

}

struct TypeSelectorView: View {

    @ObservedObject var viewModel = TypeSelectorViewModel()

    var body: some View {
        HStack(content: {
            ForEach(viewModel.goalTypes, id: \.self) { type in
                Button(action: {
                    viewModel.goal?.goalType = type
                }) {
                    TypeCellView(viewModel: .init(type: type,
                                                  color: viewModel.goal?.goalColor ?? .goalColor,
                                                  isSelected: viewModel.goal?.goalType == type))
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               minHeight: 0,
                               maxHeight: .infinity)
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
