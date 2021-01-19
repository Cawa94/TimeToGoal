//
//  AppDelegate.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/10/2020.
//

import Foundation
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

    var window: UIWindow?

    lazy var appWindow: UIWindow = {
        return window ?? UIWindow(frame: UIScreen.main.bounds) // To avoid optional appWindow
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if RELEASE
            FirebaseApp.configure()
        #else
            //FirebaseApp.configure()
        #endif
        return true
    }

}
