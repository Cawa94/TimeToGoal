//
//  ExplanationView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

public class ExplanationViewModel: ObservableObject {

    @Published var pageNumber: Int
    @Published var shouldDismissSheet: Bool
    @Published var isLastPage: Bool

    @Binding var currentPage: Int
    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    init(pageNumber: Int,
         shouldDismissSheet: Bool = true,
         isLastPage: Bool = false,
         currentPage: Binding<Int>,
         activeSheet: Binding<ActiveSheet?>,
         isPresented: Binding<Bool>) {
        self.pageNumber = pageNumber
        self.shouldDismissSheet = shouldDismissSheet
        self.isLastPage = isLastPage
        self._currentPage = currentPage
        self._activeSheet = activeSheet
        self._isPresented = isPresented
    }

}

struct ExplanationView: View {

    @ObservedObject var viewModel: ExplanationViewModel

    @ViewBuilder
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: topSpace)

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

                if viewModel.pageNumber == 4 {
                    Text("tutorial_fourth_step_2")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 25)
                        .applyFont(.title2)
                }

                Spacer()
                    .frame(height: 40)

                Button(action: {
                    if viewModel.isLastPage {
                        if viewModel.shouldDismissSheet {
                            viewModel.activeSheet = nil
                        } else {
                            viewModel.isPresented = false
                        }
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
            }
        }.background(Color.defaultBackground)
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
        .foregroundColor(.grayText)
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
        .foregroundColor(.grayText)
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
        .foregroundColor(.grayText)
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
        .foregroundColor(.grayText)
        .padding([.leading, .trailing], 25)
        .applyFont(.title2)
    }

    var topSpace: CGFloat {
        if DeviceFix.isSmallScreen {
            return 10
        } else if DeviceFix.is65Screen {
            return 40
        } else if DeviceFix.isRoundedScreen {
            return 20
        } else {
            return 10
        }
    }

}
/*
struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
    }
}
*/
