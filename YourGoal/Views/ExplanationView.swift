//
//  ExplanationView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

public class ExplanationViewModel: ObservableObject {

    @Published var pageNumber: Int

    @Binding var currentPage: Int
    @Binding var activeSheet: ActiveSheet?

    init(pageNumber: Int, currentPage: Binding<Int>, activeSheet: Binding<ActiveSheet?>) {
        self.pageNumber = pageNumber
        self._currentPage = currentPage
        self._activeSheet = activeSheet
    }

}

struct ExplanationView: View {

    @ObservedObject var viewModel: ExplanationViewModel

    @ViewBuilder
    var body: some View {
        GeometryReader { container in
            VStack {
                Spacer()
                    .frame(height: DeviceFix.isSmallScreen ? 10 : 45)

                switch viewModel.pageNumber {
                case 1:
                    firstPageText
                case 2:
                    secondPageText
                case 3:
                    thirdPageText
                default:
                    fourthPageText
                }

                Spacer()

                if viewModel.pageNumber == 4 {
                    Text("tutorial_fourth_step_2")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 25)
                        .applyFont(.title2)

                    Spacer()
                        .frame(height: 40)
                }

                Button(action: {
                    if viewModel.currentPage == 4 {
                        viewModel.activeSheet = nil
                    } else {
                        withAnimation {
                            viewModel.currentPage += 1
                        }
                    }
                }) {
                    HStack {
                        Spacer()
                        Text(viewModel.pageNumber == 4 ? "tutorial_close_button" : "global_next")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .applyFont(.button)
                        Spacer()
                    }
                    .padding([.top, .bottom], 15)
                    .background(LinearGradient(gradient: Gradient(colors: [.orangeGoal, .orangeGradient1, .orangeGradient2]),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.defaultRadius)
                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                }.padding([.leading, .trailing], 30)

                Spacer()
                    .frame(height: DeviceFix.isSmallScreen ? 50 : 75)
            }.frame(width: container.size.width, height: container.size.height)
        }
    }

    var firstPageText: some View {
        Group {
            Text("tutorial_first_step_1") +
            Text("TimeToGoal")
                .fontWeight(.semibold) +
            Text("tutorial_first_step_2") +
            Text("SMART")
                .fontWeight(.semibold) +
            Text("tutorial_first_step_3")
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
        .applyFont(.title2)
    }

    var secondPageText: some View {
        Group {
            Text("tutorial_second_step_1") +
            Text("tutorial_second_step_2")
                .fontWeight(.semibold) +
            Text("tutorial_second_step_3") +
            Text("tutorial_second_step_4")
                .fontWeight(.semibold) +
            Text("tutorial_second_step_5")
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
        .applyFont(.title2)
    }

    var thirdPageText: some View {
        Group {
            Text("tutorial_third_step_1")
                .fontWeight(.semibold) +
            Text("tutorial_third_step_2") +
            Text("tutorial_third_step_3")
                .fontWeight(.semibold) +
            Text("tutorial_third_step_4") +
            Text("tutorial_third_step_5")
                .fontWeight(.semibold) +
            Text("tutorial_third_step_6")
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
        .applyFont(.title2)
    }

    var fourthPageText: some View {
        Group {
            Text("TimeToGoal")
                .fontWeight(.semibold) +
            Text("tutorial_fourth_step_1")
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
        .applyFont(.title2)
    }

}
/*
struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
    }
}
*/
