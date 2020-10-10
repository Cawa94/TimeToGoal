//
//  BackgroundView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 10/10/2020.
//

import SwiftUI

struct BackgroundView<Content: View>: View {

    private var color: UIColor
    private var content: Content

    init(color: UIColor, @ViewBuilder content: @escaping () -> Content) {
        self.color = color
        self.content = content()
    }

    @ViewBuilder
    var body: some View {
        Color(self.color)
            .ignoresSafeArea()
            .overlay(content)
    }

}
