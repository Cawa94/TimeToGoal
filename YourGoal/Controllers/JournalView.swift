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
    @Published var selectedDay = Date() {
        didSet {
            if let page = goal.journal?.filter({ ($0 as? JournalPage)?.dayId == selectedDay.customId }).first as? JournalPage {
                self.notes = page.notes ?? placeholderString
                self.mood = page.mood
            } else {
                self.notes = placeholderString
                self.mood = nil
            }
        }
    }
    @Published var notes: String = "Com'è andata oggi?"
    @Published var mood: String?

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
                        JournalDatesView(viewModel: JournalDatesViewModel(goal: viewModel.goal,
                                                                          selectedDay: $viewModel.selectedDay))
                            .padding([.leading, .trailing, .top, .bottom], 15)

                        TextEditor(text: $viewModel.notes)
                            .padding([.leading, .trailing], 30)
                            .font(.title2)
                            .frame(height: 330)
                            .cornerRadius(.defaultRadius)
                            .disableAutocorrection(true)
                            .foregroundColor(viewModel.notes == viewModel.placeholderString ? .grayGradient2 : .black)
                                .onTapGesture {
                                    if viewModel.notes == viewModel.placeholderString {
                                        viewModel.notes = ""
                                    } else if viewModel.notes == "" {
                                        viewModel.notes = viewModel.placeholderString
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
        .onAppear(perform: {
            viewModel.selectedDay = Date()
        })
    }

    var saveAndCloseButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if let page = viewModel.goal.journal?.filter({ ($0 as? JournalPage)?.dayId == viewModel.selectedDay.customId })
                        .first as? JournalPage { // delete old page
                        PersistenceController.shared.container.viewContext.delete(page)
                        PersistenceController.shared.saveContext()
                    }
                    if (viewModel.notes != "" && viewModel.notes != viewModel.placeholderString) || viewModel.mood != nil {
                        let newPage = JournalPage(context: PersistenceController.shared.container.viewContext)
                        newPage.dayId = viewModel.selectedDay.customId
                        newPage.notes = viewModel.notes
                        newPage.mood = viewModel.mood
                        viewModel.goal.addToJournal(newPage)
                        PersistenceController.shared.saveContext()
                    }
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

    @ViewBuilder
    var emojiStackView: some View {
        HStack(spacing: 15) {
            ForEach(JournalMood.allValues, id: \.self) { mood in
                Button(action: {
                    viewModel.mood = mood.rawValue
                }) {
                    Text(mood.emoji)
                        .font(.system(size: viewModel.mood == mood.rawValue ? 65 : 40))
                }
            }
        }.frame(height: 65, alignment: .center)
    }

}
/*
struct JournalView_Previews: PreviewProvider {
    static var previews: some View {
        JournalView()
    }
}
*/
