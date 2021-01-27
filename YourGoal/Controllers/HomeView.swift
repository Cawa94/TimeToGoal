//
//  HomeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class HomeViewModel: ObservableObject {

    @Published var lastGoal: Goal?

    @Binding var refreshAllGoals: Bool

    init(lastGoal: Goal?, refreshAllGoals: Binding<Bool>) {
        self.lastGoal = lastGoal
        self._refreshAllGoals = refreshAllGoals
    }

}

struct HomeView: View {

    @ObservedObject var viewModel: HomeViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            VStack {
                Spacer()
                    .frame(height: DeviceFix.isRoundedScreen ? 60 : 20)

                HStack {
                    Text("Buongiorno Yuri")
                        .foregroundColor(.grayText)
                        .multilineTextAlignment(.leading)
                        .padding([.leading], 15)
                        .applyFont(.navigationLargeTitle)

                    Spacer()

                    ZStack {
                        Circle()
                            .foregroundColor(.defaultBackground)
                            .frame(width: 55, height: 55)
                            .shadow(radius: 2)
                        Image("man_0")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                    }.padding(.trailing, 15)
                }

                Text(viewModel.lastGoal?.name ?? "")
                    .applyFont(.largeTitle)
                    .padding([.leading, .trailing], 45)

                Spacer()
            }
        }
    }

}

/*
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
*/
