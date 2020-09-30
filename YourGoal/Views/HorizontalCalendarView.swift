//
//  HorizontalCalendarView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI

struct WeekDay: Identifiable {
    var id: Int64

    var number: Int
    var name: String
}

struct DayCell: View {
    let weekDay: WeekDay

    var body: some View {
        VStack {
            Text(weekDay.name)
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)

            Text("\(weekDay.number)")
                .fontWeight(.semibold)
                .padding([.leading, .trailing, .bottom], 5)
        }
    }
}

struct HorizontalCalendarView: View {

    @State var days = [
        WeekDay(id: 0, number: 1, name: "Lu"),
        WeekDay(id: 1, number: 2, name: "Ma"),
        WeekDay(id: 2, number: 3, name: "Me"),
        WeekDay(id: 3, number: 4, name: "Gi"),
        WeekDay(id: 4, number: 5, name: "Ve"),
        WeekDay(id: 5, number: 6, name: "Sa"),
        WeekDay(id: 6, number: 7, name: "Do")]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 5, content: {
                Spacer()
                ForEach(days) {
                    DayCell(weekDay: $0)
                        .background(Color.green)
                        .cornerRadius(5)
                        .padding(5)
                        .border(Color.black, width: 0)
                }
                Spacer()
            })
        }
    }

}

struct HorizontalCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalCalendarView().previewLayout(.fixed(width: 375, height: 100))
    }
}
