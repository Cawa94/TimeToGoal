//
//  ProfileView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class ProfileViewModel: ObservableObject {}

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            VStack {
                Spacer()
                    .frame(height: DeviceFix.isRoundedScreen ? 60 : 20)

                HStack {
                    Text("Profilo")
                        .foregroundColor(.grayText)
                        .multilineTextAlignment(.leading)
                        .padding([.leading], 15)
                        .applyFont(.navigationLargeTitle)

                    Spacer()
                }

                ZStack {
                    Circle()
                        .foregroundColor(.defaultBackground)
                        .frame(width: 150, height: 150)
                        .shadow(radius: 2)
                    Image("man_0")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 110, height: 110)
                }

                Spacer()
            }
        }
    }

}
/*
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
*/
