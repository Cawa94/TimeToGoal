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
        VStack(spacing: 0) {
            Spacer()

            Text(journalDate.month)
                .foregroundColor(isSelected ? .white : Color.black.opacity(0.5))
                .applyFont(isSelected ? .title2 : .small)

            if let emoji = journalDate.emoji {
                HStack {
                    Text(journalDate.number)
                        .fontWeight(isSelected ? .semibold : .regular )
                        .foregroundColor(isSelected ? .white : Color.black.opacity(0.5))
                        .applyFont(isSelected ? .title : .title2)

                    Image(emoji)
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 20)
                }
            } else {
                Text(journalDate.number)
                    .fontWeight(isSelected ? .semibold : .regular )
                    .foregroundColor(isSelected ? .white : Color.black.opacity(0.5))
                    .applyFont(isSelected ? .title : .title2)
            }

            Spacer()
        }
        .cornerRadius(.defaultRadius)
        .frame(height: 80)
    }
}
/*
struct JournalDateView_Previews: PreviewProvider {
    static var previews: some View {
        JournalDateView()
    }
}
*/
