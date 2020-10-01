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

    @State var showingAddNewGoal = false

    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goal.createdAt, ascending: true)
        ]
    ) var goals: FetchedResults<Goal>

    @State var currentGoal: Goal?

    var body: some View {
        TabView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HorizontalCalendarView()

                    Spacer()

                    GoalProgressView(goal: $currentGoal).padding(15.0)

                    Text(currentGoal?.name ?? "Sconosciuto")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Spacer(minLength: 50)

                    Button(action: {
                        self.showingAddNewGoal.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.rectangle.fill")
                                .foregroundColor(.green)
                        }
                        .padding(15.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                        )
                    }.accentColor(.green)
                    .sheet(isPresented: $showingAddNewGoal, onDismiss: {
                        currentGoal = goals.last
                    }) {
                        AddNewGoalView(isPresented: $showingAddNewGoal)
                            .environment(\.managedObjectContext,
                                         PersistenceController.shared.container.viewContext)
                    }

                    Spacer(minLength: 20)
                }
            }.tabItem {
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
        }.accentColor(.green)
            .colorScheme(.dark)
            .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            currentGoal = goals.last
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().sectionIndexBackgroundColor = .clear
            UITableView.appearance().sectionIndexColor = .clear
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
