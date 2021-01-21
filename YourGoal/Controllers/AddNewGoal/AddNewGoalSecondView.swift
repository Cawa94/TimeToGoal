//
//  AddNewGoalSecondView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import SwiftUI

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
            
        BackgroundView(color: .defaultBackground, barTintColor: viewModel.goal.goalUIColor) {
            ZStack {
                Form {
                    Section(header: Text(String(format: viewModel.goal.goalType.timeRequiredQuestion,
                                                customMeasureBinding.wrappedValue)).applyFont(.fieldQuestion)) {
                        VStack {
                            GeometryReader { vContainer in
                                HStack {
                                    if viewModel.goal.goalType == .custom {
                                        TextField("", text: timeRequiredBinding)
                                            .frame(width: vContainer.size.width / 6)
                                            .padding()
                                            .keyboardType(.numberPad)
                                            .foregroundColor(.fieldsTextForegroundColor)
                                            .background(Color.fieldsBackground)
                                            .cornerRadius(.defaultRadius)
                                            .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                        TextField("", text: customMeasureBinding)
                                            .padding()
                                            .foregroundColor(.fieldsTextForegroundColor)
                                            .background(Color.fieldsBackground)
                                            .cornerRadius(.defaultRadius)
                                            .disableAutocorrection(true)
                                            .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                        Spacer()
                                    } else {
                                        TextField("", text: timeRequiredBinding)
                                            .frame(width: vContainer.size.width / 3)
                                            .padding()
                                            .keyboardType(.numberPad)
                                            .foregroundColor(.fieldsTextForegroundColor)
                                            .background(Color.fieldsBackground)
                                            .cornerRadius(.defaultRadius)
                                            .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                        Spacer()
                                        Spacer()
                                        Text("\("global_color".localized()):")
                                            .applyFont(.small)
                                    }
                                    Button(action: {
                                        viewModel.isColorsVisible.toggle()
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: .defaultRadius)
                                                .fill(Color.fieldsBackground)
                                                .aspectRatio(1.0, contentMode: .fit)
                                            Circle()
                                                .fill(viewModel.goal.goalColor)
                                                .aspectRatio(1.0, contentMode: .fit)
                                                .padding(12.5)
                                        }
                                        .clipped()
                                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                    }.accentColor(viewModel.goal.goalColor)
                                }
                            }.frame(height: 55)
                            Spacer()
                                .frame(height: 7)
                        }
                    }
                    .applyFont(.body)
                    .textCase(nil)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.defaultBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)

                    Section(header: Text(String(format: viewModel.goal.goalType.timeForDayQuestion,
                                                customMeasureBinding.wrappedValue)).applyFont(.fieldQuestion)) {

                        HStack(spacing: 15) {
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: mondayBinding,
                                                                   goal: $viewModel.goal))
                                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                Text("global_monday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: tuesdayBinding,
                                                                   goal: $viewModel.goal))
                                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                Text("global_tuesday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                        }.frame(width: .infinity, height: .hoursFieldsHeight)

                        HStack(spacing: 15) {
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: wednesdayBinding,
                                                                   goal: $viewModel.goal))
                                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                Text("global_wednesday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: thursdayBinding,
                                                                   goal: $viewModel.goal))
                                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                Text("global_thursday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                        }.frame(width: .infinity, height: .hoursFieldsHeight)

                        HStack(spacing: 15) {
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: fridayBinding,
                                                                   goal: $viewModel.goal))
                                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                Text("global_friday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: saturdayBinding,
                                                                   goal: $viewModel.goal))
                                    .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                Text("global_saturday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                        }.frame(width: .infinity, height: .hoursFieldsHeight)

                        GeometryReader { vContainer in
                            HStack(spacing: 15) {
                                Spacer()
                                VStack {
                                    HoursSelectorView(viewModel: .init(bindingString: sundayBinding,
                                                                       goal: $viewModel.goal))
                                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                                    Text("global_sunday".localized())
                                        .foregroundColor(.grayText)
                                        .applyFont(.small)
                                }.frame(width: vContainer.size.width/2, height: .hoursFieldsHeight)
                                Spacer()
                            }
                        }.frame(width: .infinity, height: .hoursFieldsHeight)
                        
                    }
                    .applyFont(.body)
                    .textCase(nil)
                    .listRowBackground(Color.defaultBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)

                    Section(header: Text("add_goal_extimated_date_title").applyFont(.fieldQuestion)) {
                        VStack {
                            Text(completionDate.formattedAsDateString)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(Color.clear)
                                .foregroundColor(viewModel.goal.goalColor)
                                .applyFont(.largeTitle)
                        }
                    }
                    .applyFont(.body)
                    .textCase(nil)
                    .listRowBackground(Color.defaultBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)
                    
                    Section {
                        Button(action: {
                            viewModel.goal.customTimeMeasure = customMeasureBinding.wrappedValue
                            storeNewGoal()
                        }) {
                            HStack {
                                Spacer()
                                Text(viewModel.isNewGoal ? "global_add" : "global_update")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .applyFont(.button)
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
                    .textCase(nil)
                    .padding([.bottom], 5)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.defaultBackground)
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
            }, trailing: closeButton)
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

    var closeButton: some View {
        Button(action: {
            self.activeSheet = nil
        }) {
            if viewModel.isNewGoal {
                Image("close")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: 15)
            }
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
