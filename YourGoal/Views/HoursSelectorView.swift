//
//  HoursSelectionView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 12/10/2020.
//

import SwiftUI

private extension CGFloat {

    static let pickerViewWidth: CGFloat = 40 // because it's rotated 90º

}

struct HoursSelectorViewModel {

    var title: String
    var bindingString: Binding<String>
    var color: Color

}

struct HoursSelectorView: View {

    var viewModel: HoursSelectorViewModel!

    var body: some View {
        GeometryReader { vContainer in
            VStack {
                Text(viewModel.title).foregroundColor(viewModel.color).bold()
                ZStack {
                    TextField("", text: viewModel.bindingString)
                        .padding()
                        .foregroundColor(.grayFields)
                        .background(Color.grayFields)
                        .cornerRadius(.defaultRadius)
                    HorizontalPickerView(selectedValue: viewModel.bindingString,
                                         size: .init(width: vContainer.size.width, height: .pickerViewWidth))
                        .frame(width: vContainer.size.width, height: 30, alignment: .center)
                        .clipped()
                }
            }.clipped()
        }
    }

}

struct HoursSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        HoursSelectorView()
    }
}
