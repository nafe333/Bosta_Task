//
//  AppDelegate.swift
//  BostaTask
//
//  Created by Nafea Elkassas on 03/03/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
                let mainNavigationController = UINavigationController(rootViewController: ProfileViewController())
                window.rootViewController = mainNavigationController
                window.makeKeyAndVisible()
                
                self.window = window
        return true
    }
}

