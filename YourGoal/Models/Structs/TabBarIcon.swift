//
//  CustomTabView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/1/21.
//

import SwiftUI

class ViewRouter: ObservableObject {

    @Published var currentPage: Page = .home

}

struct TabBarIcon: View {

    @StateObject var viewRouter: ViewRouter
    @State private var pressed = false

    let assignedPage: Page
    let width, height: CGFloat
    let iconName: String

    var body: some View {
        Image(viewRouter.currentPage == assignedPage ? iconName : "\(iconName)_off")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35, height: 35)
            .padding(.bottom, 25)
            .scaleEffect(pressed ? 0.8 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.easeInOut(duration: 0.2)) {
                pressed = pressing
            }
            viewRouter.currentPage = assignedPage
        }, perform: {})
    }

 }
