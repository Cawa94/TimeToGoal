//
//  ChallengeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 17/2/21.
//

import SwiftUI

public class ChallengeViewModel: ObservableObject {

    @Published var challenges: [Challenge]
    @Published var challenge: ProfileChallenge

    init(challenges: [Challenge], challenge: ProfileChallenge) {
        self.challenges = challenges
        self.challenge = challenge
    }

    var percentageCompleted: Double {
        if let trackedChallenge = challenges.first(where: { $0.id == challenge.id }) {
            return min((trackedChallenge.progressMade / challenge.goalToReach) * 100, 100)
        }
        return 0
    }

    var hasBounced: Bool {
        if let trackedChallenge = challenges.first(where: { $0.id == challenge.id }) {
            return trackedChallenge.hasBounced
        }
        return false
    }

    var isCompleted: Bool {
        percentageCompleted >= 100
    }

}

struct ChallengeView: View {

    @ObservedObject var viewModel: ChallengeViewModel
    @State var scaleSize: CGFloat = 1

    var body: some View {
        VStack(spacing: 5) {
            Image(viewModel.challenge.image)
                .resizable()
                .scaledToFit()
                .padding(15)
                .saturation(viewModel.isCompleted ? 1.0 : 0.0)
                .scaleEffect(scaleSize)
                .animation(
                    Animation
                        .easeInOut(duration: 0.45)
                        .repeatForever(autoreverses: true)
                ).onAppear(perform: {
                    if viewModel.isCompleted && !viewModel.hasBounced {
                        scaleSize = 1.15
                    }
                })

            Text(viewModel.challenge.name.localized())
                .foregroundColor(.grayText)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 15)
                .applyFont(.title3)

            percentageBar
                .frame(height: 25)
                .padding([.leading, .trailing], 15)

            Spacer()
                .frame(height: 15)
        }
    }

    var percentageBar: some View {
        GeometryReader { container in
            let barWidth = container.size.width
            let grayGradients: [Color] = [.grayGradient2]
            let orangeGradients: [Color] = [.orangeGoal, .orangeGradient1, .orangeGradient2]
            let percentageCompleted = CGFloat(viewModel.percentageCompleted)

            ZStack {
                if percentageCompleted > 0 {
                    HStack {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: orangeGradients),
                                                 startPoint: .leading, endPoint: .trailing))
                            .opacity(0.3)
                    }

                    HStack {
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: orangeGradients),
                                                 startPoint: .leading, endPoint: .trailing))
                            .frame(width: min(CGFloat(barWidth/100 * percentageCompleted), barWidth))

                        Spacer()
                            .frame(width: CGFloat(barWidth/100 * (100 - percentageCompleted)))
                    }
                } else {
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: grayGradients),
                                             startPoint: .leading, endPoint: .trailing))
                        .opacity(0.3)
                }
            }.clipShape(RoundedRectangle(cornerRadius: .defaultRadius))
        }
    }

}
/*
struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
*/
