//
//  HostingController.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 13/10/2020.
//

import SwiftUI

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
