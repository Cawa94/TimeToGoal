//
//  JournalDatesView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 4/12/20.
//

import SwiftUI

public class JournalDatesViewModel: ObservableObject {

    @Published var journal: [JournalPage]

    @Binding var selectedDay: Date

    var dates: [JournalDate] = []

    init(journal: [JournalPage], selectedDay: Binding<Date>) {
        self.journal = journal
        self._selectedDay = selectedDay
        
        var journalDates: [JournalDate] = []
        let dayDurationInSeconds: TimeInterval = 60*60*24
        let creationDate = (journal.sorted(by: { ($0.date ?? Date()).compare($1.date ?? Date()) == .orderedDescending }).first?.date ?? Date()).adding(days: -3) // to start 2 days early than first page
        let finalDate = Date().adding(days: 3)
        for date in stride(from: creationDate, to: finalDate, by: dayDurationInSeconds) {
            var emoji: String?
            if let page = journal.filter({ $0.dayId == date.customId }).first, let mood = page.mood {
                emoji = JournalMood(rawValue: mood)?.emoji
            }
            journalDates.append(JournalDate(id: date.customId,
                                            date: date,
                                            hasNotes: journal.contains(where: { $0.dayId == date.customId }) ,
                                            emoji: emoji))
        }
        self.dates = journalDates
    }

}

struct JournalDatesView: View {

    @ObservedObject var viewModel: JournalDatesViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                LazyHStack(spacing: 7.5) {
                    ForEach(viewModel.dates) { journalDate in
                        JournalDateView(journalDate: journalDate, isSelected: journalDate.id == viewModel.selectedDay.customId)
                            .frame(width: journalDate.id == viewModel.selectedDay.customId ? 75 : 60,
                                   height: journalDate.id == viewModel.selectedDay.customId ? 75 : 60)
                            .background(journalDate.id == viewModel.selectedDay.customId
                                            ? LinearGradient(gradient: Gradient(colors: Color.rainbow),
                                                             startPoint: .topLeading, endPoint: .bottomTrailing)
                                            : LinearGradient(gradient: .init(colors: [.white]),
                                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(.defaultRadius)
                            .onTapGesture {
                                withAnimation {
                                    if journalDate.date < viewModel.selectedDay {
                                        scrollView.scrollTo(journalDate.date.adding(days: -2).customId)
                                    } else {
                                        scrollView.scrollTo(journalDate.date.adding(days: 2).customId)
                                    }
                                }
                                self.viewModel.selectedDay = journalDate.date
                            }
                    }
                }
                .cornerRadius(.defaultRadius)
                .onAppear {
                    scrollView.scrollTo(viewModel.selectedDay.adding(days: -2).customId)
                }
            }
        }
        .frame(height: 75, alignment: .center)
        .cornerRadius(.defaultRadius)
        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
    }

}
/*
struct JournalDatesView_Previews: PreviewProvider {
    static var previews: some View {
        JournalDatesView()
    }
}
*/
