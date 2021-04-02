//
//  ProfileView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class ProfileViewModel: ObservableObject {

    @Published var profile: Profile
    @Published var challenges: [Challenge]
    @Published var isProfileImagesVisible = false

    @Binding var refreshchallenges: Bool

    init(profile: Profile, challenges: [Challenge], refreshchallenges: Binding<Bool>) {
        self.profile = profile
        self.challenges = challenges
        self._refreshchallenges = refreshchallenges
    }

}

struct ProfileView: View {

    @ObservedObject var viewModel: ProfileViewModel

    @ViewBuilder
    var body: some View {
        let nameBinding = Binding<String>(get: {
            (viewModel.profile.name ?? "profile_name".localized())
        }, set: {
            if $0 != "profile_name".localized(), !(viewModel.challenges.contains(where: { $0.id == 6 })) {
                FirebaseService.logEvent(.nameUpdated)
                let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
                challenge.id = 6
                challenge.progressMade = 1
                viewModel.refreshchallenges = true
            }
            viewModel.profile.name = $0
            PersistenceController.shared.saveContext()
        })

        BackgroundView(color: .defaultBackground) {
            ZStack {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        Spacer()
                            .frame(height: DeviceFix.isRoundedScreen ? 50 : 20)

                        HStack {
                            Text("profile_title")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.navigationLargeTitle)

                            Spacer()
                        }

                        Spacer()
                            .frame(height: 20)

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

                        TextField("profile_name", text: nameBinding)
                            .frame(width: 200)
                            .multilineTextAlignment(.center)
                            .foregroundColor(nameBinding.wrappedValue == "profile_name".localized() ? .grayGradient2 : .grayText)
                            .background(Color.defaultBackground)
                            .cornerRadius(.defaultRadius)
                            .disableAutocorrection(true)
                            .padding([.bottom], -15)
                            .applyFont(.title)

                        Divider()
                            .frame(width: 200)

                        Spacer()
                            .frame(height: 40)

                        challengesView
                            .padding([.leading, .trailing], 15)
                    }
                }

                if viewModel.isProfileImagesVisible {
                    ProfileImageSelectorView(viewModel: .init(profile: viewModel.profile,
                                                              refreshchallenges: $viewModel.refreshchallenges),
                                             isPresented: $viewModel.isProfileImagesVisible)
                }
            }
        }.onAppear {
            FirebaseService.logPageViewed(pageName: "Profile", className: "ProfileView")
        }
    }

    var challengesView: some View {
        VStack(spacing: 30) {
            ForEach(0..<ProfileChallenge.allValues.count/2) { row in
                HStack(spacing: 15) {
                    ForEach(0..<2) { column in
                        let index = getIndexFor(row: row, column: column)
                        let challenge = ProfileChallenge.allValues[index]
                        ChallengeView(viewModel: .init(challenges: viewModel.challenges,
                                                       challenge: challenge))
                            .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                        .stroke(Color.grayBorder, lineWidth: 1))
                            .background(Color.defaultBackground
                                            .cornerRadius(.defaultRadius)
                                            .shadow(color: Color.blackShadow, radius: 5, x: 5, y: 5)
                            )
                    }
                }
            }
            
            Spacer()
        }
    }

    func getIndexFor(row: Int, column: Int) -> Int {
        /*
            0  1
          0 0  1
          1 2  3
          2 4  5
          3 6  7
          4 8  9
          5 10 11
          6 12 13
        */
        row + row + column
    }

}
/*
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
*/
