//
//  JournalDatesView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 4/12/20.
//

import SwiftUI

import SwiftUI

public class JournalDatesViewModel: ObservableObject {

    @Published var goal: Goal

    @Binding var selectedDay: Date

    var dates: [JournalDate] = []

    init(goal: Goal, selectedDay: Binding<Date>) {
        self.goal = goal
        self._selectedDay = selectedDay
        
        var journalDates: [JournalDate] = []
        let dayDurationInSeconds: TimeInterval = 60*60*24
        let creationDate = (goal.createdAt ?? Date()).adding(days: -5) // to start 2 days early than creation
        let finalDate = goal.isArchived ? goal.completedAt ?? Date().adding(days: 5) : Date().adding(days: 5)
        for date in stride(from: creationDate, to: finalDate, by: dayDurationInSeconds) {
            journalDates.append(JournalDate(id: date.customId, date: date, goal: goal))
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
                                            ? LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
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
