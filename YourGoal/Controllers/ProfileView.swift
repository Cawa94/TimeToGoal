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
        let nameBinding = Binding<String>(get: {
            (viewModel.profile.name ?? "Nome")
        }, set: {
            viewModel.profile.name = $0
            PersistenceController.shared.saveContext()
        })

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

                    Spacer()
                        .frame(height: 10)

                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer()
                            .frame(height: 10)

                        ZStack {
                            Circle()
                                .foregroundColor(.defaultBackground)
                                .frame(width: 250, height: 150)
                                .shadow(radius: 2)
                            Image(viewModel.profile.image ?? "man_0")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 110, height: 110)
                        }.onTapGesture {
                            viewModel.isProfileImagesVisible = true
                        }

                        Spacer()
                            .frame(height: 20)

                        TextField("Nome", text: nameBinding)
                            .frame(width: 200)
                            .multilineTextAlignment(.center)
                            .foregroundColor(nameBinding.wrappedValue == "Nome" ? .grayGradient2 : .grayText)
                            .background(Color.defaultBackground)
                            .cornerRadius(.defaultRadius)
                            .disableAutocorrection(true)
                            .applyFont(.body)
                        Divider()
                            .frame(width: 200)

                        Spacer()
                            .frame(height: 20)
                        
                        challengesView
                            .padding([.leading, .trailing], 15)
                    }
                }

                if viewModel.isProfileImagesVisible {
                    ProfileImageSelectorView(viewModel: .init(profile: viewModel.profile),
                                             isPresented: $viewModel.isProfileImagesVisible)
                }
            }
        }
    }

    var challengesView: some View {
        VStack() {
            ForEach(0..<8) { _ in
                HStack {
                    ForEach(0..<2) { _ in
                        Image("badge")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
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
