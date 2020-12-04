//
//  JournalDateView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 4/12/20.
//

import SwiftUI

struct JournalDateView: View {

    let weekDay: WeekDay

    @ViewBuilder
    var body: some View {
        VStack {
            Spacer()

            Text(weekDay.month)
                .foregroundColor(weekDay.isToday ? .white : Color.black.opacity(0.5))
                .font(.footnote)
                .fontWeight(weekDay.isToday ? .bold : .regular )

            Spacer()
                .frame(height: 5)

            Text(weekDay.number)
                .font(weekDay.isToday ? .title : .title2)
                .fontWeight(weekDay.isToday ? .bold : .regular )
                .foregroundColor(weekDay.isToday ? .white : Color.black.opacity(0.5))
            
            Spacer()
        }
        .cornerRadius(.defaultRadius)
    }
}
/*
struct JournalDateView_Previews: PreviewProvider {
    static var previews: some View {
        JournalDateView()
    }
}
*/
