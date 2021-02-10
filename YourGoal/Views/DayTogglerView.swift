//
//  DayTogglerView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 10/2/21.
//

import SwiftUI

struct DayTogglerView: View {

    @State var isSelected: Bool = false

    @Binding var bindingString: String
    @Binding var goal: Goal

    var body: some View {
        Button(action: {
            if !isSelected {
                $bindingString.wrappedValue = "1.0"
                isSelected = true
            } else {
                $bindingString.wrappedValue = "0.0"
                isSelected = false
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: .defaultRadius)
                    .stroke(Color.grayBorder, lineWidth: 1)
                if isSelected {
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .fill(LinearGradient(gradient: Gradient(colors: goal.rectGradientColors),
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(.defaultRadius)
                }
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .aspectRatio(1.0, contentMode: .fit)
    }

}

/*
struct DayTogglerView_Previews: PreviewProvider {
    static var previews: some View {
        DayTogglerView()
    }
}
*/
