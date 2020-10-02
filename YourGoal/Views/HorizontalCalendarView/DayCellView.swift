//
//  DayCellView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

struct WeekDay: Identifiable {
    var id: Int64
    var number: String
    var name: String
    var isToday: Bool
    var isWorkingDay: Bool

    init(id: Int64, number: String, name: String, isToday: Bool, isWorkingDay: Bool?) {
        self.id = id
        self.number = number
        self.name = name
        self.isToday = isToday
        self.isWorkingDay = isWorkingDay ?? false
    }

}

struct DayCellView: View {
    let weekDay: WeekDay

    @ViewBuilder
    var body: some View {
        VStack {
            if weekDay.isWorkingDay {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                    Text(weekDay.name)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding([.bottom, .top], 6)
                }
            } else {
                Text(weekDay.name)
                    .fontWeight(.semibold)
                    .padding([.bottom, .top], 6)
                    .foregroundColor(.black)
            }

            if weekDay.isToday {
                ZStack {
                    Circle()
                        .fill(Color.goalColor)
                    Text(weekDay.number)
                        .fontWeight(.semibold)
                        .padding([.bottom, .top], 6)
                        .foregroundColor(.black)
                }
            } else {
                Text(weekDay.number)
                    .fontWeight(.semibold)
                    .padding([.top, .bottom], 6)
                    .foregroundColor(.black)
            }
        }
    }
}

struct DayCellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(weekDay: .init(id: 0, number: "10", name: "Me", isToday: true, isWorkingDay: true))
            .previewLayout(.fixed(width: 50, height: 85))
        DayCellView(weekDay: .init(id: 0, number: "10", name: "Me", isToday: true, isWorkingDay: false))
            .previewLayout(.fixed(width: 50, height: 85))
    }
}
