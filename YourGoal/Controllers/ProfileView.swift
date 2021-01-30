//
//  ProfileView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class ProfileViewModel: ObservableObject {

    @Published var profile: Profile
    @Published var isProfileImagesVisible = false

    init(profile: Profile?) {
        if let profile = profile {
            self.profile = profile
        } else {
            let profile = Profile(context: PersistenceController.shared.container.viewContext)
            profile.created_at = Date()
            PersistenceController.shared.saveContext()
            self.profile = profile
        }
    }

}

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            ZStack {
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
                        Image(viewModel.profile.image ?? "man_0")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 110, height: 110)
                    }.onTapGesture {
                        viewModel.isProfileImagesVisible.toggle()
                    }

                    Spacer()
                }

                if viewModel.isProfileImagesVisible {
                    ProfileImageSelectorView(viewModel: .init(profile: viewModel.profile),
                                             isPresented: $viewModel.isProfileImagesVisible)
                }
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
