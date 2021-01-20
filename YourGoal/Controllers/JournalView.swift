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
    @Published var notes: String = "journal_notes_question".localized()
    @Published var mood: String?

    let placeholderString = "journal_notes_question".localized()

    @Binding var isPresented: Bool

    init(goal: Goal, isPresented: Binding<Bool>) {
        self.goal = goal
        self._isPresented = isPresented
    }

}

struct JournalView: View {

    @ObservedObject var viewModel: JournalViewModel

    init(viewModel: JournalViewModel) {
        self.viewModel = viewModel

        UITextView.appearance().backgroundColor = .clear
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .pageLightBackground) {
            if !viewModel.goal.isArchived {
                NavigationView {
                    scrollViewContent
                }
            } else {
                scrollViewContent
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onAppear(perform: {
            viewModel.selectedDay = Date()
        })
    }

    var scrollViewContent: some View {
        BackgroundView(color: .pageLightBackground) {
        ScrollView() {
                VStack {
                    JournalDatesView(viewModel: JournalDatesViewModel(goal: viewModel.goal,
                                                                      selectedDay: $viewModel.selectedDay))
                        .padding([.leading, .trailing, .top, .bottom], 15)

                    TextEditor(text: $viewModel.notes)
                        .background(Color.pageLightBackground)
                        .padding([.leading, .trailing], 30)
                        .frame(height: editorHeight)
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
                        .applyFont(.journal)

                    Spacer()

                    Text("journal_mood_question")
                        .applyFont(.small)
                        .foregroundColor(.grayGradient2)
                        .padding([.bottom], 2.5)

                    emojiStackView
                        .padding([.leading, .trailing], 15)

                    if !viewModel.goal.isArchived {
                        saveAndCloseButton
                            .padding([.leading, .trailing, .top, .bottom], 15)
                    }
                }
            }
        }.navigationBarTitle("global_journal", displayMode: viewModel.goal.isArchived ? .inline : .large)
    }

    var editorHeight: CGFloat {
        if DeviceFix.isSmallScreen {
            return viewModel.goal.isArchived ? 330 : 180
        } else if DeviceFix.is65Screen {
            return viewModel.goal.isArchived ? 500 : 380
        } else if DeviceFix.isRoundedScreen {
            return viewModel.goal.isArchived ? 440 : 310
        } else {
            return viewModel.goal.isArchived ? 390 : 260
        }
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
                    Text("journal_save_close")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .applyFont(.button)
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
                    Image(mood.emoji)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(height: viewModel.mood == mood.rawValue ? 65 : 40)
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
