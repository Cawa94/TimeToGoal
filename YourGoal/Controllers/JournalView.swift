//
//  JournalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 4/12/20.
//

import SwiftUI
import Combine

public class JournalViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var pageContentBinding: String = "Com'è andata oggi?"
    @Published var feelingSelected: String?

    let placeholderString = "Com'è andata oggi?"

    @Binding var isPresented: Bool

    init(goal: Goal, isPresented: Binding<Bool>) {
        self.goal = goal
        self._isPresented = isPresented
    }

}

struct JournalView: View {
    
    @ObservedObject var viewModel: JournalViewModel

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .pageBackground) {
            NavigationView {
                ScrollView() {
                    VStack {
                        JournalDatesView(viewModel: JournalDatesViewModel(goal: viewModel.goal))
                            .padding([.leading, .trailing, .top, .bottom], 15)

                        TextEditor(text: $viewModel.pageContentBinding)
                            .padding([.leading, .trailing], 30)
                            .font(.title2)
                            .frame(height: 330)
                            .cornerRadius(.defaultRadius)
                            .disableAutocorrection(true)
                            .foregroundColor(viewModel.pageContentBinding == viewModel.placeholderString ? .grayGradient2 : .black)
                                .onTapGesture {
                                    if viewModel.pageContentBinding == viewModel.placeholderString {
                                        viewModel.pageContentBinding = ""
                                    } else if viewModel.pageContentBinding == "" {
                                        viewModel.pageContentBinding = viewModel.placeholderString
                                    }
                                }

                        Spacer()

                        Text("Come ti senti?")
                            .font(.caption)
                            .foregroundColor(.grayGradient2)
                            .padding([.bottom], 2.5)

                        emojiStackView
                            .padding([.leading, .trailing], 15)

                        saveAndCloseButton
                            .padding([.leading, .trailing, .top, .bottom], 15)
                    }
                }.navigationBarTitle("Diario", displayMode: .large)
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    var saveAndCloseButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    viewModel.isPresented.toggle()
                }
            }) {
                HStack {
                    Spacer()
                    Text("Salva & chiudi".localized())
                        .bold()
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .background(LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(viewModel.goal.goalColor)
        }
    }

    var emojiStackView: some View {
        HStack(spacing: 15) {
            Button(action: {
                viewModel.feelingSelected = "🤩"
            }) {
                Text("🤩")
                    .font(.system(size: viewModel.feelingSelected == "🤩" ? 60 : 40))
            }
            Button(action: {
                viewModel.feelingSelected = "☺️"
            }) {
                Text("☺️")
                    .font(.system(size: viewModel.feelingSelected == "☺️" ? 60 : 40))
            }
            Button(action: {
                viewModel.feelingSelected = "😐"
            }) {
                Text("😐")
                    .font(.system(size: viewModel.feelingSelected == "😐" ? 60 : 40))
            }
            Button(action: {
                viewModel.feelingSelected = "☹️"
            }) {
                Text("☹️")
                    .font(.system(size: viewModel.feelingSelected == "☹️" ? 60 : 40))
            }
            Button(action: {
                viewModel.feelingSelected = "😫"
            }) {
                Text("😫")
                    .font(.system(size: viewModel.feelingSelected == "😫" ? 60 : 40))
            }
        }.frame(height: 60, alignment: .center)
    }

}
/*
struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
*/
