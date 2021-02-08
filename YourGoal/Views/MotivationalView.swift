//
//  MotivationalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/11/20.
//

import SwiftUI

public class MotivationalViewModel: ObservableObject {

    let quote: FamousQuote

    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>) {
        self.quote = FamousQuote.getOneRandom()
        self._isPresented = isPresented
    }

}

struct MotivationalView: View {

    @ObservedObject var viewModel: MotivationalViewModel

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.white.opacity(0.97)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        viewModel.isPresented = false
                    }
                }

            VStack {
                Spacer()

                Spacer()
                    .frame(height: 60)

                Text(viewModel.quote.sentence)
                    .italic()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 20)
                    .applyFont(.quote)

                Spacer()
                    .frame(height: 20)

                Text(viewModel.quote.author)
                    .italic()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 20)
                    .applyFont(.quoteAuthor)

                Spacer()
                Spacer()
            }
        }
    }
}
/*
struct MotivationalView_Previews: PreviewProvider {
    static var previews: some View {
        MotivationalView()
    }
}
*/
