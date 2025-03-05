//
//  AppDelegate.swift
//  Bosta Task
//
//  Created by Nafea Elkassas on 04/03/2025.
//

import UIKit
import Nuke

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

