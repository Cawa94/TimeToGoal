//
//  AddNewGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

private extension Color {

    static let fieldsTitleForegroundColor: Color = .black
    static let fieldsTextForegroundColor: Color = .white
    static let fieldsBackgroundColor: Color = .grayFields
    static let viewBackgroundColor: Color = .pageBackground
    static let subFieldsTextColor: Color = .goalColor

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85
    static let pickerViewWidht: CGFloat = 40 // because it's rotated 90º

}

struct AddNewGoalView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var isPresented: Bool
    @State var contentOffset: CGFloat = 0

    @State var nameFieldValue: String = ""
    @State var timeRequiredFieldValue: String = ""
    @State var daysRequired: Int = 0

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

        BackgroundView(color: .pageBackground) {
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("Che obiettivo vuoi raggiungere?")) {
                            TextField("", text: $nameFieldValue)
                                .padding()
                                .foregroundColor(.fieldsTextForegroundColor)
                                .background(Color.fieldsBackgroundColor)
                                .cornerRadius(.defaultRadius)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("Quante ore ci vogliono?")) {
                            TextField("", text: timeRequiredBinding)
                                .padding()
                                .keyboardType(.numberPad)
                                .foregroundColor(.fieldsTextForegroundColor)
                                .background(Color.fieldsBackgroundColor)
                                .cornerRadius(.defaultRadius)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("Quante ore al giorno ci lavorerai?")) {
                            HStack {
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Lunedì").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: mondayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: mondayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Martedì").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: tuesdayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: tuesdayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Mercoledì").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: wednesdayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: wednesdayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                            HStack {
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Giovedì").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: thursdayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: wednesdayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Venerdì").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: fridayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: wednesdayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                            HStack {
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Sabato").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: saturdayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: wednesdayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                                GeometryReader { vContainer in
                                    VStack {
                                        Text("Domenica").foregroundColor(.subFieldsTextColor).bold()
                                        ZStack {
                                            TextField("", text: sundayBinding)
                                                .padding()
                                                .foregroundColor(.fieldsBackgroundColor)
                                                .background(Color.fieldsBackgroundColor)
                                                .cornerRadius(.defaultRadius)
                                            HorizontalPickerView(selectedValue: wednesdayBinding,
                                                                 size: .init(width: vContainer.size.width, height: .pickerViewWidht))
                                                .frame(width: vContainer.size.width, height: 30, alignment: .center)
                                                .clipped()
                                        }
                                    }.clipped()
                                }
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("Raggiungerai il tuo obiettivo il:")) {
                            VStack {
                                Text(completionDate?.formatted ?? Date().formatted)
                                    .font(.largeTitle)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(.subFieldsTextColor)
                                Text("(\(daysRequired) giorni)")
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(.subFieldsTextColor)
                            }
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section {
                            Button(action: {
                                storeNewGoal()
                            }) {
                                HStack {
                                    Spacer()
                                    HStack {
                                        Image(systemName: "plus.rectangle.fill").foregroundColor(.subFieldsTextColor)
                                        Text("Aggiungi").bold().foregroundColor(.subFieldsTextColor)
                                    }
                                    .padding(15.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .defaultRadius)
                                            .stroke(lineWidth: 2.0)
                                            .foregroundColor(.subFieldsTextColor)
                                    )
                                }
                            }.accentColor(.subFieldsTextColor)
                            .listRowBackground(Color.viewBackgroundColor)
                        }
                        .padding(.bottom, 20)
                    }
                    .navigationBarTitle("Nuovo obiettivo", displayMode: .large)
                    .background(NavigationService { navService in
                        navService.navigationBar.barTintColor = .pageBackground
                        navService.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.goalColor]
                    })
                    .padding(.top, 10)
                    .foregroundColor(Color.subFieldsTextColor)
                    .background(Color.viewBackgroundColor)
                }
            }
        }.onAppear(perform: {
            UITableView.appearance().backgroundColor = .pageBackground
            UITableView.appearance().sectionIndexBackgroundColor = .pageBackground
            UITableView.appearance().sectionIndexColor = .pageBackground
        })
    }

    func storeNewGoal() {
        if isValid() {
            let newGoal = Goal(context: viewContext)
            newGoal.name = nameFieldValue
            newGoal.createdAt = Date()
            newGoal.timeRequired = Double(timeRequiredFieldValue) ?? 0
            newGoal.mondayHours = Double(mondayHoursValue) ?? 0
            newGoal.tuesdayHours = Double(tuesdayHoursValue) ?? 0
            newGoal.wednesdayHours = Double(wednesdayHoursValue) ?? 0
            newGoal.thursdayHours = Double(thursdayHoursValue) ?? 0
            newGoal.fridayHours = Double(fridayHoursValue) ?? 0
            newGoal.saturdayHours = Double(saturdayHoursValue) ?? 0
            newGoal.sundayHours = Double(sundayHoursValue) ?? 0
            newGoal.completionDateExtimated = Date().adding(days: 46)
            PersistenceController.shared.saveContext()
            self.isPresented = false
        }
    }

    func isValid() -> Bool {
        if !nameFieldValue.isEmpty, Double(timeRequiredFieldValue) ?? 0 != 0, atLeastOneDayWorking {
            return true
        }
        return false
    }

    func updateCompletionDate() {
        if let timeRequired = Double(timeRequiredFieldValue), atLeastOneDayWorking {
            let mondayHours = Double(mondayHoursValue) ?? 0
            let tuesdayHours = Double(tuesdayHoursValue) ?? 0
            let wednesdayHours = Double(wednesdayHoursValue) ?? 0
            let thursdayHours = Double(thursdayHoursValue) ?? 0
            let fridayHours = Double(fridayHoursValue) ?? 0
            let saturdayHours = Double(saturdayHoursValue) ?? 0
            let sundayHours = Double(sundayHoursValue) ?? 0

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

            self.daysRequired = daysRequired
            completionDate = Date().adding(days: daysRequired)
        }
    }

    var atLeastOneDayWorking: Bool {
        Double(mondayHoursValue) ?? 0 != 0 || Double(tuesdayHoursValue) ?? 0 != 0
            || Double(wednesdayHoursValue) ?? 0 != 0 || Double(thursdayHoursValue) ?? 0 != 0
            || Double(fridayHoursValue) ?? 0 != 0 || Double(saturdayHoursValue) ?? 0 != 0
            || Double(sundayHoursValue) ?? 0 != 0
    }

}

struct AddNewGoalView_Previews: PreviewProvider {

    static var previews: some View {
        AddNewGoalView(isPresented: .constant(true))
            .environment(\.managedObjectContext,
                         PersistenceController.shared.container.viewContext)
    }

}
