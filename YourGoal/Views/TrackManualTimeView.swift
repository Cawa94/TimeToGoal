//
//  TrackManualTimeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/10/2020.
//

import SwiftUI

struct TrackManualTimeView: View {

    @State var hoursSpent: Double = 0
    @State var minutesSpent: Double = 00

    @State var hours: [Int] = Array(0...23)
    @State var minutes: [Int] = [00, 15, 30, 45]

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Spacer()

                    Picker(selection: self.$hoursSpent, label: Text("Numbers")) {
                        ForEach(self.hours, id: \.self) { integer in
                            Text("\(integer)")
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 3.5)
                    .clipped()

                    Text("Ore")

                    Picker(selection: self.$minutesSpent, label: Text("Numbers")) {
                        ForEach(self.minutes, id: \.self) { integer in
                            Text("\(integer)")
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 3.5)
                    .clipped()

                    Text("Minuti")

                    Spacer()
                }
            }
            Spacer()
            Button(action: {
                // TODO
            }) {
                HStack {
                    Text("Aggiungi").bold().foregroundColor(.goalColor)
                }
                .padding([.leading, .trailing], 60)
                .padding([.top, .bottom], 15)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                )
            }.accentColor(.goalColor)
            Spacer()
                .frame(height: 20)
        }
    }
}

struct TrackManualTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TrackManualTimeView()
            .previewLayout(.fixed(width: 375, height: 250))
    }
}
