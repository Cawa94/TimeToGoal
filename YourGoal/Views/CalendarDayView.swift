//
//  CalendarDayView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 23/2/21.
//

import SwiftUI

struct CalendarDayView: View {

    @Environment(\.calendar) var calendar

    @State var goals: [Goal]
    @State var date: Date

    @ViewBuilder
    var body: some View {
        let goalsOnDate = goals.goalsWorkOn(date: date)
        let rowsCount = Int(Double(goalsOnDate.count/3).rounded(.up)) + 1

        VStack(spacing: 0) {
            Text("30")
                .applyFont(.title2)
                .hidden()
                .padding(8)
                .overlay(
                    ZStack {
                        if let goal = goals
                                   .first(where: { ($0.datesHasBeenCompleted?.contains(where: { $0.withoutHours == date.withoutHours }) ?? false) }) {
                            Circle()
                                .fill(goal.goalColor)

                            ZStack {
                                Text(String(self.calendar.component(.day, from: date)))
                                    .applyFont(.title2)
                                    .foregroundColor(.white)

                                if date.withoutHours == Date().withoutHours {
                                    Rectangle()
                                        .foregroundColor(.red)
                                        .frame(width: 25, height: 1)
                                        .padding(.top, 20)
                                }
                            }
                        } else if let goal = goals.first(where: { $0.updatedCompletionDate.withoutHours == date.withoutHours }) {
                            Circle()
                                .strokeBorder(goal.goalColor, lineWidth: 2)
                                .opacity(0.5)

                            ZStack {
                                Text(String(self.calendar.component(.day, from: date)))
                                    .applyFont(.title2)
                                    .foregroundColor(.grayText)
                                    .opacity(0.7)

                                if date.withoutHours == Date().withoutHours {
                                    Rectangle()
                                        .foregroundColor(.red)
                                        .frame(width: 25, height: 1)
                                        .padding(.top, 20)
                                }
                            }
                         } else {
                            ZStack {
                                Text(String(self.calendar.component(.day, from: date)))
                                    .applyFont(.title2)
                                    .foregroundColor(date <= Date() ? .grayText : .grayLight)
                                    .opacity(date <= Date() ? 1 : 0.4)

                                if date.withoutHours == Date().withoutHours {
                                    Rectangle()
                                        .foregroundColor(.red)
                                        .frame(width: 25, height: 1)
                                        .padding(.top, 20)
                                }
                            }
                        }
                    }
                )

            VStack(spacing: 2) {
                ForEach(0..<rowsCount) { row in
                    HStack(spacing: 2) {
                        ForEach(0..<3) { column in
                            let index = getIndexFor(row: row, column: column)
                            if index < goalsOnDate.count {
                                if goalsOnDate[index].dayPercentageAt(date: date) >= 1 {
                                    Circle()
                                        .fill(goalsOnDate[index].goalColor)
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(width: 10)
                                } else {
                                    Circle()
                                        .strokeBorder(goalsOnDate[index].goalColor, lineWidth: 1)
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(width: 10)
                                        .opacity(0.4)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func getIndexFor(row: Int, column: Int) -> Int {
        /*
            0  1  2
          0 1  2  3
          1 4  5  6
          2 7  8  9
          3 10 11 12
          4 13 14 15
          5 16 17 18
          6 19 20 21
        */
        row * 2 + row + column
    }

}
/*
struct CalendarDayView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDayView()
    }
}
*/
