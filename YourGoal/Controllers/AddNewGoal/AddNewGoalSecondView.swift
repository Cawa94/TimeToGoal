//
//  AddNewGoalSecondView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import SwiftUI

private extension Color {

    static let fieldsTitleForegroundColor: Color = .black
    static let fieldsTextForegroundColor: Color = .white

}

public class AddNewGoalSecondViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var isColorsVisible = false

    var isNewGoal: Bool

    init(goal: Goal, isNew: Bool) {
        self.isNewGoal = isNew
        self.goal = goal
    }

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85
    static let pickerViewWidth: CGFloat = 40 // it's actually height, because it's rotated 90º

}

struct AddNewGoalSecondView: View {

    @ObservedObject var viewModel: AddNewGoalSecondViewModel
    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool
    @Binding var isAllFormPresented: Bool

    @State var completionDate = Date()

    @ViewBuilder
    var body: some View {
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
            
        BackgroundView(color: .pageLightBackground, barTintColor: viewModel.goal.goalUIColor) {
            ZStack {
                Form {
                    Section(header: Text(String(format: viewModel.goal.goalType.timeRequiredQuestion,
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
                    .listRowBackground(Color.pageLightBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)

                    Section(header: Text(String(format: viewModel.goal.goalType.timeForDayQuestion,
                                                customMeasureBinding.wrappedValue))) {
                        HStack {
                            HoursSelectorView(viewModel: .init(title: "global_monday",
                                                               bindingString: mondayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                            HoursSelectorView(viewModel: .init(title: "global_tuesday",
                                                               bindingString: tuesdayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                            HoursSelectorView(viewModel: .init(title: "global_wednesday",
                                                               bindingString: wednesdayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                        }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                        HStack {
                            HoursSelectorView(viewModel: .init(title: "global_thursday",
                                                               bindingString: thursdayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                            HoursSelectorView(viewModel: .init(title: "global_friday",
                                                               bindingString: fridayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                        }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                        HStack {
                            HoursSelectorView(viewModel: .init(title: "global_saturday",
                                                               bindingString: saturdayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                            HoursSelectorView(viewModel: .init(title: "global_sunday",
                                                               bindingString: sundayBinding,
                                                               color: viewModel.goal.goalColor,
                                                               goal: $viewModel.goal))
                        }.frame(width: .infinity, height: .hoursFieldsHeight, alignment: .center)
                    }
                    .listRowBackground(Color.pageLightBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)

                    Section(header: Text("add_goal_extimated_date_title")) {
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
                    .listRowBackground(Color.pageLightBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)
                    
                    Section {
                        Button(action: {
                            viewModel.goal.customTimeMeasure = customMeasureBinding.wrappedValue
                            storeNewGoal()
                        }) {
                            HStack {
                                Spacer()
                                Text(viewModel.isNewGoal ? "global_add" : "global_update")
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
                    .listRowBackground(Color.pageLightBackground)
                }

                if viewModel.isColorsVisible {
                    ColorSelectorView(viewModel: .init(goal: $viewModel.goal),
                                      isPresented: $viewModel.isColorsVisible)
                }
            }
            .navigationBarTitle("global_time_required", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.isPresented.toggle()
                }) {
                    Image(systemName: "chevron.left")
            })
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    func storeNewGoal() {
        if viewModel.goal.isValid {
            if viewModel.isNewGoal {
                viewModel.goal.createdAt = Date()
            }
            viewModel.goal.editedAt = Date()
            viewModel.goal.timesHasBeenTracked = 0
            FirebaseService.logConversion(.goalCreated, goal: viewModel.goal)
            PersistenceController.shared.saveContext()
            self.activeSheet = nil
            self.isAllFormPresented = false
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
struct AddNewGoalSecondView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalSecondView()
    }
}
*/
