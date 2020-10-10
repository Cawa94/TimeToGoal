//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

public class ContentViewViewModel: ObservableObject {

    @Binding var currentGoal: Goal?

    init(goal: Binding<Goal?>) {
        self._currentGoal = goal
    }

    func updateView(){
        self.objectWillChange.send()
    }

}

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    var mainGoalViewModel = MainGoalViewModel()

    @ViewBuilder
    var body: some View {
        //TabView {
            MainGoalView(viewModel: mainGoalViewModel)
        /*.tabItem {
                Image.init(systemName: "house.fill")
                Text("Obiettivi")
            }.tag(1)

            Image(systemName: "person.circle.fill").font(.largeTitle)
                .tabItem {
                    Image.init(systemName: "person.circle.fill")
                    Text("Calendario")
                }.tag(2)
        }.accentColor(.goalColor)
            .colorScheme(.dark)
            .ignoresSafeArea()
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.pageBackground
                UITableView.appearance().sectionIndexBackgroundColor = UIColor.pageBackground
                UITableView.appearance().sectionIndexColor = UIColor.pageBackground
            })*/
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext,
                                  PersistenceController.shared.container.viewContext)
    }
}
