//
//  StatisticsView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

public class StatisticsViewModel: ObservableObject {

    @Published var goals: [Goal]

    init(goals: [Goal]) {
        self.goals = goals
    }

}

struct StatisticsView: View {

    @ObservedObject var viewModel: StatisticsViewModel
    @Environment(\.calendar) var calendar

    private var year: DateInterval {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let startDate = viewModel.goals.sorted(by: { ($0.createdAt ?? Date()) < ($1.createdAt ?? Date()) })
            .first?.createdAt ?? formatter.date(from: "2021/01/01 23:00") ?? Date()
        let endDate = viewModel.goals.sorted(by: { ($0.updatedCompletionDate) < ($1.updatedCompletionDate) })
            .last?.updatedCompletionDate ?? Date()
        return DateInterval(start: startDate, end: endDate)
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        Spacer()
                            .frame(height: DeviceFix.isRoundedScreen ? 50 : 20)

                        HStack {
                            Text("Progressi")
                                .foregroundColor(.grayText)
                                .multilineTextAlignment(.leading)
                                .padding([.leading], 15)
                                .applyFont(.navigationLargeTitle)

                            Spacer()
                        }

                        CalendarView(interval: year, monthWidth: container.size.width) { date in
                            CalendarDayView(goals: viewModel.goals, date: date)
                        }

                        Spacer()
                            .frame(height: 20)

                        HStack(spacing: 20) {
                            VStack {
                                Text("Striscia attuale")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.title2)

                                Text("7")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.navigationLargeTitle)
                            }.padding(.leading, 10)
                            
                            VStack {
                                Text("Record giorni consecutivi")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.title2)

                                Text("22")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.navigationLargeTitle)
                            }.padding(.trailing, 10)
                        }
                    }
                }
            }
        }
    }

}

/*
struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
*/
