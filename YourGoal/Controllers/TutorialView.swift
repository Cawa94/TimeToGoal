//
//  TutorialView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

struct TutorialView: View {

    @Binding var activeSheet: ActiveSheet?

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .pageBackground) {
            NavigationView {
                TabView {
                    ExplanationView(viewModel: .init(text: "tutorial_first_step_text".localized(),
                                                     image: "tutorial_first_step_image".localized()),
                                    activeSheet: $activeSheet)
                    ExplanationView(viewModel: .init(text: "tutorial_second_step_text".localized(),
                                                     image: "tutorial_second_step_image".localized()),
                                    activeSheet: $activeSheet)
                    ExplanationView(viewModel: .init(text: "tutorial_third_step_text".localized(),
                                                     image: "tutorial_third_step_image".localized()),
                                    activeSheet: $activeSheet)
                    ExplanationView(viewModel: .init(text: "tutorial_fourth_step_text".localized(),
                                                     image: "tutorial_fourth_step_image".localized(),
                                                     showArrow: false),
                                    activeSheet: $activeSheet)
                }
                .id(0)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .colorScheme(.light)
                .navigationBarTitle("Come funziona?", displayMode: .large)
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
