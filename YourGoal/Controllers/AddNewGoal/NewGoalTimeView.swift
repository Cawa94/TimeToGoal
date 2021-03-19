//
//  AddNewGoalSecondView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import SwiftUI

public class NewGoalTimeViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var challenges: [Challenge]
    @Published var showErrorAlert = false
    @Published var startDate = Date()

    var isNewGoal: Bool

    init(goal: Goal, challenges: [Challenge], isNew: Bool = false) {
        self.isNewGoal = isNew
        self.challenges = challenges
        self.goal = goal
    }

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85
    static let togglerFieldsHeight: CGFloat = 90

}

struct NewGoalTimeView: View {

    @ObservedObject var viewModel: NewGoalTimeViewModel

    @State var showTutorial = false
    @State var showQuestionsView = false
    @State var completionDate = Date()
    @State var measureUnitSelectedIndex = 0

    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    init(viewModel: NewGoalTimeViewModel,
         activeSheet: Binding<ActiveSheet?>,
         isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self._activeSheet = activeSheet
        self._isPresented = isPresented

        updateCompletionDate()
    }

    @ViewBuilder
    var body: some View {
        let timeRequiredBinding = Binding<String>(get: {
            viewModel.goal.timeRequired.stringWithoutDecimals
        }, set: {
            viewModel.goal.timeRequired = Double($0) ?? 0
            updateCompletionDate()
        })

        let customMeasureBinding = Binding<String>(get: {
            viewModel.goal.customTimeMeasure ?? ""
        }, set: {
            viewModel.goal.customTimeMeasure = $0
            viewModel.goal = viewModel.goal
        })

        let timeFrameBinding = Binding<String>(get: {
            viewModel.goal.timeFrame ?? ""
        }, set: {
            viewModel.goal.timeFrame = $0
            viewModel.goal = viewModel.goal
        })

        let mondayBinding = Binding<String>(get: {
            "\(viewModel.goal.monday)"
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
                NavigationLink(destination: NewGoalQuestionsView(viewModel: .init(goal: viewModel.goal,
                                                                                  challenges: viewModel.challenges,
                                                                                  isNewGoal: viewModel.isNewGoal),
                                                                 activeSheet: $activeSheet,
                                                                 isPresented: $showQuestionsView),
                               isActive: $showQuestionsView) {
                    EmptyView()
                }

                Form {
                    Section(header: HStack {
                        Text("global_your_goal").applyFont(.fieldQuestion).multilineTextAlignment(.center)
                        Spacer()
                        /*if viewModel.goal.goalType.isHabit {
                            Button(action: {
                                self.showTutorial = true
                            }) {
                                Text("aiuto").applyFont(.smallButton).foregroundColor(viewModel.goal.goalColor)
                                    .padding([.top, .bottom], 1)
                                    .padding([.leading, .trailing], 10)
                                    .cornerRadius(.defaultRadius)
                                    .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                                .stroke(viewModel.goal.goalColor, lineWidth: 1))
                            }
                        }*/
                    }) {
                        VStack(spacing: 10) {
                            if MeasureUnit.getFrom(customMeasureBinding.wrappedValue) == .singleTime
                                || MeasureUnit.getFrom(customMeasureBinding.wrappedValue) == .time
                                || MeasureUnit.getFrom(customMeasureBinding.wrappedValue) == .page {
                                Text(viewModel.goal.goalType.timeSentence?.localized() ?? "")
                                    .foregroundColor(.grayText)
                                    .multilineTextAlignment(.center)
                                    .applyFont(.largeTitle)
                                timeRequiredView(timeRequiredBinding: timeRequiredBinding, customMeasureBinding: customMeasureBinding)
                            } else {
                                Spacer()
                                    .frame(height: 10)
                                timeRequiredView(timeRequiredBinding: timeRequiredBinding, customMeasureBinding: customMeasureBinding)
                                Text(viewModel.goal.goalType.ofGoalSentence?.localized() ?? "")
                                    .foregroundColor(.grayText)
                                    .applyFont(.largeTitle)
                            }
                            Spacer()
                                .frame(height: 0)
                            if viewModel.goal.goalType.isHabit {
                                HStack(spacing: 10) {
                                    weeklyButton(timeFrameBinding: timeFrameBinding)
                                    monthlyButton(timeFrameBinding: timeFrameBinding)
                                }
                            }
                        }
                    }
                    .applyFont(.body)
                    .textCase(nil)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.defaultBackground)
                    .foregroundColor(.fieldsTitleForegroundColor)

                    if MeasureUnit.getFrom(customMeasureBinding.wrappedValue) == .singleTime {
                        dayTogglersSection(customMeasureBinding: customMeasureBinding, mondayBinding: mondayBinding,
                                           tuesdayBinding: tuesdayBinding, wednesdayBinding: wednesdayBinding,
                                           thursdayBinding: thursdayBinding, fridayBinding: fridayBinding,
                                           saturdayBinding: saturdayBinding, sundayBinding: sundayBinding)
                    } else {
                        daySelectorsSection(customMeasureBinding: customMeasureBinding, mondayBinding: mondayBinding,
                                            tuesdayBinding: tuesdayBinding, wednesdayBinding: wednesdayBinding,
                                            thursdayBinding: thursdayBinding, fridayBinding: fridayBinding,
                                            saturdayBinding: saturdayBinding, sundayBinding: sundayBinding)
                    }

                    if !viewModel.goal.goalType.isHabit {
                        Section(header: Text("add_goal_extimated_date_title").applyFont(.fieldQuestion)) {
                            VStack {
                                Text(completionDate.formattedAsDateString)
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
                    }
                    
                    Section {
                        Button(action: {
                            if viewModel.goal.timeRequired != 0, viewModel.goal.atLeastOneDayWorking {
                                viewModel.goal = viewModel.goal
                                showQuestionsView = true
                            } else {
                                viewModel.showErrorAlert = true
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("global_next")
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
                        .alert(isPresented: $viewModel.showErrorAlert) {
                            let measureUnit = customMeasureBinding.wrappedValue
                            return Alert(title: Text("global_wait"),
                                         message: viewModel.goal.timeRequired != 0
                                            ? Text("add_goal_missing_work_time")
                                            : Text(String(format: "add_goal_missing_total_time".localized(),
                                                          measureUnit)),
                                         dismissButton: .default(Text("global_got_it")))
                        }
                    }
                    .textCase(nil)
                    .padding([.bottom], 5)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.defaultBackground)
                }
            }
            .navigationBarTitle("global_time_required", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: leadingButton, trailing: trailingButton)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onAppear {
            if self.viewModel.goal.customTimeMeasure == nil || self.viewModel.goal.customTimeMeasure == "" {
                self.viewModel.goal.customTimeMeasure = self.viewModel.goal.goalType.measureUnits.first?.namePlural
            }
            updateCompletionDate()
        }
        .sheet(isPresented: $showTutorial) {
            TutorialView(viewModel: .init(tutorialType: .target), isPresented: $showTutorial, activeSheet: $activeSheet)
        }

    }

    var leadingButton: some View {
        Button(action: {
            if viewModel.isNewGoal {
                self.viewModel.goal.resetAllInfo()
            }
            self.isPresented = false
        }) {
            Image(systemName: "chevron.left")
        }
    }

    var trailingButton: some View {
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

    func timeRequiredView(timeRequiredBinding: Binding<String>, customMeasureBinding: Binding<String>) -> some View {
        GeometryReader { vContainer in
            HStack {
                Spacer()
                TextField("", text: timeRequiredBinding)
                    .frame(width: vContainer.size.width / 3, height: 55)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .foregroundColor(timeRequiredBinding.wrappedValue != "0" && timeRequiredBinding.wrappedValue != ""
                                        ? .white : .grayText)
                    .applyFont(.fieldLarge)
                    .background(timeRequiredBinding.wrappedValue != "0" && timeRequiredBinding.wrappedValue != ""
                                    ? LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                                     startPoint: .topLeading, endPoint: .bottomTrailing)
                                    : nil)
                    .cornerRadius(.defaultRadius)
                    .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                .stroke(Color.grayBorder, lineWidth: 1))
                    .onTapGesture {
                        if timeRequiredBinding.wrappedValue == "0" {
                            timeRequiredBinding.wrappedValue = " "
                        }
                    }
                TextFieldWithPickerAsInputView(data: viewModel.goal.goalType.measureUnits.map { $0.namePlural },
                                               placeholder: "Unità di misura",
                                               selectionIndex: $measureUnitSelectedIndex,
                                               text: customMeasureBinding)
                    .frame(width: vContainer.size.width / 1.65, height: 55)
                    .background(LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                               startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(.defaultRadius)
                    .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                .stroke(Color.grayBorder, lineWidth: 1))
                Spacer()
            }
        }.frame(height: 55)
    }

    func weeklyButton(timeFrameBinding: Binding<String>) -> some View {
        HStack {
            Button(action: {
                timeFrameBinding.wrappedValue = "weekly"
            }) {
                HStack {
                    Spacer()
                    Text("global_weekly")
                    Spacer()
                }
                    .foregroundColor(timeFrameBinding.wrappedValue == "weekly" ? .white : .gray)
                    .applyFont(.smallButton)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .background(timeFrameBinding.wrappedValue == "weekly"
                                    ? LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                                     startPoint: .topLeading, endPoint: .bottomTrailing)
                                    : nil)
                    .cornerRadius(.defaultRadius)
                    .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                .stroke(Color.grayBorder, lineWidth: 1))
            }.accentColor(viewModel.goal.goalColor)
        }
    }

    func monthlyButton(timeFrameBinding: Binding<String>) -> some View {
        HStack {
            Button(action: {
                timeFrameBinding.wrappedValue = "monthly"
            }) {
                HStack {
                    Spacer()
                    Text("global_monthly")
                    Spacer()
                }
                    .foregroundColor(timeFrameBinding.wrappedValue == "monthly" ? .white : .gray)
                    .applyFont(.smallButton)
                    .multilineTextAlignment(.center)
                    .padding([.top, .bottom], 10)
                    .background(timeFrameBinding.wrappedValue == "monthly"
                                    ? LinearGradient(gradient: Gradient(colors: viewModel.goal.rectGradientColors),
                                                     startPoint: .topLeading, endPoint: .bottomTrailing)
                                    : nil)
                    .cornerRadius(.defaultRadius)
                    .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                .stroke(Color.grayBorder, lineWidth: 1))
            }.accentColor(viewModel.goal.goalColor)
        }
    }

