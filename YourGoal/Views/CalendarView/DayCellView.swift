//
//  DayCellView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

struct DayCellView: View {

    let weekDay: WeekDay

    @ViewBuilder
    var body: some View {
        VStack {
            if !DeviceFix.isSmallScreen {
                Text(weekDay.name)
                    .foregroundColor(Color.black.opacity(0.5))
            }

            if weekDay.isToday && weekDay.isValidGoal {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(weekDay.goalColor)
                    Text(DeviceFix.isSmallScreen ? weekDay.name : weekDay.number)
                        .fontWeight(weekDay.isWorkingDay ? .bold : .regular )
                        .padding([.bottom, .top], 5)
                        .foregroundColor(weekDay.isWorkingDay ? weekDay.goalColor : .black)
                }
            } else {
                Text(DeviceFix.isSmallScreen ? weekDay.name : weekDay.number)
                    .fontWeight(weekDay.isWorkingDay ? .bold : .regular )
                    .padding([.top, .bottom], 5)
                    .foregroundColor(weekDay.isWorkingDay ? weekDay.goalColor : .black)
            }
        }
    }
}

struct DayCellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(weekDay: .init(id: 0, date: Date(), isToday: true, isWorkingDay: true, goalColor: "greenGoal"))
            .previewLayout(.fixed(width: 50, height: 85))
        DayCellView(weekDay: .init(id: 0, date: Date(), isToday: true, isWorkingDay: false, goalColor: "orangeGoal"))
            .previewLayout(.fixed(width: 50, height: 85))
    }
}
