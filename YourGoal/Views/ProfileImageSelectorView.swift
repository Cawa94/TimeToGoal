//
//  ProfileImageSelectorView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/1/21.
//

import SwiftUI

public class ProfileImageSelectorViewModel: ObservableObject {

    @State var profile: Profile

    init(profile: Profile) {
        self.profile = profile
    }

    var images: [String] {
        return ["man_0", "woman_0",
                "man_1", "woman_1",
                "man_2", "woman_2",
                "man_3", "woman_3",
                "man_4", "woman_4"]
    }

}

struct ProfileImageSelectorView: View {

    @ObservedObject var viewModel: ProfileImageSelectorViewModel
    @Binding var isPresented: Bool

    init(viewModel: ProfileImageSelectorViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._isPresented = isPresented

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.toggle()
                }
            GeometryReader { container in
                VStack() {
                    Spacer().frame(maxWidth: .infinity)
                    HStack {
                        Spacer().frame(maxWidth: .infinity)
                        ZStack {
                            RoundedRectangle(cornerRadius: .defaultRadius)
                                .fill(Color.white)
                                .cornerRadius(50)

                            VStack {
                                Spacer()
                                    .frame(height: 20)

                                ForEach(0..<viewModel.images.count/3) { row in
                                    HStack(spacing: 25) {
                                        ForEach(0..<3) { column in
                                            let index = getIndexFor(row: row, column: column)
                                            let image = viewModel.images[index]
                                            Button(action: {
                                                viewModel.profile.image = image
                                                PersistenceController.shared.saveContext()
                                                isPresented.toggle()
                                            }) {
                                                if viewModel.profile.image == image {
                                                    Image(image)
                                                        .resizable()
                                                        .aspectRatio(1.0, contentMode: .fit)
                                                        .frame(width: 45)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: .defaultRadius)
                                                                .stroke(Color.goalColor, lineWidth: 2)
                                                                .padding(-8)
                                                        )
                                                } else {
                                                    Image(image)
                                                        .resizable()
                                                        .aspectRatio(1.0, contentMode: .fit)
                                                        .frame(width: 45)
                                                }
                                            }
                                        }
                                    }.frame(height: 80)
                                    .buttonStyle(PlainButtonStyle())

                                }

                                Spacer()
                                    .frame(height: 20)
                            }

                        }.frame(width: container.size.width / 1.35, alignment: .center)
                        Spacer().frame(maxWidth: .infinity)
                    }
                    Spacer().frame(maxWidth: .infinity)
                }
            }
        }
    }

    func getIndexFor(row: Int, column: Int) -> Int {
        /*
            0  1  2
          0 1  2  3
          1 4  5  6
          2 7  8  9
          3 10 11 12
          4 13 14 15
          5 16 17 18
          6 19 20 21
        */
        row * 2 + row + column
    }

}

/*
struct ProfileImageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageSelectorView()
    }
}
*/
