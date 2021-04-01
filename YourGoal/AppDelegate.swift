//
//  AppDelegate.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 29/10/2020.
//

import Foundation
import UIKit
import Firebase
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate {

    static var needScreenshots = false

    var window: UIWindow?

    lazy var appWindow: UIWindow = {
        return window ?? UIWindow(frame: UIScreen.main.bounds) // To avoid optional appWindow
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        #if RELEASE
            ApplicationDelegate.initializeSDK(nil)
            if FirebaseApp.app() == nil { // To avoid Firebase being initialised multiple times
                FirebaseApp.configure()
            }
        #else
            //FirebaseApp.configure()
        #endif

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app,
                                               open: url,
                                               sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                               annotation: options[UIApplication.OpenURLOptionsKey.annotation])

    }

}
