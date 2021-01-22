//
//  AddNewGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

public class AddNewGoalViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var showSmartExplanation = false
    @Published var showSecondView = false
    @Published var showErrorAlert = false

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

        BackgroundView(color: .defaultBackground) {
            NavigationView {
                ZStack {
                    NavigationLink(destination: AddNewGoalSecondView(viewModel: .init(goal: viewModel.goal,
                                                                                      isNew: viewModel.isNewGoal),
                                                                     activeSheet: $activeSheet,
                                                                     isPresented: $viewModel.showSecondView,
                                                                     isAllFormPresented: $isPresented),
                                   isActive: $viewModel.showSecondView) {
                        EmptyView()
                    }

                    Form {
                        Section(header: Text("add_goal_type_title").applyFont(.fieldQuestion)) {
                            TypeSelectorView(viewModel: .init(goal: $viewModel.goal))
                        }
                        .textCase(nil)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text("goal_name_question").applyFont(.fieldQuestion)) {
                            VStack {
                                TextField("", text: nameBinding)
                                    .padding()
                                    .foregroundColor(.fieldsTextForegroundColor)
                                    .background(Color.fieldsBackground)
                                    .cornerRadius(.defaultRadius)
                                    .disableAutocorrection(true)
                                Spacer()
                                    .frame(height: 7)
                            }
                        }
                        .textCase(nil)
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.mainQuestion).applyFont(.fieldQuestion)) {
                            VStack {
                                ZStack {
                                    TextEditor(text: whatBinding)
                                        .padding()
                                        .foregroundColor(.fieldsTextForegroundColor)
                                        .background(Color.fieldsBackground)
                                        .cornerRadius(.defaultRadius)
                                        .disableAutocorrection(true)
                                        .applyFont(.body)
                                    Text(whatBinding.wrappedValue).opacity(0).padding(.all, 8).applyFont(.body)
                                }
                                Spacer()
                                    .frame(height: 7)
                            }
                        }
                        .textCase(nil)
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.whyQuestion).applyFont(.fieldQuestion)) {
                            VStack {
                                ZStack {
                                    TextEditor(text: whyBinding)
                                        .padding()
                                        .foregroundColor(.fieldsTextForegroundColor)
                                        .background(Color.fieldsBackground)
                                        .cornerRadius(.defaultRadius)
                                        .disableAutocorrection(true)
                                        .applyFont(.body)
                                    Text(whyBinding.wrappedValue).opacity(0).padding(.all, 8).applyFont(.body)
                                }
                                Spacer()
                                    .frame(height: 7)
                            }
                        }
                        .textCase(nil)
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.whatWillChangeQuestion).applyFont(.fieldQuestion)) {
                            VStack {
                                ZStack {
                                    TextEditor(text: whatChangeBinding)
                                        .padding()
                                        .foregroundColor(.fieldsTextForegroundColor)
                                        .background(Color.fieldsBackground)
                                        .cornerRadius(.defaultRadius)
                                        .disableAutocorrection(true)
                                        .applyFont(.body)
                                    Text(whatChangeBinding.wrappedValue).opacity(0).padding(.all, 8).applyFont(.body)
                                }
                                Spacer()
                                    .frame(height: 7)
                            }
                        }
                        .textCase(nil)
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section(header: Text(viewModel.goal.goalType.supportQuestion).applyFont(.fieldQuestion)) {
                            VStack {
                                ZStack {
                                    TextEditor(text: supportBinding)
                                        .padding()
                                        .foregroundColor(.fieldsTextForegroundColor)
                                        .background(Color.fieldsBackground)
                                        .cornerRadius(.defaultRadius)
                                        .disableAutocorrection(true)
                                        .applyFont(.body)
                                    Text(supportBinding.wrappedValue).opacity(0).padding(.all, 8).applyFont(.body)
                                }
                                Spacer()
                                    .frame(height: 7)
                            }
                        }
                        .textCase(nil)
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)

                        Section {
                            Button(action: {
                                if !(viewModel.goal.name?.isEmpty ?? true) {
                                    viewModel.goal = viewModel.goal
                                    viewModel.showSecondView.toggle()
                                } else {
                                    viewModel.showErrorAlert.toggle()
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
                            }.buttonStyle(PlainButtonStyle())
                            .accentColor(viewModel.goal.goalColor)
                            .alert(isPresented: $viewModel.showErrorAlert) {
                                Alert(title: Text("global_wait"),
                                      message: Text("add_goal_missing_name"),
                                      dismissButton: .default(Text("global_got_it")))
                            }
                        }.navigationBarTitle(viewModel.showSecondView ? "" : viewModel.goal.goalType.title, displayMode: .large)
                        .navigationBarItems(trailing: closeButton)
                        .padding([.bottom], 5)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.defaultBackground)
                    }.listStyle(SidebarListStyle())
                }.navigationBarTitle(viewModel.showSecondView ? "" : viewModel.goal.goalType.title, displayMode: .large)
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
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
