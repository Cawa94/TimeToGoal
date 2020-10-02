//
//  GoalProgressView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

private extension Color {

    static let textForegroundColor: Color = .black

}

struct GoalProgressView: View {
    @Binding var goal: Goal?

    @State var progressToggle = false
    @State var progressCompletion: Double = 0.0
    @State var completionDate: Date = Date()

    var body: some View {
        ZStack {
            Color.pageBackground

            Circle()
                .trim(from: 0.0,
                      to: progressToggle ? CGFloat(min(progressCompletion, 1.0)) : 0)
                .stroke(style: StrokeStyle(lineWidth: 40.0,
                                           lineCap: .round,
                                           lineJoin: .round))
                .background(Circle().stroke(lineWidth: 40.0).opacity(0.3).foregroundColor(Color.goalColor))
                .foregroundColor(Color.goalColor)
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
                Text("\(goal?.timeRequired ?? 0)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)
                Text("Ore rimaste")
                    .font(.title)
                    .bold()
                    .foregroundColor(.textForegroundColor)
                    .padding(.bottom, 10)
                Text("Raggiungerai il tuo\nobiettivo il")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.textForegroundColor)
                Text("\(completionDate.formatted)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.textForegroundColor)
                    .padding(.bottom, 20)
                Spacer()
            }
        }.onAppear(perform: {
            if let goal = $goal.wrappedValue {
                progressCompletion = Double(goal.timeCompleted / goal.timeRequired)
                completionDate = goal.completionDateExtimated ?? Date()
            } else {
                progressCompletion = 0.4
                completionDate = Date().adding(days: 10)
            }
        })
    }
}

struct GoalProgressView_Previews: PreviewProvider {
    static var previews: some View {
        GoalProgressView(goal: .constant(Goal()))
            .previewLayout(.fixed(width: 375, height: 400))
    }
}
