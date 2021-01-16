//
//  BackgroundView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 10/10/2020.
//

import SwiftUI

struct BackgroundView<Content: View>: View {

    private var color: UIColor
    private var barTintColor: UIColor
    private var content: Content

    init(color: UIColor, barTintColor: UIColor = .goalColor, @ViewBuilder content: @escaping () -> Content) {
        self.color = color
        self.barTintColor = barTintColor
        self.content = content()
    }

    @ViewBuilder
    var body: some View {
        Color(self.color)
            .ignoresSafeArea()
            .overlay(content.onAppear(perform: {
                UINavigationBar.appearance().barTintColor = self.color
                UINavigationBar.appearance().tintColor = .black
                UINavigationBar.appearance().backgroundColor = self.color
                UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
                UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
                UINavigationBar.appearance().isTranslucent = false
                UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

                UITableView.appearance().backgroundColor = self.color
                UITableView.appearance().sectionIndexBackgroundColor = self.color
                UITableView.appearance().sectionIndexColor = self.color
                UITableView.appearance().separatorStyle = .none
            }))
    }

}
