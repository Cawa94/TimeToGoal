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
    @Published var showSmartExplanation = false
    @Published var showSecondView = false
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
    @Binding var activeSheet: ActiveSheet?
    @Binding var isPresented: Bool

    @State var completionDate = Date()

    @ViewBuilder
    var body: some View {
        let nameBinding = Binding<String>(get: {
            "\(viewModel.goal.name ?? "")"
        }, set: {
            viewModel.goal.name = String($0.prefix(50))
            viewModel.goal = viewModel.goal // Used to constantly refresh the page and adjust heights
        })

        let whatBinding = Binding<String>(get: {
            "\(viewModel.goal.whatDefinition ?? " ")" // Empty space to fix TextEditor height issue
        }, set: {
            viewModel.goal.whatDefinition = $0.dropFirstSpace()
            viewModel.goal = viewModel.goal
        })

        let whyBinding = Binding<String>(get: {
            "\(viewModel.goal.whyDefinition ?? " ")"
        }, set: {
            viewModel.goal.whyDefinition = $0.dropFirstSpace()
            viewModel.goal = viewModel.goal
        })

        let whatChangeBinding = Binding<String>(get: {
            "\(viewModel.goal.whatWillChangeDefinition ?? " ")"
        }, set: {
            viewModel.goal.whatWillChangeDefinition = $0.dropFirstSpace()
            viewModel.goal = viewModel.goal
        })

        let supportBinding = Binding<String>(get: {
            "\(viewModel.goal.supportDefinition ?? " ")"
        }, set: {
            viewModel.goal.supportDefinition = $0.dropFirstSpace()
            viewModel.goal = viewModel.goal
        })

        BackgroundView(color: .pageBackground) {
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("add_goal_type_title")) {
                            TypeSelectorView(viewModel: .init(goal: $viewModel.goal))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("goal_name_question")) {
                            TextField("", text: nameBinding)
                                .padding()
                                .foregroundColor(.fieldsTextForegroundColor)
                                .background(Color.grayFields)
                                .cornerRadius(.defaultRadius)
                                .disableAutocorrection(true)
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.mainQuestion)) {
                            ZStack {
                                TextEditor(text: whatBinding)
                                    .padding()
                                    .foregroundColor(.fieldsTextForegroundColor)
                                    .background(Color.grayFields)
                                    .cornerRadius(.defaultRadius)
                                    .disableAutocorrection(true)
                                Text(whatBinding.wrappedValue).opacity(0).padding(.all, 8)
                            }
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.whyQuestion)) {
                            ZStack {
                                TextEditor(text: whyBinding)
                                    .padding()
                                    .foregroundColor(.fieldsTextForegroundColor)
                                    .background(Color.grayFields)
                                    .cornerRadius(.defaultRadius)
                                    .disableAutocorrection(true)
                                Text(whyBinding.wrappedValue).opacity(0).padding(.all, 8)
                            }
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.whatWillChangeQuestion)) {
                            ZStack {
                                TextEditor(text: whatChangeBinding)
                                    .padding()
                                    .foregroundColor(.fieldsTextForegroundColor)
                                    .background(Color.grayFields)
                                    .cornerRadius(.defaultRadius)
                                    .disableAutocorrection(true)
                                Text(whatChangeBinding.wrappedValue).opacity(0).padding(.all, 8)
                            }
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.supportQuestion)) {
                            ZStack {
                                TextEditor(text: supportBinding)
                                    .padding()
                                    .foregroundColor(.fieldsTextForegroundColor)
                                    .background(Color.grayFields)
                                    .cornerRadius(.defaultRadius)
                                    .disableAutocorrection(true)
                                Text(supportBinding.wrappedValue).opacity(0).padding(.all, 8)
                            }
                        }
                        .listRowBackground(Color.pageBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section {
                            NavigationLink(destination: AddNewGoalSecondView(viewModel: .init(goal: viewModel.goal,
                                                                                              isNew: viewModel.isNewGoal),
                                                                             activeSheet: $activeSheet,
                                                                             //isPresented: $viewModel.showSecondView,
                                                                             isAllFormPresented: $isPresented),
                                           isActive: $viewModel.showSecondView) {
                                Button(action: {
                                    viewModel.goal = viewModel.goal
                                    viewModel.showSecondView.toggle()
                                }) {
                                    HStack {
                                        Spacer()
                                        Text("global_next")
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
                                }.buttonStyle(PlainButtonStyle())
                                .accentColor(viewModel.goal.goalColor)
                            }.navigationBarTitle(viewModel.showSecondView ? "" : viewModel.goal.goalType.title, displayMode: .large)
                        }
                        .padding([.bottom], 5)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.pageBackground)
                    }
                }.navigationBarTitle(viewModel.showSecondView ? "" : viewModel.goal.goalType.title, displayMode: .large)
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
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

private extension String {
    
    func dropFirstSpace() -> String {
        var newValue = self
        if newValue.first == " " {
            newValue = String(newValue.dropFirst())
        }
        return newValue
    }

}
