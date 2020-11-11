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

}

public class AddNewGoalViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var isColorsVisible = false

    var isNewGoal: Bool

    init(existingGoal: Goal? = nil) {
        self.isNewGoal = existingGoal == nil

        if let existingGoal = existingGoal {
            goal = existingGoal
        } else {
            let newGoal = Goal(context: PersistenceController.shared.container.viewContext)
            goal = newGoal
            goal.color = "orangeGoal"
        }
    }

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85
    static let pickerViewWidth: CGFloat = 40 // it's actually height, because it's rotated 90º

}

struct AddNewGoalView: View {

    @ObservedObject var viewModel: AddNewGoalViewModel
    @Binding var isPresented: Bool

    @State var completionDate = Date()

    @ViewBuilder
    var body: some View {
        let nameBinding = Binding<String>(get: {
            "\(viewModel.goal.name ?? "")"
        }, set: {
            viewModel.goal.name = $0
            viewModel.goal = viewModel.goal
        })

        let timeRequiredBinding = Binding<String>(get: {
            return viewModel.goal.timeRequired.stringWithoutDecimals == "0"
                ? "" : viewModel.goal.timeRequired.stringWithoutDecimals
        }, set: {
            viewModel.goal.timeRequired = Double($0) ?? 0
            updateCompletionDate()
        })

        let customMeasureBinding = Binding<String>(get: {
            if viewModel.goal.goalType == .custom {
                let customMeasure = viewModel.goal.customTimeMeasure != nil
                    ? viewModel.goal.customTimeMeasure : "goal_custom_measure_unit".localized()
                return customMeasure ?? ""
            } else {
                return "\(viewModel.goal.customTimeMeasure ?? "")"
            }
        }, set: {
            viewModel.goal.customTimeMeasure = $0
            viewModel.goal = viewModel.goal
        })

        let mondayBinding = Binding<String>(get: {
            return "\(viewModel.goal.monday)"
        }, set: {
            viewModel.goal.monday = Double($0) ?? 0
            updateCompletionDate()
        })

        let tuesdayBinding = Binding<String>(get: {
            "\(viewModel.goal.tuesday)"
        }, set: {
            viewModel.goal.tuesday = Double($0) ?? 0
            updateCompletionDate()
        })

        let wednesdayBinding = Binding<String>(get: {
            "\(viewModel.goal.wednesday)"
        }, set: {
            viewModel.goal.wednesday = Double($0) ?? 0
            updateCompletionDate()
        })

        let thursdayBinding = Binding<String>(get: {
            "\(viewModel.goal.thursday)"
        }, set: {
            viewModel.goal.thursday = Double($0) ?? 0
            updateCompletionDate()
        })

        let fridayBinding = Binding<String>(get: {
            "\(viewModel.goal.friday)"
        }, set: {
            viewModel.goal.friday = Double($0) ?? 0
            updateCompletionDate()
        })

        let saturdayBinding = Binding<String>(get: {
            "\(viewModel.goal.saturday)"
        }, set: {
            viewModel.goal.saturday = Double($0) ?? 0
            updateCompletionDate()
        })

        let sundayBinding = Binding<String>(get: {
            "\(viewModel.goal.sunday)"
        }, set: {
            viewModel.goal.sunday = Double($0) ?? 0
            updateCompletionDate()
        })

        BackgroundView(color: .pageBackground) {
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("add_goal_type_title".localized())) {
                            TypeSelectorView(viewModel: .init(goal: $viewModel.goal))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.mainQuestion.localized())) {
                            TextField("", text: nameBinding)
                                .padding()
                                .foregroundColor(.fieldsTextForegroundColor)
                                .background(Color.grayFields)
                                .cornerRadius(.defaultRadius)
                                .disableAutocorrection(true)
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(String(format: viewModel.goal.goalType.timeRequiredQuestion.localized(),
                                                    customMeasureBinding.wrappedValue))) {
                            GeometryReader { vContainer in
                                HStack {
                                    if viewModel.goal.goalType == .custom {
                                        TextField("", text: timeRequiredBinding)
                                            .frame(width: vContainer.size.width / 6)
                                            .padding()
                                            .keyboardType(.numberPad)
                                            .foregroundColor(.fieldsTextForegroundColor)
                                            .background(Color.grayFields)
                                            .cornerRadius(.defaultRadius)
                                        TextField("", text: customMeasureBinding)
                                            .padding()
                                            .foregroundColor(.fieldsTextForegroundColor)
                                            .background(Color.grayFields)
                                            .cornerRadius(.defaultRadius)
                                            .disableAutocorrection(true)
                                        Spacer()
                                    } else {
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
                                    }
                                    Button(action: {
                                        viewModel.isColorsVisible.toggle()
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: .defaultRadius)
                                                .fill(Color.grayFields)
                                                .aspectRatio(1.0, contentMode: .fit)
                                            Circle()
                                                .fill(viewModel.goal.goalColor)
                                                .aspectRatio(1.0, contentMode: .fit)
                                                .padding(12.5)
                                        }
                                    }.accentColor(viewModel.goal.goalColor)
                                }
                            }.frame(height: 55)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(String(format: viewModel.goal.goalType.timeForDayQuestion.localized(),
                                                    customMeasureBinding.wrappedValue))) {
                            HStack {
                                HoursSelectorView(viewModel: .init(title: "global_monday".localized(),
                                                                   bindingString: mondayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                                HoursSelectorView(viewModel: .init(title: "global_tuesday".localized(),
                                                                   bindingString: tuesdayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                                HoursSelectorView(viewModel: .init(title: "global_wednesday".localized(),
                                                                   bindingString: wednesdayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                            HStack {
                                HoursSelectorView(viewModel: .init(title: "global_thursday".localized(),
                                                                   bindingString: thursdayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                                HoursSelectorView(viewModel: .init(title: "global_friday".localized(),
                                                                   bindingString: fridayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                            HStack {
                                HoursSelectorView(viewModel: .init(title: "global_saturday".localized(),
                                                                   bindingString: saturdayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                                HoursSelectorView(viewModel: .init(title: "global_sunday".localized(),
                                                                   bindingString: sundayBinding,
                                                                   color: viewModel.goal.goalColor,
                                                                   goal: $viewModel.goal))
                            }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("add_goal_extimated_date_title".localized())) {
                            VStack {
                                Text(completionDate.formattedAsDateString)
                                    .font(.largeTitle)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(viewModel.goal.goalColor)
                                Text(String(format: "add_goal_days_required".localized(),
                                            "\(viewModel.goal.daysRequired)"))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(viewModel.goal.goalColor)
                            }
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section {
                            Button(action: {
                                viewModel.goal.customTimeMeasure = customMeasureBinding.wrappedValue
                                storeNewGoal()
                            }) {
                                HStack {
                                    Spacer()
                                    Text(viewModel.isNewGoal ? "global_add".localized() : "global_update".localized())
                                        .bold()
                                        .foregroundColor(.white)
                                        .font(.title2)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .padding([.top, .bottom], 15)
                                .background(LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                                           startPoint: .topLeading, endPoint: .bottomTrailing))
                                .cornerRadius(.defaultRadius)
                                .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                            }.accentColor(viewModel.goal.goalColor)
                        }
                        .padding([.bottom], 5)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
                    }
                    if viewModel.isColorsVisible {
                        ColorSelectorView(viewModel: .init(goal: $viewModel.goal),
                                          isPresented: $viewModel.isColorsVisible)
                    }
                }.navigationBarTitle(viewModel.goal.goalType.title.localized(), displayMode: .large)
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    func storeNewGoal() {
        if viewModel.goal.isValid {
            viewModel.goal.createdAt = Date()
            viewModel.goal.editedAt = Date()
            viewModel.goal.timesHasBeenTracked = 0
            FirebaseService.logConversion(.goalCreated, goal: viewModel.goal)
            PersistenceController.shared.saveContext()
            self.isPresented = false
        }
    }

    func updateCompletionDate() {
        if viewModel.goal.timeRequired != 0, viewModel.goal.atLeastOneDayWorking {
            FirebaseService.logEvent(.updateCompletionDate)
            completionDate = viewModel.goal.updatedCompletionDate
            viewModel.goal.completionDateExtimated = viewModel.goal.updatedCompletionDate
        }
    }

}
/*
struct AddNewGoalView_Previews: PreviewProvider {

    static var previews: some View {
        AddNewGoalView(isPresented: .constant(true))
            .environment(\.managedObjectContext,
                         PersistenceController.shared.container.viewContext)
    }

}
*/
