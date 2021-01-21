//
//  HoursSelectionView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 12/10/2020.
//

import SwiftUI

private extension CGFloat {

    static let pickerViewWidth: CGFloat = 50 // because it's rotated 90º

}

struct HoursSelectorViewModel {

    var bindingString: Binding<String>
    var goal: Binding<Goal>

}

struct HoursSelectorView: View {

    var viewModel: HoursSelectorViewModel

    var body: some View {
        GeometryReader { vContainer in
            ZStack {
                TextField("", text: viewModel.bindingString)
                    .padding()
                    .foregroundColor(.fieldsLightBackground)
                    .background(Color.fieldsLightBackground)
                    .cornerRadius(.defaultRadius)
                    .disabled(true)
                    .overlay(RoundedRectangle(cornerRadius: .defaultRadius).stroke(Color.greenGoal, lineWidth: 1))
                HorizontalPickerView(selectedValue: viewModel.bindingString,
                                     goal: viewModel.goal,
                                     size: .init(width: vContainer.size.width, height: .pickerViewWidth))
                    .frame(width: vContainer.size.width, height: 30, alignment: .center)
                    .clipped()
            }
        }
    }

}
/*
struct HoursSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        HoursSelectorView()
    }
}
*/
