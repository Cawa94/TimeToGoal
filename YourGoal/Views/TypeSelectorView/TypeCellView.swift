//
//  TypeCellView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import SwiftUI

struct TypeCellViewModel: Identifiable {

    let id: Int
    let type: GoalType
    let color: Color
    let isSelected: Bool

}

struct TypeCellView: View {

    let viewModel: TypeCellViewModel

    @ViewBuilder
    var body: some View {
        if viewModel.isSelected {
            Image(viewModel.type.defaultIcon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: .iconRadius)
                        .stroke(viewModel.color, lineWidth: 2)
                        .padding(-4)
                )
        } else {
            Image(viewModel.type.defaultIcon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
        }
    }

}
/*
struct TypeCellView_Previews: PreviewProvider {
    static var previews: some View {
 TypeCellView(viewModel: .init(id: 0, type: .book, color: .blue, isSelected: true))
            .previewLayout(.fixed(width: 70, height: 70))
    }
}
*/
