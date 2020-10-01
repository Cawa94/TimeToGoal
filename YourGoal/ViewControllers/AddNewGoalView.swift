//
//  AddNewGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

private extension Color {

    static let textForegroundColor: Color = .white
    static let textBackgroundColor: Color = .init(rgb: 0x006400)

}

struct AddNewGoalView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var isPresented: Bool

    @State var nameFieldValue: String = ""
    @State var timeRequiredFieldValue: String = ""

    @State var mondayHoursValue: String = "0"
    @State var tuesdayHoursValue: String = "0"
    @State var wednesdayHoursValue: String = "0"
    @State var thursdayHoursValue: String = "0"
    @State var fridayHoursValue: String = "0"
    @State var saturdayHoursValue: String = "0"
    @State var sundayHoursValue: String = "0"

    @State var completionDate: Date?

    var body: some View {
        let timeRequiredBinding = Binding<String>(get: {
            self.timeRequiredFieldValue
        }, set: {
            self.timeRequiredFieldValue = $0
            updateCompletionDate()
        })

        let mondayBinding = Binding<String>(get: {
            self.mondayHoursValue
        }, set: {
            self.mondayHoursValue = $0
            updateCompletionDate()
        })

        let tuesdayBinding = Binding<String>(get: {
            self.tuesdayHoursValue
        }, set: {
            self.tuesdayHoursValue = $0
            updateCompletionDate()
        })

        let wednesdayBinding = Binding<String>(get: {
            self.wednesdayHoursValue
        }, set: {
            self.wednesdayHoursValue = $0
            updateCompletionDate()
        })

        let thursdayBinding = Binding<String>(get: {
            self.thursdayHoursValue
        }, set: {
            self.thursdayHoursValue = $0
            updateCompletionDate()
        })

        let fridayBinding = Binding<String>(get: {
            self.fridayHoursValue
        }, set: {
            self.fridayHoursValue = $0
            updateCompletionDate()
        })

        let saturdayBinding = Binding<String>(get: {
            self.saturdayHoursValue
        }, set: {
            self.saturdayHoursValue = $0
            updateCompletionDate()
        })

        let sundayBinding = Binding<String>(get: {
            self.sundayHoursValue
        }, set: {
            self.sundayHoursValue = $0
            updateCompletionDate()
        })

        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                Form {
                    Section(header: Text("Nome dell'obiettivo")) {
                        ZStack {
                            Color.black
                        TextField("", text: $nameFieldValue)
                            .padding()
                            .foregroundColor(.textForegroundColor)
                            .background(Color.textBackgroundColor)
                        }
                    }

                    Section(header: Text("Ore richieste per completarlo")) {
                        TextField("", text: timeRequiredBinding)
                            .padding()
                            .keyboardType(.numberPad)
                            .foregroundColor(.textForegroundColor)
                            .background(Color.textBackgroundColor)
                    }

                    Section(header: Text("Nº ore in cui ci lavoro")) {
                        HStack {
                            VStack {
                                Text("Lunedì")
                                TextField("", text: mondayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                            VStack {
                                Text("Martedì")
                                TextField("", text: tuesdayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                            VStack {
                                Text("Mercoledì")
                                TextField("", text: wednesdayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                        }
                        HStack {
                            VStack {
                                Text("Giovedì")
                                TextField("", text: thursdayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                            VStack {
                                Text("Venerdì")
                                TextField("", text: fridayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                        }
                        HStack {
                            VStack {
                                Text("Sabato")
                                TextField("", text: saturdayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                            VStack {
                                Text("Domenica")
                                TextField("", text: sundayBinding)
                                    .padding()
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.textForegroundColor)
                                    .background(Color.textBackgroundColor)
                            }
                        }.background(Color.clear)
                    }

                    Section(header: Text("Data di completamento")) {
                        Text(completionDate?.formatted ?? " ")
                            .font(.largeTitle)
                            .bold()
                            .multilineTextAlignment(.center)
                    }
                    
                    Button(action: {
                        storeNewGoal()
                    }) {
                        HStack {
                            Spacer()
                            HStack {
                                Image(systemName: "plus.rectangle.fill").foregroundColor(.green)
                                Text("Aggiungi")
                                    .foregroundColor(.green)
                            }
                            .padding(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .stroke(lineWidth: 2.0)
                                    .foregroundColor(.green)
                            )
                        }
                    }.accentColor(.green)
                }
                .navigationBarTitle("Nuovo obiettivo", displayMode: .inline)
                .padding(.top, 10)
                .foregroundColor(Color.green)
                .background(Color.black)
            }
        }
    }

    func storeNewGoal() {
        if isValid() {
            let newGoal = Goal(context: viewContext)
            newGoal.name = nameFieldValue
            newGoal.createdAt = Date()
            newGoal.timeRequired = Int32(timeRequiredFieldValue) ?? 0
            newGoal.mondayHours = Int16(mondayHoursValue) ?? 0
            newGoal.tuesdayHours = Int16(tuesdayHoursValue) ?? 0
            newGoal.wednesdayHours = Int16(wednesdayHoursValue) ?? 0
            newGoal.thursdayHours = Int16(thursdayHoursValue) ?? 0
            newGoal.fridayHours = Int16(fridayHoursValue) ?? 0
            newGoal.saturdayHours = Int16(saturdayHoursValue) ?? 0
            newGoal.sundayHours = Int16(sundayHoursValue) ?? 0
            newGoal.completionDateExtimated = Date().adding(days: 46)
            PersistenceController.shared.saveContext()
            self.isPresented = false
        }
    }

    func isValid() -> Bool {
        true
    }

    func updateCompletionDate() {
        if let timeRequired = Int32(timeRequiredFieldValue), atLeastOneDayWorking {
            let mondayHours = Int32(mondayHoursValue) ?? 0
            let tuesdayHours = Int32(tuesdayHoursValue) ?? 0
            let wednesdayHours = Int32(wednesdayHoursValue) ?? 0
            let thursdayHours = Int32(thursdayHoursValue) ?? 0
            let fridayHours = Int32(fridayHoursValue) ?? 0
            let saturdayHours = Int32(saturdayHoursValue) ?? 0
            let sundayHours = Int32(sundayHoursValue) ?? 0

            let dayHours = [sundayHours, mondayHours, tuesdayHours, wednesdayHours, thursdayHours, fridayHours, saturdayHours]
            var daysRequired = -1
            var decreasingTotal = timeRequired
            var dayNumber = Date().dayNumber

            while decreasingTotal > 0 {
                daysRequired += 1
                decreasingTotal -= dayHours[dayNumber - 1]
                dayNumber += 1
                if dayNumber == 8 {
                    dayNumber = 1
                }
            }

            completionDate = Date().adding(days: daysRequired)
        }
    }

    var atLeastOneDayWorking: Bool {
        Int32(mondayHoursValue) ?? 0 != 0 || Int32(tuesdayHoursValue) ?? 0 != 0
            || Int32(wednesdayHoursValue) ?? 0 != 0 || Int32(thursdayHoursValue) ?? 0 != 0
            || Int32(fridayHoursValue) ?? 0 != 0 || Int32(saturdayHoursValue) ?? 0 != 0
            || Int32(sundayHoursValue) ?? 0 != 0
    }

}

struct AddNewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalView(isPresented: .constant(true))
            .environment(\.managedObjectContext,
                         PersistenceController.shared.container.viewContext)
    }
}
