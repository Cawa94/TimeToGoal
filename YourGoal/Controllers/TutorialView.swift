//
//  TutorialView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

struct TutorialView: View {

    @Binding var activeSheet: ActiveSheet?
    @State var currentPage: Int = 1

    @ViewBuilder
    var body: some View {
        NavigationView {
            BackgroundView(color: .defaultBackground) {
                TabView(selection: $currentPage) {
                    ExplanationView(viewModel: .init(pageNumber: 1,
                                                     currentPage: $currentPage,
                                                     activeSheet: $activeSheet)).tag(1)
                    ExplanationView(viewModel: .init(pageNumber: 2,
                                                     currentPage: $currentPage,
                                                     activeSheet: $activeSheet)).tag(2)
                    ExplanationView(viewModel: .init(pageNumber: 3,
                                                     currentPage: $currentPage,
                                                     activeSheet: $activeSheet)).tag(3)
                    ExplanationView(viewModel: .init(pageNumber: 4,
                                                     currentPage: $currentPage,
                                                     activeSheet: $activeSheet)).tag(4)
                }
                .id(0)
                .edgesIgnoringSafeArea(.all)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .colorScheme(.light)
                .navigationBarTitle("tutorial_title", displayMode: .large)
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