    func daySelectorsSection(customMeasureBinding: Binding<String>, mondayBinding: Binding<String>,
                             tuesdayBinding: Binding<String>, wednesdayBinding: Binding<String>,
                             thursdayBinding: Binding<String>, fridayBinding: Binding<String>,
                             saturdayBinding: Binding<String>, sundayBinding: Binding<String>) -> some View {
        Section(header: Text(String(format: "goal_custom_time_for_day".localized(),
                                    customMeasureBinding.wrappedValue.capitalized)).applyFont(.fieldQuestion)) {
            VStack {
                HStack(spacing: 15) {
                    VStack {
                        HoursSelectorView(goal: viewModel.goal, bindingString: mondayBinding)
                        Text("global_monday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack {
                        HoursSelectorView(goal: viewModel.goal, bindingString: tuesdayBinding)
                        Text("global_tuesday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                }.frame(width: .infinity, height: .hoursFieldsHeight)

                HStack(spacing: 15) {
                    VStack {
                        HoursSelectorView(goal: viewModel.goal, bindingString: wednesdayBinding)
                        Text("global_wednesday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack {
                        HoursSelectorView(goal: viewModel.goal, bindingString: thursdayBinding)
                        Text("global_thursday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                }.frame(width: .infinity, height: .hoursFieldsHeight)

                HStack(spacing: 15) {
                    VStack {
                        HoursSelectorView(goal: viewModel.goal, bindingString: fridayBinding)
                        Text("global_friday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack {
                        HoursSelectorView(goal: viewModel.goal, bindingString: saturdayBinding)
                        Text("global_saturday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                }.frame(width: .infinity, height: .hoursFieldsHeight)

                GeometryReader { vContainer in
                    HStack(spacing: 15) {
                        Spacer()
                        VStack {
                            HoursSelectorView(goal: viewModel.goal, bindingString: sundayBinding)
                            Text("global_sunday".localized())
                                .foregroundColor(.grayText)
                                .applyFont(.small)
                        }.frame(width: vContainer.size.width/2, height: .hoursFieldsHeight)
                        Spacer()
                    }
                }.frame(width: .infinity, height: .hoursFieldsHeight)
            }
        }
        .applyFont(.body)
        .textCase(nil)
        .listRowBackground(Color.defaultBackground)
        .foregroundColor(.fieldsTitleForegroundColor)
    }

    func dayTogglersSection(customMeasureBinding: Binding<String>, mondayBinding: Binding<String>,
                            tuesdayBinding: Binding<String>, wednesdayBinding: Binding<String>,
                            thursdayBinding: Binding<String>, fridayBinding: Binding<String>,
                            saturdayBinding: Binding<String>, sundayBinding: Binding<String>) -> some View {
        Section(header: Text("goal_custom_what_days").applyFont(.fieldQuestion)) {
            VStack {
                HStack(spacing: 15) {
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: mondayBinding,
                                       goal: $viewModel.goal)
                        Text("global_monday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: tuesdayBinding,
                                       goal: $viewModel.goal)
                        Text("global_tuesday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: wednesdayBinding,
                                       goal: $viewModel.goal)
                        Text("global_wednesday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: thursdayBinding,
                                       goal: $viewModel.goal)
                        Text("global_thursday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                }.frame(width: .infinity, height: .togglerFieldsHeight)

                HStack(spacing: 15) {
                    Spacer()
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: fridayBinding,
                                       goal: $viewModel.goal)
                        Text("global_friday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: saturdayBinding,
                                       goal: $viewModel.goal)
                        Text("global_saturday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    VStack(spacing: 5) {
                        DayTogglerView(bindingString: sundayBinding,
                                       goal: $viewModel.goal)
                        Text("global_sunday".localized())
                            .foregroundColor(.grayText)
                            .applyFont(.small)
                    }
                    Spacer()
                }.frame(width: .infinity, height: .togglerFieldsHeight)
            }
        }
        .applyFont(.body)
        .textCase(nil)
        .listRowBackground(Color.defaultBackground)
        .foregroundColor(.fieldsTitleForegroundColor)
    }

    func updateCompletionDate() {
        completionDate = viewModel.goal.updatedCompletionDate ?? Date()
    }

}
/*
struct AddNewGoalSecondView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalSecondView()
    }
}
*/
