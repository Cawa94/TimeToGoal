//
//  TimeExplanationView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 2/4/21.
//

import SwiftUI

struct TimeExplanationView: View {

    @Binding var isPresented: Bool

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isPresented = false
                    }
                }

            VStack {
                Spacer()
                    .frame(height: 150)

                Text("tutorial_time_explanation")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .applyFont(.largeTitle)
                    .padding([.leading, .trailing], 40)

                Spacer()
            }
        }
    }

}

struct TimeExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        TimeExplanationView(isPresented: .constant(true))
    }
}
