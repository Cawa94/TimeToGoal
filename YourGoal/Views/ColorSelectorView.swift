//
//  ColorSelectorView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import SwiftUI

public class ColorSelectorViewModel: ObservableObject {

    @Binding var currentGoal: Goal

    var colors = ["orangeGoal", "yellowGoal", "greenGoal",
                  "blueGoal", "purpleGoal", "grayGoal"]

    init(goal: Binding<Goal>) {
        self._currentGoal = goal
    }

}

struct ColorSelectorView: View {

    @ObservedObject var viewModel: ColorSelectorViewModel
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.toggle()
                }
            GeometryReader { container in
                VStack() {
                    Spacer().frame(maxWidth: .infinity)
                    HStack {
                        Spacer().frame(maxWidth: .infinity)
                        ZStack {
                            RoundedRectangle(cornerRadius: .defaultRadius)
                                .fill(Color.white)
                                .cornerRadius(50)
                            VStack {
                                Spacer()
                                HStack(spacing: 20) {
                                    ForEach(viewModel.colors.prefix(3), id: \.self) { color in
                                        Button(action: {
                                            viewModel.currentGoal.color = color
                                            isPresented.toggle()
                                        }) {
                                            Circle()
                                                .fill(Color(color))
                                                .aspectRatio(1.0, contentMode: .fit)
                                        }
                                    }
                                }.frame(height: 55)
                                .buttonStyle(PlainButtonStyle())
                                Spacer()
                                HStack(spacing: 20) {
                                    ForEach(viewModel.colors.suffix(3), id: \.self) { color in
                                        Button(action: {
                                            viewModel.currentGoal.color = color
                                            isPresented.toggle()
                                        }) {
                                            Circle()
                                                .fill(Color(color))
                                                .aspectRatio(1.0, contentMode: .fit)
                                        }
                                    }
                                }.frame(height: 55)
                                .buttonStyle(PlainButtonStyle())
                                Spacer()
                            }
                        }.frame(width: container.size.width / 1.5, height: 200, alignment: .center)
                        Spacer().frame(maxWidth: .infinity)
                    }
                    Spacer().frame(maxWidth: .infinity)
                }
            }
        }
    }
}
/*
struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView(viewModel: )
    }
}
*/
