//
//  GoalProgressView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

struct GoalProgressView: View {
    @State var progress: CGFloat
    @State var progressToggle = false

    var body: some View {
        ZStack {
            Color.black

            Circle()
                .trim(from: 0.0, to: progressToggle ? CGFloat(min(self.progress, 1.0)) : 0)
                .stroke(style: StrokeStyle(lineWidth: 40.0,
                                           lineCap: .round,
                                           lineJoin: .round))
                .background(Circle().stroke(lineWidth: 40.0).opacity(0.3).foregroundColor(Color.green))
                .foregroundColor(Color.green)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.easeInOut(duration: 1))
                .onAppear() {
                    withAnimation(.easeInOut(duration: 1)) {
                        self.progressToggle.toggle()
                    }
                }
                .padding()

            VStack {
                Spacer()
                Text("10")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Text("Ore rimaste")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 15)
                Text("Raggiungerai il tuo\nobiettivo il")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Text("04-11-2020")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                Spacer()
            }
        }
    }
}

struct GoalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GoalProgressView(progress: CGFloat(0.4))
            .previewLayout(.fixed(width: 375, height: 400))
    }
}
