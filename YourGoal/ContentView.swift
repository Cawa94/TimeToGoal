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

    @FetchRequest(
        entity: Goal.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goal.createdAt, ascending: true)
        ]
    ) var goals: FetchedResults<Goal>

    @State var showingTrackGoal = false
    @State var showingAddNewGoal = false

    @State var currentGoal: Goal? {
        didSet{
            mainGoalViewModel.goal = currentGoal
        }
    }

    var mainGoalViewModel = MainGoalViewModel()

    @ViewBuilder
    var body: some View {
        TabView {
            VStack {
                MainGoalView(viewModel: mainGoalViewModel)
                HStack {
                    Spacer()
                    trackTimeButton
                        .frame(maxWidth: .infinity)
                    newGoalButton
                        .frame(maxWidth: .infinity)
                    Spacer()
                }

                Spacer(minLength: 40)
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
                    Text("Calendario")
                }.tag(2)
        }.accentColor(.goalColor)
            .colorScheme(.dark)
            .ignoresSafeArea()
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = UIColor.pageBackground
                UITableView.appearance().sectionIndexBackgroundColor = UIColor.pageBackground
                UITableView.appearance().sectionIndexColor = UIColor.pageBackground
            })
    }

    var trackTimeButton: some View {
        HStack {
            Button(action: {
                self.showingTrackGoal.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.rectangle.fill").foregroundColor(.goalColor)
                    Text("Traccia progressi").bold().foregroundColor(.goalColor)
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                )
            }.accentColor(.goalColor)
            .sheet(isPresented: $showingTrackGoal, onDismiss: {
                currentGoal = currentGoal
            }, content: {
                TrackHoursSpentView(isPresented: $showingTrackGoal, currentGoal: $currentGoal)
                    .environment(\.managedObjectContext,
                                 PersistenceController.shared.container.viewContext)
            })
        }
    }

    var newGoalButton: some View {
        HStack {
            Button(action: {
                self.showingAddNewGoal.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.rectangle.fill").foregroundColor(.goalColor)
                    Text("Nuovo obiettivo").bold().foregroundColor(.goalColor)
                }
                .padding(15.0)
                .overlay(
                    RoundedRectangle(cornerRadius: .defaultRadius)
                        .stroke(lineWidth: 2.0)
                        .foregroundColor(.goalColor)
                )
            }.accentColor(.goalColor)
            .sheet(isPresented: $showingAddNewGoal, onDismiss: {
                currentGoal = goals.last
            }, content: {
                AddNewGoalView(isPresented: $showingAddNewGoal)
                    .environment(\.managedObjectContext,
                                 PersistenceController.shared.container.viewContext)
            })
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext,
                                  PersistenceController.shared.container.viewContext)
    }
}
