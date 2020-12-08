//
//  JournalDateView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 4/12/20.
//

import SwiftUI

struct JournalDateView: View {

    let journalDate: JournalDate
    var isSelected : Bool

    @ViewBuilder
    var body: some View {
        VStack {
            Spacer()

            Text(journalDate.month)
                .foregroundColor(isSelected ? .white : Color.black.opacity(0.5))
                .font(.footnote)
                .fontWeight(isSelected ? .bold : .regular )

            Spacer()
                .frame(height: 5)

            if let emoji = journalDate.emoji {
                HStack {
                    Text(journalDate.number)
                        .font(isSelected ? .title : .title2)
                        .fontWeight(isSelected ? .bold : .regular )
                        .foregroundColor(isSelected ? .white : Color.black.opacity(0.5))
                    Text(emoji)
                }
            } else {
                Text(journalDate.number)
                    .font(isSelected ? .title : .title2)
                    .fontWeight(isSelected ? .bold : .regular )
                    .foregroundColor(isSelected ? .white : Color.black.opacity(0.5))
            }

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
