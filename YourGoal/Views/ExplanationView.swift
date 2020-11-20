//
//  ExplanationView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 20/11/20.
//

import SwiftUI

public class ExplanationViewModel: ObservableObject {

    @Published var text: String
    @Published var image: Image
    @Published var showArrow: Bool

    init(text: String, image: String, showArrow: Bool = true) {
        self.text = text
        self.image = Image(image)
        self.showArrow = showArrow
    }

}

struct ExplanationView: View {

    @ObservedObject var viewModel: ExplanationViewModel
    @Binding var activeSheet: ActiveSheet?

    @ViewBuilder
    var body: some View {
        GeometryReader { container in
            VStack {
                Spacer()
                    .frame(height: 40)

                Text(viewModel.text)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding([.leading, .trailing], 25)

                Spacer()
                    .frame(height: 50)

                viewModel.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: container.size.width - 30)

                Spacer()

                if !viewModel.showArrow {
                    /*HStack {
                        Spacer()
                        Image("arrow_right")
                            .resizable()
                            .aspectRatio(1.0, contentMode: .fit)
                            .frame(height: 40)
                        Spacer()
                            .frame(width: 30)
                    }
                } else {*/
                    Button(action: {
                        self.activeSheet = nil
                    }) {
                        HStack {
                            Spacer()
                            Text("OK HO CAPITO")
                                .bold()
                                .foregroundColor(.white)
                                .font(.title2)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding([.top, .bottom], 15)
                        .background(LinearGradient(gradient: Gradient(colors: [.orangeGoal, .orangeGradient1, .orangeGradient2]),
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(.defaultRadius)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                    }.padding([.leading, .trailing], 30)
                }

                Spacer()
                    .frame(height: 75)
            }.frame(width: container.size.width, height: container.size.height)
        }
    }

}
/*
struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        ExplanationView()
    }
}
*/
