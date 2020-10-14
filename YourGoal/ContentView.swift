//
//  ContentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 28/09/2020.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var mainGoalViewModel = MainGoalViewModel()

    @ViewBuilder
    var body: some View {
        //TabView {
            MainGoalView()
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
        ContentView()
    }
}
