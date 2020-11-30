//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

public class ContentViewModel: ObservableObject {

    @Published var goals: [Goal] = []
    @Published var activeSheet: ActiveSheet? = UserDefaults.standard.showTutorial ?? true ? .tutorial : nil
    @Published var refreshAllGoals = false
    @Published var goalsModels: [MainGoalViewModel] = []

}

struct ContentView: View {

    @ObservedObject var viewModel = ContentViewModel()

    static var showedQuote = false

    var goalsRequest: FetchRequest<Goal>
    var goals: FetchedResults<Goal> { goalsRequest.wrappedValue }

    init() {
        self.goalsRequest = FetchRequest(
            entity: Goal.entity(),
            sortDescriptors: [
                NSSortDescriptor(keyPath: \Goal.editedAt, ascending: false)
            ]
        )
    }

    @ViewBuilder
    var body: some View {
        TabView {
            ForEach(0...(viewModel.goalsModels.count), id: \.self) { index in
                if index < viewModel.goalsModels.count {
                    let model = viewModel.goalsModels[index]
                    MainGoalView(viewModel: model)
                } else {
                    MainGoalView(viewModel: .init(goal: nil,
                                                  isFirstGoal: viewModel.goals.isEmpty,
                                                  activeSheet: $viewModel.activeSheet,
                                                  refreshAllGoals: $viewModel.refreshAllGoals))
                }
            }
        }
        .id(viewModel.goals.count)
        .edgesIgnoringSafeArea(.all)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .colorScheme(.light)
        .onAppear(perform: {
            viewModel.refreshAllGoals = true
        })
        .onReceive(viewModel.$refreshAllGoals, perform: {
            if $0 {
                viewModel.goals = goals.filter { $0.isValid && !$0.isArchived }
                viewModel.goalsModels = viewModel.goals.map {
                    let goal = $0
                    let model = MainGoalViewModel(goal: goal,
                                                  isFirstGoal: viewModel.goals.isEmpty,
                                                  activeSheet: $viewModel.activeSheet,
                                                  refreshAllGoals: $viewModel.refreshAllGoals)
                    model.goal = goal
                    return model
                }
                viewModel.refreshAllGoals = false
            }
        })
        .sheet(item: $viewModel.activeSheet, onDismiss: {
            UserDefaults.standard.showTutorial = false
            for invalidGoal in goals.filter({ !$0.isValid }) {
                PersistenceController.shared.container.viewContext.delete(invalidGoal)
            }
            PersistenceController.shared.saveContext()
            viewModel.refreshAllGoals = true
        }, content: { item in
            switch item {
            case .tutorial:
                TutorialView(activeSheet: $viewModel.activeSheet)
            case .newGoal:
                AddNewGoalView(viewModel: .init(),
                               activeSheet: $viewModel.activeSheet,
                               isPresented: .constant(true))
            }
        })
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension AnyTransition {
    static var fly: AnyTransition { get {
        AnyTransition.modifier(active: FlyTransition(pct: 0), identity: FlyTransition(pct: 1))
        }
    }
}

struct FlyTransition: GeometryEffect {
    var pct: Double
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {

        let rotationPercent = pct
        let a = CGFloat(Angle(degrees: 90 * (1-rotationPercent)).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, 1, 0, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform1 = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        let affineTransform2 = ProjectionTransform(CGAffineTransform(scaleX: CGFloat(pct * 2), y: CGFloat(pct * 2)))
        
        if pct <= 0.5 {
            return ProjectionTransform(transform3d).concatenating(affineTransform2).concatenating(affineTransform1)
        } else {
            return ProjectionTransform(transform3d).concatenating(affineTransform1)
        }
    }
}
