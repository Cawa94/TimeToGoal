//
//  TutorialView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

public class TutorialViewModel: ObservableObject {

    enum TutorialType {
        case whatAreSmartGoals
        case howToSetTarget
    }

    @Published var tutorialType: TutorialType

    init(tutorialType: TutorialType) {
        self.tutorialType = tutorialType
    }

    var tutorialTitle: String {
        switch tutorialType {
        case .whatAreSmartGoals:
            return "tutorial_title".localized()
        case .howToSetTarget:
            return "Traguardi 🎯🏆".localized()
        }
    }

}

struct TutorialView: View {

    @ObservedObject var viewModel: TutorialViewModel

    @Binding var isPresented: Bool
    @Binding var activeSheet: ActiveSheet?
    @State var currentPage: Int = 1

    @ViewBuilder
    var body: some View {
        NavigationView {
            BackgroundView(color: .defaultBackground) {
                TabView(selection: $currentPage) {
                    switch viewModel.tutorialType {
                    case .whatAreSmartGoals:
                        ExplanationView(viewModel: .init(pageNumber: 1,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(1)
                        ExplanationView(viewModel: .init(pageNumber: 2,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(2)
                        ExplanationView(viewModel: .init(pageNumber: 3,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(3)
                        ExplanationView(viewModel: .init(pageNumber: 4,
                                                         isLastPage: true,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(4)
                    case .howToSetTarget:
                        ExplanationView(viewModel: .init(pageNumber: 3,
                                                         shouldDismissSheet: false,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(1)
                        ExplanationView(viewModel: .init(pageNumber: 4,
                                                         shouldDismissSheet: false,
                                                         isLastPage: true,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(2)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .colorScheme(.light)
                .navigationBarTitle(viewModel.tutorialTitle, displayMode: .large)
            }
        }
    }

}
/*
struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
*/
