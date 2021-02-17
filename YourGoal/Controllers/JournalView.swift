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
    @Published var challenges: [Challenge]
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

    init(journal: [JournalPage], challenges: [Challenge]) {
        self.journal = journal
        self.challenges = challenges
    }

}

struct JournalView: View {

    @ObservedObject var viewModel: JournalViewModel

    init(viewModel: JournalViewModel) {
        self.viewModel = viewModel
        self.viewModel.selectedDay = Date()

        UITextView.appearance().backgroundColor = .clear
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            VStack {
                Spacer()
                    .frame(height: DeviceFix.isRoundedScreen ? 60 : 20)

                HStack {
                    Text("global_journal")
                        .foregroundColor(.grayText)
                        .multilineTextAlignment(.leading)
                        .padding([.leading], 15)
                        .applyFont(.navigationLargeTitle)

                    Spacer()
                }

                Spacer()
                    .frame(height: 15)

                scrollViewContent
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    @ViewBuilder
    var scrollViewContent: some View {
        let notesBinding = Binding<String>(get: {
            viewModel.notes
        }, set: {
            viewModel.notes = $0
            saveJournal()
        })

        BackgroundView(color: .defaultBackground) {
            JournalDatesView(viewModel: JournalDatesViewModel(journal: viewModel.journal,
                                                              selectedDay: $viewModel.selectedDay))
                .padding([.leading, .trailing, .bottom], 15)

            TextEditor(text: notesBinding)
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
                        UIApplication.shared.endEditing()
                    }
                .applyFont(.journal)

            Spacer()

            Text("journal_mood_question")
                .applyFont(.small)
                .foregroundColor(.grayGradient2)
                .padding([.bottom], 2.5)

            emojiStackView
                .padding([.leading, .trailing], 15)

            Spacer()
                .frame(height: 25)

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

    func saveJournal() {
        for page in viewModel.journal.filter({ $0.dayId == viewModel.selectedDay.customId }) { // delete pages of same day
            PersistenceController.shared.container.viewContext.delete(page)
        }
        if (viewModel.notes != "" && viewModel.notes != viewModel.placeholderString) || viewModel.mood != nil {
            let newPage = JournalPage(context: PersistenceController.shared.container.viewContext)
            newPage.dayId = viewModel.selectedDay.customId
            newPage.notes = viewModel.notes
            newPage.mood = viewModel.mood
            newPage.date = viewModel.selectedDay
            self.viewModel.journal.append(newPage)
        }

        var journal: [JournalPage] = []
        for page in viewModel.journal {
            if !(journal.contains(where: { $0.dayId == page.dayId })) {
                journal.append(page)
            }
        }
        let totalPagesCount = journal.count
        if let challenge = viewModel.challenges.first(where: { $0.id == 13 }) {
            challenge.progressMade = Double(totalPagesCount)
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 13
            challenge.progressMade = Double(totalPagesCount)
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 14 }) {
            challenge.progressMade = Double(totalPagesCount)
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 14
            challenge.progressMade = Double(totalPagesCount)
        }
        if let challenge = viewModel.challenges.first(where: { $0.id == 15 }) {
            challenge.progressMade = Double(totalPagesCount)
        } else {
            let challenge = Challenge(context: PersistenceController.shared.container.viewContext)
            challenge.id = 15
            challenge.progressMade = Double(totalPagesCount)
        }
        PersistenceController.shared.saveContext()
    }

    @ViewBuilder
    var emojiStackView: some View {
        HStack(spacing: 15) {
            ForEach(JournalMood.allValues, id: \.self) { mood in
                Button(action: {
                    viewModel.mood = mood.rawValue
                    saveJournal()
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
