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
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 25)

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
                            .bold()
                            .foregroundColor(.white)
                            .font(.title2)
                            .multilineTextAlignment(.center)
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
                .bold() +
            Text("tutorial_first_step_2") +
            Text("SMART")
                .bold() +
            Text("tutorial_first_step_3")
        }.font(.title2)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
    }

    var secondPageText: some View {
        Group {
            Text("tutorial_second_step_1")
                .font(.title2) +
            Text("tutorial_second_step_2")
                .bold() +
            Text("tutorial_second_step_3") +
            Text("tutorial_second_step_4")
                .bold() +
            Text("tutorial_second_step_5")
        }.font(.title2)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
    }

    var thirdPageText: some View {
        Group {
            Text("tutorial_third_step_1")
                .bold() +
            Text("tutorial_third_step_2") +
            Text("tutorial_third_step_3")
                .bold() +
            Text("tutorial_third_step_4") +
            Text("tutorial_third_step_5")
                .bold() +
            Text("tutorial_third_step_6")
        }.font(.title2)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
    }

    var fourthPageText: some View {
        Group {
            Text("TimeToGoal")
                .bold() +
            Text("tutorial_fourth_step_1")
        }.font(.title2)
        .multilineTextAlignment(.center)
        .foregroundColor(.black)
        .padding([.leading, .trailing], 25)
    }

}
/*
struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
    }
}
*/
