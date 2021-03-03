//
//  MainGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI
import StoreKit

private extension CGFloat {

    static let circleWidth: CGFloat = 30
    static let circleSize: CGFloat = 225

}

public class MainGoalViewModel: ObservableObject {

    @Published var goal: Goal
    @Published var challenges: [Challenge]
    @Published var showingEditGoal = false
    @Published var showWarningAlert = false

    @Binding var isPresented: Bool
    @Binding var activeSheet: ActiveSheet?
    @Binding var refreshAllGoals: Bool
    @Binding var selectedIndex: Int?
    @Binding var goals: [Goal]

    init(goal: Goal, goals: Binding<[Goal]>, challenges: [Challenge], isPresented: Binding<Bool>,
         activeSheet: Binding<ActiveSheet?>, refreshAllGoals: Binding<Bool>, selectedIndex: Binding<Int?>) {
        self.goal = goal
        self.challenges = challenges
        self._isPresented = isPresented
        self._activeSheet = activeSheet
        self._refreshAllGoals = refreshAllGoals
        self._selectedIndex = selectedIndex
        self._goals = goals
    }

    var isCompleted: Bool {
        return goal.isCompleted
    }

    var timeRemaining: String {
        if goal.timeTrackingType == .hoursWithMinutes {
            let dateRemaining = Double(goal.timeRequired).asHoursAndMinutes
                .remove(Double(goal.timeCompleted).asHoursAndMinutes)
            if dateRemaining > Date().zeroHours {
                return dateRemaining.formattedAsHoursString
            } else {
                return "0"
            }
        } else {
            let timeRemaining = Double(goal.timeRequired) - Double(goal.timeCompleted)
            if timeRemaining > 0 {
                return goal.timeTrackingType == .double
                    ? "\(timeRemaining.stringWithTwoDecimals)" : "\(timeRemaining.stringWithoutDecimals)"
            } else {
                return "0"
            }
        }
    }

    var completionDate: String {
        return (goal.updatedCompletionDate).formattedAsDateString
    }

}

struct MainGoalView: View {

