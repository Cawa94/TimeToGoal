//
//  TrackManualTimeView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/10/2020.
//

import SwiftUI

struct TrackManualTimeView: View {

    @Binding var isPresented: Bool

    @State var currentGoal: Goal?
    @State var timeSpent: Int = 0
    @State var decimalSpent: Double = 00

    var timeOptions: [Int] {
        switch currentGoal?.goalType.timeTrackingType {
        case .infinite, .double:
            return Array(0...100)
        default:
            return Array(0...23)
        }
    }

    var decimalOptions: [Double] {
        switch currentGoal?.goalType.timeTrackingType {
        case .hoursWithMinutes:
            return [00, 15, 30, 45]
        case .double:
            var hoursArray: [Double] = []
            for hour in 0...99 {
                hoursArray.append(Double(hour))
            }
            return hoursArray
        default:
            return []
        }
    }

    @State private var feedback = UINotificationFeedbackGenerator()

    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack {
                    Spacer()

                    Picker(selection: self.$timeSpent, label: Text("")) {
                        ForEach(self.timeOptions, id: \.self) { double in
                            Text("\(double)")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .applyFont(.title)
                        }
                    }
                    .frame(maxWidth: geometry.size.width / 3.5)
                    .clipped()

                    if currentGoal?.goalType.timeTrackingType == .hoursWithMinutes || currentGoal?.goalType.timeTrackingType == .double {
                        if currentGoal?.goalType.timeTrackingType == .hoursWithMinutes {
                            Text("global_hours")
                                .fontWeight(.semibold)
                                .applyFont(.title2)
                        } else {
                            Text(".")
                                .fontWeight(.semibold)
                                .applyFont(.title2)
                        }

                        Picker(selection: self.$decimalSpent, label: Text("")) {
                            ForEach(self.decimalOptions, id: \.self) { double in
                                Text(double.stringWithoutDecimals)
                                    .foregroundColor(.black)
                                    .fontWeight(.semibold)
                                    .applyFont(.title)
                            }
                        }
                        .frame(maxWidth: geometry.size.width / 3.5)
                        .clipped()

                        if currentGoal?.goalType.timeTrackingType == .hoursWithMinutes {
                            Text("global_minutes")
                                .fontWeight(.semibold)
                                .applyFont(.title2)
                        }
                    }
                    if currentGoal?.goalType.timeTrackingType != .hoursWithMinutes && currentGoal?.goalType != .custom {
                        Text("\(currentGoal?.goalType.measureUnit.localized() ?? "")".capitalized)
                            .fontWeight(.semibold)
                            .applyFont(.title2)
                    } else if currentGoal?.goalType == .custom {
                        Text("\(currentGoal?.customTimeMeasure ?? "")".capitalized)
                            .fontWeight(.semibold)
                            .applyFont(.title2)
                    }

                    Spacer()
                }
            }

            Spacer()

            Button(action: {
                withAnimation {
                    currentGoal?.timesHasBeenTracked += 1
                    let timeTracked = Double(timeSpent) + (Double("0.\(decimalSpent.stringWithoutDecimals)") ?? 0.00)
                    FirebaseService.logEvent(.timeTracked)
                    currentGoal?.timeCompleted += timeTracked
                    let progress = createGoalProgress(time: timeTracked)
                    currentGoal?.addToProgress(progress)
                    currentGoal?.editedAt = Date()
                    if currentGoal?.isCompleted ?? false {
                        currentGoal?.completedAt = Date()
                        FirebaseService.logConversion(.goalCompleted, goal: currentGoal)
                    }
                    PersistenceController.shared.saveContext()
                    self.feedback.notificationOccurred(.success)
                    self.isPresented = false
                }
            }) {
                HStack {
                    Spacer()
                    Text("global_add")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding([.top], 15)
                        .padding([.bottom], 15)
                        .applyFont(.button)
                    Spacer()
                }
                .background(LinearGradient(gradient: Gradient(colors: currentGoal?.rectGradientColors ?? Color.rainbow),
                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(.defaultRadius)
                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
            }
            .accentColor(currentGoal?.goalColor)
            .padding([.leading, .trailing], 30)
            .padding([.bottom], 10)

            Spacer()
                .frame(height: 15)
        }.foregroundColor(.black)
        .buttonStyle(PlainButtonStyle())
    }

    func createGoalProgress(time: Double) -> Progress {
        let progress = Progress(context: PersistenceController.shared.container.viewContext)
        progress.date = Date()
        progress.hoursOfWork = time
        progress.dayId = Date().customId
        return progress
    }

}
/*
struct TrackManualTimeView_Previews: PreviewProvider {
    static var previews: some View {
        TrackManualTimeView(isPresented: .constant(true), currentGoal: .constant(Goal()))
            .previewLayout(.fixed(width: 375, height: 250))
    }
}
*/
