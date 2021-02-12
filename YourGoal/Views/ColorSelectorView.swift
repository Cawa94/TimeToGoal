//
//  ColorSelectorView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/11/2020.
//

import SwiftUI

public class ColorSelectorViewModel: ObservableObject {

    @Binding var currentGoal: Goal

    var colors = ["orangeGoal", "redGoal", "greenGoal",
                  "blueGoal", "purpleGoal", "grayGoal",
                  "yellowGoal", "brownGoal", "orangeGoal"]

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
                    isPresented = false
                }

            GeometryReader { container in
                VStack() {
                    Spacer().frame(maxWidth: .infinity)

                    HStack {
                        Spacer()

                        ZStack {
                            RoundedRectangle(cornerRadius: .defaultRadius)
                                .fill(Color.white)
                                .cornerRadius(50)

                            VStack {
                                Spacer()

                                HStack(spacing: 20) {
                                    ForEach(viewModel.colors[0...2], id: \.self) { color in
                                        Button(action: {
                                            viewModel.currentGoal.color = color
                                            isPresented = false
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
                                    ForEach(viewModel.colors[3...5], id: \.self) { color in
                                        Button(action: {
                                            viewModel.currentGoal.color = color
                                            isPresented = false
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
                                    ForEach(viewModel.colors[6...8], id: \.self) { color in
                                        Button(action: {
                                            viewModel.currentGoal.color = color
                                            isPresented = false
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
                        }.frame(width: container.size.width / 1.5, alignment: .center)

                        Spacer()
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
