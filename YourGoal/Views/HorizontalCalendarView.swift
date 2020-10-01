//
//  HorizontalCalendarView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI

struct WeekDay: Identifiable {
    var id: Int64

    var number: String
    var name: String
}

struct DayCell: View {
    let weekDay: WeekDay

    var body: some View {
        VStack {
            Text(weekDay.name)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
                .foregroundColor(.black)

            Text(weekDay.number)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
                .foregroundColor(.black)
        }
    }
}

struct HorizontalCalendarView: View {

    var days: [WeekDay] {
        let startOfWeek = Date().startOfWeek ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "d"

        return [
            WeekDay(id: 0, number: formatter.string(from: startOfWeek), name: "Lu"),
            WeekDay(id: 1, number: formatter.string(from: startOfWeek.adding(days: 1)), name: "Ma"),
            WeekDay(id: 2, number: formatter.string(from: startOfWeek.adding(days: 2)), name: "Me"),
            WeekDay(id: 3, number: formatter.string(from: startOfWeek.adding(days: 3)), name: "Gi"),
            WeekDay(id: 4, number: formatter.string(from: startOfWeek.adding(days: 4)), name: "Ve"),
            WeekDay(id: 5, number: formatter.string(from: startOfWeek.adding(days: 5)), name: "Sa"),
            WeekDay(id: 6, number: formatter.string(from: startOfWeek.adding(days: 6)), name: "Do")
        ]
    }

    var body: some View {
        HStack(content: {
            ForEach(days) {
                DayCell(weekDay: $0)
                    .background(Color.green)
                    .cornerRadius(5)
                    .padding(5)
                    .border(Color.black, width: 0)
            }}).frame(width: .infinity, height: 100, alignment: .center)
    }

}

struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView().previewLayout(.fixed(width: 375, height: 100))
    }
}
