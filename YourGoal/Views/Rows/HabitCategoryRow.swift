//
//  HabitCategoryRow.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/2/21.
//

import SwiftUI

public class HabitCategoryRowModel: ObservableObject {

    @Published var category: HabitCategory

    init(category: HabitCategory) {
        self.category = category
    }

}

struct HabitCategoryRow: View {

    @ObservedObject var viewModel: HabitCategoryRowModel
    @State var showHabitsView = false

    var body: some View {
        HStack(spacing: 15) {
            VStack(alignment: .leading) {
                Text(viewModel.category.name.localized())
                    .applyFont(.largeTitle)
                    .foregroundColor(.grayText)

                Text(viewModel.category.subtitle.localized())
                    .applyFont(.title2)
                    .foregroundColor(.grayText)
            }

            Spacer()

            viewModel.category.image
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: 55)
                .padding([.top, .bottom], 10)

        }
        .padding(20)
        .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                    .stroke(Color.grayBorder, lineWidth: 1))
        .background(Color.defaultBackground
                        .cornerRadius(.defaultRadius)
                        .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
                        .listRowBackground(Color.defaultBackground)
        )
    }

}

/*
struct HabitCategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        HabitCategoryRow()
    }
}
*/
