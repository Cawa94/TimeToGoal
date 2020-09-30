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
    @State var progressValue: CGFloat = 0.4

    var body: some View {
        TabView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HorizontalCalendarView()

                    Spacer()

                    GoalProgressView(progress: progressValue).padding(15.0)

                    Text("Leggi Shantaram")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Spacer(minLength: 50)

                    Button(action: {
                        self.showingAddNewGoal.toggle()
                    }) {
                        HStack {
                            Image(systemName: "plus.rectangle.fill").foregroundColor(.green)
                        }
                        .padding(15.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                        )
                    }.accentColor(.green)
                    .sheet(isPresented: $showingAddNewGoal) {
                        AddNewGoalView()
                    }

                    Spacer()
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
                    Text("Settimana")
                }.tag(3)
        }.accentColor(.red)
            .colorScheme(.light)
            .edgesIgnoringSafeArea(.top)
    }

    func incrementProgress() {
        let randomValue = CGFloat([0.012, 0.022, 0.034, 0.016, 0.11].randomElement()!)
        self.progressValue += randomValue
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
