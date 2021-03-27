//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

enum Page {
    case goals
    case journal
    case home
    case statistics
    case profile
}

public class ContentViewModel: ObservableObject {

    @Published var goals: [Goal] = []
    @Published var journal: [JournalPage] = []
    @Published var profile: Profile?
    @Published var challenges: [Challenge] = []
    @Published var activeSheet: ActiveSheet? = UserDefaults.standard.showTutorial ?? true && !AppDelegate.needScreenshots ? .tutorial : nil
    @Published var refreshAllGoals = false
    @Published var refreshJournal = false
    @Published var refreshChallenges = false
    @Published var currentPage: Page = .home
    @Published var goalsButtonPressed = false // to animate button on tap
    @Published var goalToRenew: Goal? // to animate button on tap

}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()
    @StateObject var viewRouter = ViewRouter()

    static var firstOpen = true
    static var showedQuote = false

    var goalsRequest: FetchRequest<Goal>
    var goals: FetchedResults<Goal> { goalsRequest.wrappedValue }

    var journalRequest: FetchRequest<JournalPage>
    var journal: FetchedResults<JournalPage> { journalRequest.wrappedValue }

    var profileRequest: FetchRequest<Profile>
    var profile: FetchedResults<Profile> { profileRequest.wrappedValue }

    var challengesRequest: FetchRequest<Challenge>
    var challenges: FetchedResults<Challenge> { challengesRequest.wrappedValue }

    init() {
        self.goalsRequest = FetchRequest(
            entity: Goal.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Goal.editedAt, ascending: false)
            ]
        )

        self.journalRequest = FetchRequest(
            entity: JournalPage.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \JournalPage.date, ascending: false)
            ]
        )

        self.profileRequest = FetchRequest(
            entity: Profile.entity(),
            sortDescriptors: []
        )

        self.challengesRequest = FetchRequest(
            entity: Challenge.entity(),
            sortDescriptors: []
        )

        if AppDelegate.needScreenshots {
            fakeInfosForScreenshots()
        }
    }

    @ViewBuilder
    var body: some View {
        BackgroundView(color: .defaultBackground) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    switch viewRouter.currentPage {
                    case .goals:
                        AllGoalsView(viewModel: .init(goals: viewModel.goals,
                                                      challenges: viewModel.challenges,
                                                      refreshAllGoals: $viewModel.refreshAllGoals,
                                                      activeSheet: $viewModel.activeSheet))
                            .onDisappear(perform: {
                                viewModel.refreshChallenges = true
                            })
                    case .journal:
                        JournalView(viewModel: .init(journal: viewModel.journal,
                                                     challenges: viewModel.challenges))
                            .onDisappear(perform: {
                                viewModel.refreshJournal = true
                                viewModel.refreshChallenges = true
                            })
                    case .home:
                        HomeView(viewModel: .init(goals: viewModel.goals,
                                                  journal: viewModel.journal,
                                                  challenges: viewModel.challenges,
                                                  profile: viewModel.profile,
                                                  activeSheet: $viewModel.activeSheet,
                                                  goalToRenew: $viewModel.goalToRenew))
                            .onDisappear(perform: {
                                viewModel.refreshChallenges = true
                            })
                    case .statistics:
                        StatisticsView(viewModel: .init(goals: viewModel.goals,
                                                        challenges: viewModel.challenges))
                            .onDisappear(perform: {
                                viewModel.refreshChallenges = true
                            })
                    case .profile:
                        ProfileView(viewModel: .init(profile: viewModel.profile,
                                                     challenges: viewModel.challenges,
                                                     refreshchallenges: $viewModel.refreshChallenges))
                            .onDisappear(perform: {
                                setChallengesHaveBounced()
                            })
                    }
                    HStack(spacing: 35) {
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .goals,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "home")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .journal,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "journal")
                        ZStack {
                            Circle()
                                .foregroundColor(.defaultBackground)
                                .frame(width: geometry.size.width/6, height: geometry.size.width/6)
                                .shadow(radius: 2)
                            Image(viewRouter.currentPage == .home ? "goals" : "goals_off")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width/6-20 , height: geometry.size.width/6-20)
                        }.offset(y: -geometry.size.height/6/4)
                        .scaleEffect(viewModel.goalsButtonPressed ? 0.8 : 1.0)
                        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                viewModel.goalsButtonPressed = pressing
                            }
                            viewRouter.currentPage = .home
                        }, perform: {})
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .statistics,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "statistics")
                        TabBarIcon(viewRouter: viewRouter, assignedPage: .profile,
                                   width: geometry.size.width/5, height: geometry.size.height/28,
                                   iconName: "\(viewModel.profile?.image ?? "man_0")_border")
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/8)
                    .background(Color.defaultBackground.shadow(radius: 1))
                }
             }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            viewModel.refreshAllGoals = true
            viewModel.refreshJournal = true
            viewModel.refreshChallenges = true
            viewModel.profile = profile.map { $0 }.first
        })
        .onReceive(viewModel.$refreshAllGoals, perform: {
            if $0 {
                viewModel.goals = goals.filter { $0.isValid }
                if ContentView.firstOpen && (Date().isMonday || Date().monthDay == 1) {
                    checkAndRestartHabits()
                    ContentView.firstOpen = false
                }
                viewModel.refreshAllGoals = false
            }
        })
        .onReceive(viewModel.$refreshJournal, perform: {
            if $0 {
                viewModel.journal = journal.map { $0 }
                viewModel.refreshJournal = false
            }
        })
        .onReceive(viewModel.$refreshChallenges, perform: {
            if $0 {
                viewModel.challenges = challenges.map { $0 }
                viewModel.refreshChallenges = false
            }
        })
        .fullScreenCover(item: $viewModel.activeSheet, onDismiss: {
            UserDefaults.standard.showTutorial = false
            for invalidGoal in goals.filter({ !$0.isValid }) {
                PersistenceController.shared.container.viewContext.delete(invalidGoal)
            }
            PersistenceController.shared.saveContext()
            viewModel.refreshAllGoals = true
            viewModel.refreshChallenges = true
        }, content: { item in
            switch item {
            case .tutorial:
                TutorialView(viewModel: .init(tutorialType: .introduction), isPresented: .constant(false), activeSheet: $viewModel.activeSheet)
            case .newGoal:
                NewGoalFirstView(viewModel: .init(challenges: viewModel.challenges), activeSheet: $viewModel.activeSheet)
            }
        })
    }

    func setChallengesHaveBounced() {
        for challenge in viewModel.challenges {
            if challenge.isCompleted && !challenge.hasBounced {
                challenge.hasBounced = true
            }
        }
        PersistenceController.shared.saveContext()
    }

    func checkAndRestartHabits() {
        for goal in viewModel.goals.filter({ $0.goalType.isHabit }) {
            if goal.timeFrameType == .weekly,
               Date().isMonday,
               !(goal.progress?.compactMap({ $0 as? Progress }).contains(where: { $0.date?.withoutHours == Date().withoutHours }) ?? false) { // it's monday and user didn't already tracked today
                goal.timeCompleted = 0
                goal.completedAt = nil
            }
            if goal.timeFrameType == .monthly,
               Date().monthDay == 1,
               !(goal.progress?.compactMap({ $0 as? Progress }).contains(where: { $0.date?.withoutHours == Date().withoutHours }) ?? false) { // it's first month day and user didn't already tracked today
                goal.timeCompleted = 0
                goal.completedAt = nil
            }
        }
    }

    func fakeInfosForScreenshots() {
        UserDefaults.standard.showTutorial = false

        let firstGoal = Goal(context: PersistenceController.shared.container.viewContext)
        firstGoal.color = "purpleGoal"
        firstGoal.name = "screenshots_first_goal_name".localized()
        firstGoal.goalType = .init(id: 7, label: "excercise", name: "habit_excercise_name", image: "exercise_17",
                                   categoryId: [0], measureUnits: [.session, .hour], ofGoalSentence: "habit_excercise_goal_sentence")
        firstGoal.timeRequired = 3
        firstGoal.customTimeMeasure = "measure_unit_session".localized()
        firstGoal.timeFrame = "weekly"
        firstGoal.monday = 1
        firstGoal.wednesday = 1
        firstGoal.friday = 1
        firstGoal.whyDefinition = "screenshots_first_goal_why".localized()
        firstGoal.completionDateExtimated = firstGoal.updatedCompletionDate
        firstGoal.createdAt = Date().adding(days: -120)

        createGoalProgressFor(goal: firstGoal)


        let secondGoal = Goal(context: PersistenceController.shared.container.viewContext)
        secondGoal.color = "greenGoal"
        secondGoal.name = "screenshots_second_goal_name".localized()
        secondGoal.goalType = .init(id: 52, label: "plan_day", name: "habit_plan_day_name", image: "write_5",
                                    categoryId: [1, 3], measureUnits: [.singleTime], timeSentence: "habit_plan_day_time_sentence")
        secondGoal.timeRequired = 20
        secondGoal.customTimeMeasure = "measure_unit_single_time".localized()
        secondGoal.timeFrame = "monthly"
        secondGoal.monday = 1
        secondGoal.tuesday = 1
        secondGoal.wednesday = 1
        secondGoal.thursday = 1
        secondGoal.friday = 1
        secondGoal.whyDefinition = "screenshots_second_goal_why".localized()
        secondGoal.completionDateExtimated = secondGoal.updatedCompletionDate
        secondGoal.createdAt = Date().adding(days: -120)

        createGoalProgressFor(goal: secondGoal)


        let thirdGoal = Goal(context: PersistenceController.shared.container.viewContext)
        thirdGoal.color = "blueGoal"
        thirdGoal.name = "screenshots_third_goal_name".localized()
        thirdGoal.goalType = .init(id: 5, label: "reading", name: "habit_reading_name", image: "book_2",
                                   categoryId: [1, 3], measureUnits: [.session, .page, .hour], ofGoalSentence: "habit_reading_goal_sentence", timeSentence: "habit_reading_time_sentence")
        thirdGoal.timeRequired = 4
        thirdGoal.customTimeMeasure = "measure_unit_hour".localized()
        thirdGoal.timeFrame = "weekly"
        thirdGoal.thursday = 1
        thirdGoal.friday = 1
        thirdGoal.saturday = 1
        thirdGoal.sunday = 1
        thirdGoal.whyDefinition = "screenshots_third_goal_why".localized()
        thirdGoal.completionDateExtimated = thirdGoal.updatedCompletionDate
        thirdGoal.createdAt = Date().adding(days: -120)

        createGoalProgressFor(goal: thirdGoal)



        let fourthGoal = Goal(context: PersistenceController.shared.container.viewContext)
        fourthGoal.color = "orangeGoal"
        fourthGoal.name = "screenshots_fourth_goal_name".localized()
        fourthGoal.goalType = .init(id: 27, label: "journal", name: "habit_journal_name", image: "write_2",
                                    categoryId: [1, 3], measureUnits: [.session, .singleTime], ofGoalSentence: "habit_journal_goal_sentence", timeSentence: "habit_journal_time_sentence")
        fourthGoal.timeRequired = 7
        fourthGoal.customTimeMeasure = "measure_unit_single_time".localized()
        fourthGoal.timeFrame = "weekly"
        fourthGoal.monday = 1
        fourthGoal.tuesday = 1
        fourthGoal.wednesday = 1
        fourthGoal.thursday = 1
        fourthGoal.friday = 1
        fourthGoal.saturday = 1
        fourthGoal.sunday = 1
        fourthGoal.whyDefinition = "screenshots_fourth_goal_why".localized()
        fourthGoal.completionDateExtimated = fourthGoal.updatedCompletionDate
        fourthGoal.createdAt = Date().adding(days: -120)

        createGoalProgressFor(goal: fourthGoal)



        addFakeJournalPages()
        addFakeChallenges()
        addFakeProfileInfo()

        PersistenceController.shared.saveContext()
    }

    func createGoalProgressFor(goal: Goal) {
        let startDate = Date().adding(days: -120)
        let endDate = Date()
        let datesInterval = DateInterval(start: startDate, end: endDate)
        let calendar = Calendar.current
        let days = calendar.generateDates(
            inside: datesInterval,
            matching: DateComponents(hour: 1, minute: 1, second: 0)
        )

        for date in days where goal.workOn(date: date) {
            let progress = Progress(context: PersistenceController.shared.container.viewContext)
            progress.date = date
            if date.withoutHours == Date().adding(days: -1).withoutHours
                || date.withoutHours == Date().withoutHours {
                progress.hoursOfWork = 1
            } else {
                progress.hoursOfWork = Double(Array(0...1).randomElement() ?? 0)
            }
            progress.dayId = date.customId
            goal.addToProgress(progress)
        }
    }

    func addFakeJournalPages() {
        let firstPage = JournalPage(context: PersistenceController.shared.container.viewContext)
        firstPage.dayId = Date().customId
        firstPage.notes = "screenshots_journal_text".localized()
        firstPage.mood = "veryHappy"
        firstPage.date = Date()

        let secondPage = JournalPage(context: PersistenceController.shared.container.viewContext)
        secondPage.dayId = Date().adding(days: -1).customId
        secondPage.notes = "screenshots_journal_text".localized()
        secondPage.mood = "happy"
        secondPage.date = Date().adding(days: -1)

        let thirdPage = JournalPage(context: PersistenceController.shared.container.viewContext)
        thirdPage.dayId = Date().adding(days: -2).customId
        thirdPage.notes = "screenshots_journal_text".localized()
        thirdPage.mood = "normal"
        thirdPage.date = Date().adding(days: -2)

        let fourthPage = JournalPage(context: PersistenceController.shared.container.viewContext)
        fourthPage.dayId = Date().adding(days: -3).customId
        fourthPage.notes = "screenshots_journal_text".localized()
        fourthPage.mood = "happy"
        fourthPage.date = Date().adding(days: -3)
    }

    func addFakeChallenges() {
        let firstChallenge = Challenge(context: PersistenceController.shared.container.viewContext)
        firstChallenge.id = 8
        firstChallenge.progressMade = 30

        let secondChallenge = Challenge(context: PersistenceController.shared.container.viewContext)
        secondChallenge.id = 9
        secondChallenge.progressMade = 30

        let thirdChallenge = Challenge(context: PersistenceController.shared.container.viewContext)
        thirdChallenge.id = 10
        thirdChallenge.progressMade = 1

        let fourthChallenge = Challenge(context: PersistenceController.shared.container.viewContext)
        fourthChallenge.id = 11
        fourthChallenge.progressMade = 3

        let fifthChallenge = Challenge(context: PersistenceController.shared.container.viewContext)
        fifthChallenge.id = 12
        fifthChallenge.progressMade = 6
    }

    func addFakeProfileInfo() {
        let profile = Profile(context: PersistenceController.shared.container.viewContext)
        profile.created_at = Date()
        profile.name = "Yuri"
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
