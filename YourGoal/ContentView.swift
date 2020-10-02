//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goal.createdAt, ascending: true)
        ]
    ) var goals: FetchedResults<Goal>

    @State var showingAddNewGoal = false
    @State var currentGoal: Goal?

    var body: some View {
        TabView {
            VStack {
                TrackGoalView(currentGoal: $currentGoal)
                Button(action: {
                    self.showingAddNewGoal.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.rectangle.fill")
                            .foregroundColor(.goalColor)
                    }
                    .padding(15.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15.0)
                            .stroke(lineWidth: 2.0)
                    )
                }.accentColor(.goalColor)
                .sheet(isPresented: $showingAddNewGoal, onDismiss: {
                    currentGoal = goals.last
                }) {
                    AddNewGoalView(isPresented: $showingAddNewGoal)
                        .environment(\.managedObjectContext,
                                     PersistenceController.shared.container.viewContext)
                }

                Spacer(minLength: 20)
            }.background(Color.pageBackground)
            .onAppear(perform: {
                currentGoal = goals.last
            })
            .tabItem {
                Image.init(systemName: "house.fill")
                Text("Obiettivi")
            }.tag(1)

            Image(systemName: "person.circle.fill").font(.largeTitle)
                .tabItem {
                    Image.init(systemName: "person.circle.fill")
                    Text("Statistiche")
                }.tag(2)

            Image(systemName: "magnifyingglass").font(.largeTitle)
                .tabItem {
                    Image.init(systemName: "magnifyingglass")
                    Text("Calendario")
                }.tag(3)
        }.accentColor(.goalColor)
            .colorScheme(.dark)
            .edgesIgnoringSafeArea(.top)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.pageBackground
                UITableView.appearance().sectionIndexBackgroundColor = UIColor.pageBackground
                UITableView.appearance().sectionIndexColor = UIColor.pageBackground
            })
    }

    func updateGoal() {
        guard let currentGoal = self.currentGoal
            else { return }
        currentGoal.timeRequired = 4
        PersistenceController.shared.saveContext()
    }

    func deleteGoal() {
        guard let currentGoal = self.currentGoal
            else { return }
        viewContext.delete(currentGoal)
        PersistenceController.shared.saveContext()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext,
                                  PersistenceController.shared.container.viewContext)
    }
}
