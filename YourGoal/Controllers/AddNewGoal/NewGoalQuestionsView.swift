//
//  AddNewGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

public class NewGoalQuestionsViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var isColorsVisible = false
    @Published var isIconsVisible = false
    @Published var showSmartExplanation = false
    @Published var showErrorAlert = false

    var isNewGoal: Bool

    init(goal: Goal, isNewGoal: Bool) {
        self.goal = goal
        self.isNewGoal = isNewGoal
    }

}

private extension CGFloat {

    static let hoursFieldsHeight: CGFloat = 85
    static let pickerViewWidth: CGFloat = 40 // it's actually height, because it's rotated 90º

}

struct NewGoalQuestionsView: View {

    @ObservedObject var viewModel: NewGoalQuestionsViewModel
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
            ZStack {
                Form {
                    if !viewModel.goal.goalType.isHabit {
                        Section(header: Text("add_goal_type_title").applyFont(.fieldQuestion)) {
                            TypeSelectorView(viewModel: .init(goal: $viewModel.goal))
                        }
                        .textCase(nil)
                        .buttonStyle(PlainButtonStyle())
                        .listRowBackground(Color.defaultBackground)
                        .foregroundColor(.fieldsTitleForegroundColor)
                    }

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

                    Section(header: Text("add_goal_customize_title").applyFont(.fieldQuestion)) {
                        VStack {
                            HStack(spacing: 15) {
                                Text("\("global_color".localized()):")
                                    .applyFont(.small)
                                Button(action: {
                                    viewModel.isColorsVisible = true
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
                                }.accentColor(viewModel.goal.goalColor)

                                Spacer()

                                Text("\("global_icon".localized()):")
                                    .applyFont(.small)
                                Button(action: {
                                    viewModel.isIconsVisible = true
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: .defaultRadius)
                                            .fill(Color.fieldsBackground)
                                            .aspectRatio(1.0, contentMode: .fit)
                                        Image(viewModel.goal.goalIcon)
                                            .resizable()
                                            .aspectRatio(1.0, contentMode: .fit)
                                            .frame(width: 35)
                                    }
                                    .clipped()
                                }.accentColor(viewModel.goal.goalColor)
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

                    Section {
                        Button(action: {
                            if !(viewModel.goal.name?.isEmpty ?? true) {
                                viewModel.goal = viewModel.goal
                                storeNewGoal()
                            } else {
                                viewModel.showErrorAlert = true
                            }
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
                        }.buttonStyle(PlainButtonStyle())
                        .accentColor(viewModel.goal.goalColor)
                        .alert(isPresented: $viewModel.showErrorAlert) {
                            Alert(title: Text("global_wait"),
                                  message: Text("add_goal_missing_name"),
                                  dismissButton: .default(Text("global_got_it")))
                        }
                    }
                    .padding([.bottom], 5)
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.defaultBackground)
                }.listStyle(SidebarListStyle())

                if viewModel.isColorsVisible {
                    ColorSelectorView(viewModel: .init(goal: $viewModel.goal),
                                      isPresented: $viewModel.isColorsVisible)
                }

                if viewModel.isIconsVisible {
                    IconSelectorView(viewModel: .init(goal: $viewModel.goal),
                                     isPresented: $viewModel.isIconsVisible)
                }
            }
            .navigationBarTitle("SMART Goal", displayMode: .inline)
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

    func storeNewGoal() {
        if viewModel.goal.isValid {
            viewModel.goal.editedAt = Date()
            if viewModel.isNewGoal {
                viewModel.goal.completionDateExtimated = viewModel.goal.updatedCompletionDate
                viewModel.goal.timesHasBeenTracked = 0
                viewModel.goal.createdAt = Date()
                FirebaseService.logConversion(.goalCreated, goal: viewModel.goal)
            }
            PersistenceController.shared.saveContext()
            self.activeSheet = nil
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
