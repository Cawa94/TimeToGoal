//
//  HoursSelectionView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 12/10/2020.
//

import SwiftUI

struct HoursSelectorView: View {

    @State var goal: Goal

    @Binding var bindingString: String

    var body: some View {
        GeometryReader { vContainer in
            ZStack {
                if bindingString == "0.0" || bindingString == "" {
                    TextField("", text: $bindingString)
                        .padding()
                        .foregroundColor(.clear)
                        .background(Color.defaultBackground)
                        .cornerRadius(.defaultRadius)
                        .disabled(true)
                        .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                    .stroke(Color.grayBorder, lineWidth: 1))
                } else {
                    TextField("", text: $bindingString)
                        .padding()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: goal.rectGradientColors),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(.defaultRadius)
                        .disabled(true)
                        .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                    .stroke(Color.grayBorder, lineWidth: 1))
                }

                if goal.timeTrackingType == .hoursWithMinutes {
                    HorizontalPickerView(goal: goal,
                                         selectedValue: $bindingString,
                                         size: .init(width: vContainer.size.width, height: 50))
                        .frame(width: vContainer.size.width, height: vContainer.size.height + 5, alignment: .center)
                        .clipped()
                } else {
                    HorizontalPickerView(goal: goal,
                                         selectedValue: $bindingString,
                                         size: .init(width: vContainer.size.width, height: 35))
                        .frame(width: vContainer.size.width, height: vContainer.size.height + 5, alignment: .center)
                        .clipped()
                }
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
