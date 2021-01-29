//
//  StatisticsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class StatisticsViewModel: ObservableObject {}

struct StatisticsView: View {

    @ObservedObject var viewModel: StatisticsViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            VStack {
                Spacer()
                    .frame(height: DeviceFix.isRoundedScreen ? 60 : 20)

                HStack {
                    Text("Progressi")
                        .foregroundColor(.grayText)
                        .multilineTextAlignment(.leading)
                        .padding([.leading], 15)
                        .applyFont(.navigationLargeTitle)

                    Spacer()
                }

                Spacer()
            }
        }
    }

}

/*
struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
*/
