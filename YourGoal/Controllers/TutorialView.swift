//
//  TutorialView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

public class TutorialViewModel: ObservableObject {

    enum TutorialType: String {
        case introduction
        case target
    }

    @Published var tutorialType: TutorialType

    init(tutorialType: TutorialType) {
        self.tutorialType = tutorialType
    }

    var tutorialTitle: String {
        switch tutorialType {
        case .introduction:
            return "tutorial_introduction_title".localized()
        case .target:
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
                    case .introduction:
                        ExplanationView(viewModel: .init(pageNumber: 1,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(1)
                        ExplanationView(viewModel: .init(pageNumber: 2,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(2)
                        ExplanationView(viewModel: .init(pageNumber: 3,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(3)
                        ExplanationView(viewModel: .init(pageNumber: 4,
                                                         isLastPage: true,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(4)
                    case .target:
                        ExplanationView(viewModel: .init(pageNumber: 1,
                                                         shouldDismissSheet: false,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(1)
                        ExplanationView(viewModel: .init(pageNumber: 2,
                                                         shouldDismissSheet: false,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(2)
                        ExplanationView(viewModel: .init(pageNumber: 3,
                                                         shouldDismissSheet: false,
                                                         isLastPage: true,
                                                         tutorialType: viewModel.tutorialType,
                                                         currentPage: $currentPage,
                                                         activeSheet: $activeSheet,
                                                         isPresented: $isPresented)).tag(3)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .colorScheme(.light)
                .navigationBarTitle(viewModel.tutorialTitle, displayMode: .large)
            }.onAppear {
                FirebaseService.logPageViewed(pageName: "Tutorial", className: "TutorialView")
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
