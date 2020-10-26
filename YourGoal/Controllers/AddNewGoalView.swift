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

    var colors = ["orangeGoal", "yellowGoal", "greenGoal",
                  "blueGoal", "purpleGoal", "grayGoal"]

    init(existingGoal: Goal? = nil) {
        self.isNewGoal = existingGoal == nil

        if let existingGoal = existingGoal {
            goal = existingGoal
        } else {
            goal = Goal(context: PersistenceController.shared.container.viewContext)
            goal.color = UserDefaults.standard.goalColor ?? "orangeGoal"
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
        })

        let timeRequiredBinding = Binding<String>(get: {
            return viewModel.goal.timeRequired.stringWithoutDecimals == "0" ? "" : viewModel.goal.timeRequired.stringWithoutDecimals
        }, set: {
            viewModel.goal.timeRequired = Double($0) ?? 0
            updateCompletionDate()
        })

        let mondayBinding = Binding<String>(get: {
            return "\(viewModel.goal.mondayHours)"
        }, set: {
            viewModel.goal.mondayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        let tuesdayBinding = Binding<String>(get: {
            "\(viewModel.goal.tuesdayHours)"
        }, set: {
            viewModel.goal.tuesdayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        let wednesdayBinding = Binding<String>(get: {
            "\(viewModel.goal.wednesdayHours)"
        }, set: {
            viewModel.goal.wednesdayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        let thursdayBinding = Binding<String>(get: {
            "\(viewModel.goal.thursdayHours)"
        }, set: {
            viewModel.goal.thursdayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        let fridayBinding = Binding<String>(get: {
            "\(viewModel.goal.fridayHours)"
        }, set: {
            viewModel.goal.fridayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        let saturdayBinding = Binding<String>(get: {
            "\(viewModel.goal.saturdayHours)"
        }, set: {
            viewModel.goal.saturdayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        let sundayBinding = Binding<String>(get: {
            "\(viewModel.goal.sundayHours)"
        }, set: {
            viewModel.goal.sundayHours = Double($0) ?? 0
            updateCompletionDate()
        })

        BackgroundView(color: .pageBackground) {
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("add_goal_name_title".localized())) {
                            TextField("", text: nameBinding)
                                .padding()
                                .foregroundColor(.fieldsTextForegroundColor)
                                .background(Color.grayFields)
                                .cornerRadius(.defaultRadius)
                        }
                        .listRowBackground(Color.pageBackground)
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
                                        viewModel.isColorsVisible.toggle()
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
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
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
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("add_goal_extimated_date_title".localized())) {
                            VStack {
                                Text(completionDate.formattedAsDateString)
                                    .font(.largeTitle)
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(.goalColor)
                                Text(String(format: "add_goal_days_required".localized(),
                                            "\(viewModel.goal.daysRequired)"))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color.clear)
                                    .foregroundColor(.goalColor)
                            }
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section {
                            Button(action: {
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
                            }.accentColor(.goalColor)
                        }
                        .padding([.bottom], 5)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
                    }
                    if viewModel.isColorsVisible {
                        colorsView
                    }
                }.navigationBarTitle("global_new_goal".localized(), displayMode: .large)
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }

    func storeNewGoal() {
        if viewModel.goal.isValid {
            viewModel.goal.createdAt = Date()
            PersistenceController.shared.saveContext()
            self.isPresented = false
        }
    }

    func updateCompletionDate() {
        if viewModel.goal.timeRequired != 0, viewModel.goal.atLeastOneDayWorking {
            completionDate = viewModel.goal.updatedCompletionDate
            viewModel.goal.completionDateExtimated = viewModel.goal.updatedCompletionDate
        }
    }

    var colorsView: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .onTapGesture {
                    viewModel.isColorsVisible.toggle()
                }
            GeometryReader { container in
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
                                    ForEach(viewModel.colors.prefix(3), id: \.self) { color in
                                        Button(action: {
                                            Color.goalColor = Color(color)
                                            UIColor.goalColor = UIColor(named: color) ?? .goalColor
                                            UserDefaults.standard.goalColor = color
                                            viewModel.goal.color = color
                                            viewModel.isColorsVisible.toggle()
                                        }) {
                                            Circle()
                                                .fill(Color(color))
                                                .aspectRatio(1.0, contentMode: .fit)
                                        }
                                    }
                                }.frame(height: 55)
                                .buttonStyle(PlainButtonStyle())
                                Spacer()
                                HStack(spacing: 20) {
                                    ForEach(viewModel.colors.suffix(3), id: \.self) { color in
                                        Button(action: {
                                            Color.goalColor = Color(color)
                                            UIColor.goalColor = UIColor(named: color) ?? .goalColor
                                            UserDefaults.standard.goalColor = color
                                            viewModel.goal.color = color
                                            viewModel.isColorsVisible.toggle()
                                        }) {
                                            Circle()
                                                .fill(Color(color))
                                                .aspectRatio(1.0, contentMode: .fit)
                                        }
                                    }
                                }.frame(height: 55)
                                .buttonStyle(PlainButtonStyle())
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
