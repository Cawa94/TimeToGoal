//
//  JournalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 4/12/20.
//

import SwiftUI
import Combine

public class JournalViewModel: ObservableObject {

    @Published var journal: [JournalPage]
    @Published var selectedDay = Date() {
        didSet {
            if let page = journal.filter({ $0.dayId == selectedDay.customId }).first {
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

    init(journal: [JournalPage]) {
        self.journal = journal
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
        BackgroundView(color: .defaultBackground) {
            NavigationView {
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
        BackgroundView(color: .defaultBackground) {
            ScrollView() {
                VStack {
                    JournalDatesView(viewModel: JournalDatesViewModel(journal: viewModel.journal,
                                                                      selectedDay: $viewModel.selectedDay))
                        .padding([.leading, .trailing, .top, .bottom], 15)

                    TextEditor(text: $viewModel.notes)
                        .background(Color.defaultBackground)
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

                    saveAndCloseButton
                        .padding([.leading, .trailing, .top, .bottom], 15)
                }
            }
        }.navigationBarTitle("global_journal", displayMode: .large)
    }

    var editorHeight: CGFloat {
        if DeviceFix.isSmallScreen {
            return 180
        } else if DeviceFix.is65Screen {
            return 380
        } else if DeviceFix.isRoundedScreen {
            return 310
        } else {
            return 260
        }
    }

    var saveAndCloseButton: some View {
        HStack {
            Button(action: {
                withAnimation {
                    if let page = viewModel.journal.filter({ $0.dayId == viewModel.selectedDay.customId })
                        .first as? JournalPage { // delete old page
                        PersistenceController.shared.container.viewContext.delete(page)
                        PersistenceController.shared.saveContext()
                    }
                    if (viewModel.notes != "" && viewModel.notes != viewModel.placeholderString) || viewModel.mood != nil {
                        let newPage = JournalPage(context: PersistenceController.shared.container.viewContext)
                        newPage.dayId = viewModel.selectedDay.customId
                        newPage.notes = viewModel.notes
                        newPage.mood = viewModel.mood
                        PersistenceController.shared.saveContext()
                    }
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
                .background(LinearGradient(gradient: Gradient(colors: Color.rainbow),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }.accentColor(Color.goalColor)
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