    @ObservedObject var viewModel: MainGoalViewModel
    @State private var feedback = UINotificationFeedbackGenerator()

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { container in
                ZStack {
                    Color.defaultBackground

                    ScrollView {
                        VStack(spacing: 0) {
                            Spacer()
                                .frame(height: 35)

                            ZStack {
                                Circle().strokeBorder(AngularGradient(
                                                        gradient: Gradient(colors: viewModel.goal.circleGradientColors),
                                                        center: .center,
                                                        startAngle: .degrees(0),
                                                        endAngle: .degrees(360)),
                                                      lineWidth: .circleWidth)
                                    .shadow(color: .black, radius: 5, x: 5, y: 5)
                                    .opacity(0.3)
                                    .padding(-(CGFloat.circleWidth/2))

                                Circle()
                                    .strokeBorder(AngularGradient(
                                                    gradient: Gradient(colors: viewModel.goal.circleGradientColors),
                                                    center: .center,
                                                    startAngle: .degrees(0),
                                                    endAngle: .degrees(360)),
                                                  lineWidth: .circleWidth)
                                    .mask(Circle()
                                            .trim(from: 0.0,
                                                  to: CGFloat(min(Double((viewModel.goal.timeCompleted) / (viewModel.goal.timeRequired)), 1.0)))
                                            .stroke(style: StrokeStyle(lineWidth: .circleWidth, lineCap: .round, lineJoin: .round))
                                            .padding(CGFloat.circleWidth/2)
                                    )
                                    .rotationEffect(Angle(degrees: 270))
                                    .padding(-(CGFloat.circleWidth/2))

                                VStack(spacing: 10) {
                                    Image(viewModel.goal.goalIcon)
                                        .resizable()
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(width: 70)

                                    Text(String(format: "main_time_required".localized(),
                                                viewModel.timeRemaining, viewModel.goal.customTimeMeasure ?? ""))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.grayText)
                                        .applyFont(.title)
                                }
                            }
                            .frame(width: .circleSize, height: .circleSize)

                            Spacer()
                                .frame(height: 40)

                            answersSummaryFirstPart

                            answersSummarySecondPart

                            Spacer()
                                .frame(height: 25)

                            HStack(spacing: 10) {
                                archiveGoalButton

                                deleteGoalButton
                            }

                            Spacer()
                                .frame(height: 40)
                        }.padding([.leading, .trailing], 15)
                    }

                }.navigationBarTitle(viewModel.goal.name ?? "", displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                    Button(action: {
                        self.viewModel.isPresented = false
                    }) {
                        Image(systemName: "chevron.left")
                }, trailing: editButton)
            }
        }.fullScreenCover(isPresented: $viewModel.showingEditGoal, content: {
            NavigationView {
                NewGoalTimeView(viewModel: .init(goal: viewModel.goal,
                                                 challenges: viewModel.challenges,
                                                 isNew: false),
                                activeSheet: $viewModel.activeSheet,
                                isPresented: $viewModel.showingEditGoal)
            }
        })
    }

    var answersSummaryFirstPart: some View {
        VStack(spacing: 10) {
            HStack {
                Text("goal_custom_main_question")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayLight)
                    .applyFont(.title3)
                Spacer()
            }

            HStack {
                Text(viewModel.goal.whatDefinition ?? "Non definito")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayText)
                    .applyFont(.title3)
                Spacer()
            }

            Spacer()
                .frame(height: 0)

            HStack {
                Text("goal_custom_why_question")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayLight)
                    .applyFont(.title3)
                Spacer()
            }

            HStack {
                Text(viewModel.goal.whyDefinition ?? "Non definito")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayText)
                    .applyFont(.title3)
                Spacer()
            }
        }
    }

    var answersSummarySecondPart: some View {
        VStack(spacing: 10) {
            Spacer()
                .frame(height: 0)

            HStack {
                Text("goal_custom_what_change_question")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayLight)
                    .applyFont(.title3)
                Spacer()
            }

            HStack {
                Text(viewModel.goal.whatWillChangeDefinition ?? "Non definito")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayText)
                    .applyFont(.title3)
                Spacer()
            }

            Spacer()
                .frame(height: 0)

            HStack {
                Text("goal_custom_support_question")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayLight)
                    .applyFont(.title3)
                Spacer()
            }

            HStack {
                Text(viewModel.goal.supportDefinition ?? "Non definito")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.grayText)
                    .applyFont(.title3)
                Spacer()
            }
        }
    }

    var archiveGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.goal.isArchived = viewModel.goal.isArchived ? false : true
                viewModel.refreshAllGoals = true
                PersistenceController.shared.saveContext()
                viewModel.isPresented = false
            }) {
                HStack {
                    Spacer()
                    Text(viewModel.goal.isArchived ? "Riattiva" : "global_archive")
                        .foregroundColor(viewModel.goal.goalColor)
                        .applyFont(.button)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(viewModel.goal.goalColor)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(viewModel.goal.goalColor)
        }
    }

    var deleteGoalButton: some View {
        HStack {
            Button(action: {
                viewModel.showWarningAlert = true
            }) {
                HStack {
                    Spacer()
                    Text("Cancella")
                        .foregroundColor(viewModel.goal.goalColor)
                        .applyFont(.button)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding([.top, .bottom], 15)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(viewModel.goal.goalColor)
                        .shadow(color: .blackShadow, radius: 5, x: 5, y: 5)
                )
            }.accentColor(viewModel.goal.goalColor)
            .alert(isPresented: $viewModel.showWarningAlert) {
                Alert(title: Text("ASPETTA"),
                      message: Text("Sei sicuro di voler cancellare quest'obiettivo o abitudine?"),
                      primaryButton: .destructive(Text("Cancella")) {
                        viewModel.selectedIndex = nil
                        viewModel.goals.removeAll(where: { $0.id == viewModel.goal.id })
                        PersistenceController.shared.container.viewContext.delete(viewModel.goal)
                        PersistenceController.shared.saveContext()
                        viewModel.refreshAllGoals = true
                        viewModel.isPresented = false
                      },
                      secondaryButton: .cancel())
            }
        }
    }

    var editButton: some View {
        Button(action: {
            if !viewModel.goal.isArchived {
                viewModel.showingEditGoal = true
            }
        }) {
            if !viewModel.goal.isArchived {
                Text("Modifica")
                    .foregroundColor(.grayText)
                    .applyFont(.title4)
            }
        }
    }

}
/*
struct MainGoalView_Previews: PreviewProvider {
    static var previews: some View {
        MainGoalView(viewModel: .init(goal: .constant(Goal())))
    }
}
*/
