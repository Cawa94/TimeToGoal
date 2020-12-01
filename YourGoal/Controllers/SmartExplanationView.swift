//
//  SmartExplanationView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import SwiftUI

struct SmartExplanationView: View {

    @Binding var isPresented: Bool

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .pageBackground) {
            NavigationView {
                VStack {
                    Text("A long explanation")
                }.navigationBarTitle("SMART Goals".localized(), displayMode: .large)
            }
        }
    }

}
/*
struct SmartExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        SmartExplanationView()
    }
}
*/
