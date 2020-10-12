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
    static let viewBackgroundColor: Color = .pageBackground

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85
    static let pickerViewWidth: CGFloat = 40 // because it's rotated 90º

}

struct AddNewGoalView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @Binding var isPresented: Bool
    @State var isColorsVisible = false
    @State var contentOffset: CGFloat = 0
    @State var selectedColor = "greenGoal"

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

    var colors = ["greenGoal", "yellowGoal", "redGoal", "orangeGoal", "blueGoal", "purpleGoal"]

    @ViewBuilder
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
                        Section(header: Text("add_goal_name_title".localized())) {
                            TextField("", text: $nameFieldValue)
                                .padding()
                                .foregroundColor(.fieldsTextForegroundColor)
                                .background(Color.grayFields)
                                .cornerRadius(.defaultRadius)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("add_goal_hours_required_title".localized())) {
                            GeometryReader { vContainer in
                                HStack {
                                    TextField("", text: timeRequiredBinding)
                                        .frame(width: vContainer.size.width / 3)
                                        .padding()
                                        .keyboardType(.numberPad)
                                        .foregroundColor(.fieldsTextForegroundColor)
                                        .background(Color.grayFields)
                                        .cornerRadius(.defaultRadius)
                                    Spacer()
                                    Spacer()
                                    Text("\("global_color".localized()):")
                                    Button(action: {
                                        self.isColorsVisible.toggle()
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: .defaultRadius)
                                                .fill(Color.grayFields)
                                                .aspectRatio(1.0, contentMode: .fit)
                                            Circle()
                                                .fill(Color.goalColor)
                                                .aspectRatio(1.0, contentMode: .fit)
                                                .padding(12.5)
                                        }
                                    }.accentColor(.goalColor)
                                }
                            }.frame(height: 55)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("add_goal_hours_for_day_title".localized())) {
                            HStack {
                                HoursSelectorView(viewModel: .init(title: "global_monday".localized(),
                                                                   bindingString: mondayBinding))
                                HoursSelectorView(viewModel: .init(title: "global_tuesday".localized(),
                                                                   bindingString: tuesdayBinding))
                                HoursSelectorView(viewModel: .init(title: "global_wednesday".localized(),
                                                                   bindingString: wednesdayBinding))
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                            HStack {
                                HoursSelectorView(viewModel: .init(title: "global_thursday".localized(),
                                                                   bindingString: thursdayBinding))
                                HoursSelectorView(viewModel: .init(title: "global_friday".localized(),
                                                                   bindingString: fridayBinding))
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                            HStack {
                                HoursSelectorView(viewModel: .init(title: "global_saturday".localized(),
                                                                   bindingString: saturdayBinding))
                                HoursSelectorView(viewModel: .init(title: "global_sunday".localized(),
                                                                   bindingString: sundayBinding))
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("add_goal_extimated_date_title".localized())) {
                            VStack {
                                Text(completionDate?.formattedAsDate ?? Date().formattedAsDate)
                                    .font(.largeTitle)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(.goalColor)
                                Text(String(format: "add_goal_days_required".localized(), "\(daysRequired)"))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(.goalColor)
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
                                        Image(systemName: "plus.rectangle.fill").foregroundColor(.goalColor)
                                        Text("global_add".localized()).bold().foregroundColor(.goalColor)
                                    }
                                    .padding(15.0)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .defaultRadius)
                                            .stroke(lineWidth: 2.0)
                                            .foregroundColor(.goalColor)
                                    )
                                }
                            }.accentColor(.goalColor)
                        }
                        .listRowBackground(Color.viewBackgroundColor)
                        .padding(.bottom, 20)
                    }
                    if isColorsVisible {
                        ZStack {
                            GeometryReader { container in
                                Color.black.opacity(0.75)
                                    .ignoresSafeArea()
                                VStack() {
                                    Spacer().frame(maxWidth: .infinity)
                                    HStack {
                                        Spacer().frame(maxWidth: .infinity)
                                        ZStack {
                                            RoundedRectangle(cornerRadius: .defaultRadius)
                                                .fill(Color.white)
                                                .cornerRadius(50)
                                            VStack {
                                                Spacer()
                                                HStack(spacing: 20) {
                                                    ForEach(self.colors.prefix(3), id: \.self) { color in
                                                        Button(action: {
                                                            Color.goalColor = Color(color)
                                                            UIColor.goalColor = UIColor(named: color) ?? .goalColor
                                                            self.selectedColor = color
                                                            self.isColorsVisible.toggle()
                                                        }) {
                                                            Circle()
                                                                .fill(Color(color))
                                                                .aspectRatio(1.0, contentMode: .fit)
                                                        }
                                                    }
                                                }.frame(height: 55)
                                                Spacer()
                                                HStack(spacing: 20) {
                                                    ForEach(self.colors.suffix(3), id: \.self) { color in
                                                        Button(action: {
                                                            Color.goalColor = Color(color)
                                                            UIColor.goalColor = UIColor(named: color) ?? .goalColor
                                                            self.selectedColor = color
                                                            self.isColorsVisible.toggle()
                                                        }) {
                                                            Circle()
                                                                .fill(Color(color))
                                                                .aspectRatio(1.0, contentMode: .fit)
                                                        }
                                                    }
                                                }.frame(height: 55)
                                                Spacer()
                                            }
                                        }.frame(width: container.size.width / 1.5, height: 200, alignment: .center)
                                        Spacer().frame(maxWidth: .infinity)
                                    }
                                    Spacer().frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                }.navigationBarTitle("global_new_goal".localized(), displayMode: .large)
            }
        }
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
            newGoal.completionDateExtimated = self.completionDate
            newGoal.color = self.selectedColor
            PersistenceController.shared.saveContext()
            self.isPresented = false
        }
    }

    func isValid() -> Bool {
        debugPrint("\(self.selectedColor)")
        if !nameFieldValue.isEmpty, Double(timeRequiredFieldValue) ?? 0 != 0, atLeastOneDayWorking {
            return true
        }
        return false
    }

    func updateCompletionDate() {
        if let timeRequired = Double(timeRequiredFieldValue), atLeastOneDayWorking {
            let mondayHours = (Double(mondayHoursValue) ?? 0).asHoursAndMinutes
            let tuesdayHours = (Double(tuesdayHoursValue) ?? 0).asHoursAndMinutes
            let wednesdayHours = (Double(wednesdayHoursValue) ?? 0).asHoursAndMinutes
            let thursdayHours = (Double(thursdayHoursValue) ?? 0).asHoursAndMinutes
            let fridayHours = (Double(fridayHoursValue) ?? 0).asHoursAndMinutes
            let saturdayHours = (Double(saturdayHoursValue) ?? 0).asHoursAndMinutes
            let sundayHours = (Double(sundayHoursValue) ?? 0).asHoursAndMinutes

            let dayHours = [sundayHours, mondayHours, tuesdayHours, wednesdayHours, thursdayHours, fridayHours, saturdayHours]
            var daysRequired = -1
            var decreasingTotal = timeRequired.asHoursAndMinutes
            var dayNumber = Date().dayNumber

            while decreasingTotal > Date().zeroHours {
                daysRequired += 1
                decreasingTotal = decreasingTotal.remove(dayHours[dayNumber - 1])
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
