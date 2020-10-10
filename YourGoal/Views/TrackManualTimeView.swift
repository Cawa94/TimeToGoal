//
//  TrackManualTimeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/10/2020.
//

import SwiftUI

struct TrackManualTimeView: View {

    @Binding var isPresented: Bool
    @Binding var currentGoal: Goal?

    @State var hoursSpent: Int = 0
    @State var minutesSpent: Double = 00

    @State var hours: [Int] = Array(0...23)
    @State var minutes: [Double] = [00, 15, 30, 45]

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Spacer()

                    Picker(selection: self.$hoursSpent, label: Text("")) {
                        ForEach(self.hours, id: \.self) { double in
                            Text("\(double)")
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 3.5)
                    .clipped()

                    Text("global_hours".localized())

                    Picker(selection: self.$minutesSpent, label: Text("")) {
                        ForEach(self.minutes, id: \.self) { double in
                            Text(double.stringWithoutDecimals)
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 3.5)
                    .clipped()

                    Text("global_minutes".localized())

                    Spacer()
                }
            }
            Spacer()
            Button(action: {
                currentGoal?.timeCompleted += Double(hoursSpent) + (Double("0.\(minutesSpent.stringWithoutDecimals)") ?? 0.00)
                PersistenceController.shared.saveContext()
                self.isPresented = false
            }) {
                HStack {
                    Text("global_add".localized()).bold().foregroundColor(.goalColor)
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
        TrackManualTimeView(isPresented: .constant(true), currentGoal: .constant(Goal()))
            .previewLayout(.fixed(width: 375, height: 250))
    }
}
