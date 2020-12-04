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
    var dates: [WeekDay] = []
    var todayId: Int64

    init(goal: Goal) {
        self.goal = goal
        
        var journalDates: [WeekDay] = []
        let dayDurationInSeconds: TimeInterval = 60*60*24
        let creationDate = (goal.createdAt ?? Date()).adding(days: -5) // to start 2 days early than creation
        let finalDate = Date().adding(days: 5)
        for date in stride(from: creationDate, to: finalDate, by: dayDurationInSeconds) {
            journalDates.append(WeekDay(id: date.customId, date: date,
                                        isToday: date.withoutHours == Date().withoutHours,
                                        goal: goal))
        }
        self.dates = journalDates
        self.todayId = Date().adding(days: -2).customId
    }

}

struct JournalDatesView: View {

    @ObservedObject var viewModel: JournalDatesViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollView in
                LazyHStack(spacing: 7.5) {
                    ForEach(viewModel.dates) {
                        JournalDateView(weekDay: $0)
                            .frame(width: $0.isToday ? 75 : 60, height: $0.isToday ? 75 : 60)
                            .background($0.isToday
                                            ? LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                                             startPoint: .topLeading, endPoint: .bottomTrailing)
                                            : LinearGradient(gradient: .init(colors: [.white]),
                                                             startPoint: .topLeading, endPoint: .bottomTrailing))
                            .cornerRadius(.defaultRadius)
                    }
                }
                .cornerRadius(.defaultRadius)
                .onAppear {
                    scrollView.scrollTo(viewModel.todayId)
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
