//
//  AddNewGoalSecondView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 1/12/20.
//

import SwiftUI

public class NewGoalTimeViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var showErrorAlert = false

    var isNewGoal: Bool

    init(goal: Goal, isNew: Bool) {
        self.isNewGoal = isNew
        self.goal = goal
    }

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85

}

struct NewGoalTimeView: View {

    @ObservedObject var viewModel: NewGoalTimeViewModel
    
    @State var showQuestionsView = false
    @State var completionDate = Date()

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
            return viewModel.goal.timeRequired.stringWithoutDecimals
        }, set: {
            viewModel.goal.timeRequired = Double($0) ?? 0
            updateCompletionDate()
        })

        let customMeasureBinding = Binding<String>(get: {
            let customMeasure = viewModel.goal.customTimeMeasure != nil
                ? viewModel.goal.customTimeMeasure : viewModel.goal.goalType.measureUnits.first?.namePlural
            return customMeasure ?? ""
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
                NavigationLink(destination: NewGoalQuestionsView(viewModel: .init(goal: viewModel.goal,
                                                                                  isNewGoal: viewModel.isNewGoal),
                                                                 activeSheet: $activeSheet,
                                                                 isPresented: $showQuestionsView),
                               isActive: $showQuestionsView) {
                    EmptyView()
                }

                Form {
                    Section(header: HStack {
                        Spacer()
                        Text("Imposta il 1º traguardo").applyFont(.largeTitle).multilineTextAlignment(.center)
                        Spacer()
                    }) {
                        VStack {
                            GeometryReader { vContainer in
                                HStack {
                                    Spacer()
                                    TextField("", text: timeRequiredBinding)
                                        .frame(width: vContainer.size.width / 3, height: 75)
                                        .multilineTextAlignment(.center)
                                        .keyboardType(.numberPad)
                                        .foregroundColor(.grayText)
                                        .applyFont(.fieldLarge)
                                        .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                                    .stroke(Color.grayBorder, lineWidth: 1))
                                    Spacer()
                                }
                            }.frame(height: 75)
                            Spacer()
                                .frame(height: 30)
                            GeometryReader { vContainer in
                                HStack {
                                    TextField("", text: customMeasureBinding)
                                        .frame(width: vContainer.size.width / 2, height: 55)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.grayText)
                                        .applyFont(.field)
                                        .overlay(RoundedRectangle(cornerRadius: .defaultRadius)
                                                    .stroke(Color.grayBorder, lineWidth: 1))
                                    Text("di camminata")
                                        .foregroundColor(.grayText)
                                        .applyFont(.title2)
                                    Spacer()
                                }
                            }.frame(height: 55)
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
                                Text("global_monday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: tuesdayBinding,
                                                                   goal: $viewModel.goal))
                                Text("global_tuesday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                        }.frame(width: .infinity, height: .hoursFieldsHeight)

                        HStack(spacing: 15) {
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: wednesdayBinding,
                                                                   goal: $viewModel.goal))
                                Text("global_wednesday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: thursdayBinding,
                                                                   goal: $viewModel.goal))
                                Text("global_thursday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                        }.frame(width: .infinity, height: .hoursFieldsHeight)

                        HStack(spacing: 15) {
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: fridayBinding,
                                                                   goal: $viewModel.goal))
                                Text("global_friday".localized())
                                    .foregroundColor(.grayText)
                                    .applyFont(.small)
                            }
                            VStack {
                                HoursSelectorView(viewModel: .init(bindingString: saturdayBinding,
                                                                   goal: $viewModel.goal))
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
                            if viewModel.goal.timeRequired != 0, viewModel.goal.atLeastOneDayWorking {
                                viewModel.goal.customTimeMeasure = customMeasureBinding.wrappedValue
                                viewModel.goal = viewModel.goal
                                showQuestionsView = true
                            } else {
                                viewModel.showErrorAlert = true
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("global_next")
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
            .navigationBarItems(leading:
                Button(action: {
                    self.isPresented = false
                }) {
                    Image(systemName: "chevron.left")
            }, trailing: closeButton)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .onAppear {
            updateCompletionDate()
        }
    }

    func updateCompletionDate() {
        if viewModel.goal.timeRequired != 0, viewModel.goal.atLeastOneDayWorking {
            completionDate = viewModel.goal.updatedCompletionDate
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
