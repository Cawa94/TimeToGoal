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
    @Published var tutorialType: TutorialViewModel.TutorialType

    @Binding var currentPage: Int
    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    init(pageNumber: Int,
         shouldDismissSheet: Bool = true,
         isLastPage: Bool = false,
         tutorialType: TutorialViewModel.TutorialType,
         currentPage: Binding<Int>,
         activeSheet: Binding<ActiveSheet?>,
         isPresented: Binding<Bool>) {
        self.pageNumber = pageNumber
        self.shouldDismissSheet = shouldDismissSheet
        self.isLastPage = isLastPage
        self.tutorialType = tutorialType
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
                        Text(viewModel.isLastPage ? "tutorial_introduction_button" : "global_next")
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
        Text("tutorial_\(viewModel.tutorialType.rawValue)_first_step".localized())
            .multilineTextAlignment(.center)
            .foregroundColor(.grayText)
            .padding([.leading, .trailing], 25)
            .applyFont(.title)
    }

    var secondPageText: some View {
        Text("tutorial_\(viewModel.tutorialType.rawValue)_second_step".localized())
            .multilineTextAlignment(.center)
            .foregroundColor(.grayText)
            .padding([.leading, .trailing], 25)
            .applyFont(.title)
    }

    var thirdPageText: some View {
        Text("tutorial_\(viewModel.tutorialType.rawValue)_third_step".localized())
            .multilineTextAlignment(.center)
            .foregroundColor(.grayText)
            .padding([.leading, .trailing], 25)
            .applyFont(.title)
    }

    var fourthPageText: some View {
        Text("tutorial_\(viewModel.tutorialType.rawValue)_fourth_step".localized())
            .multilineTextAlignment(.center)
            .foregroundColor(.grayText)
            .padding([.leading, .trailing], 25)
            .applyFont(.title)
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
