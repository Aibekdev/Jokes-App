//
//  AppDelegate.swift
//  Jokes App
//
//  Created by Aibek on 26.09.2022.
//

import UIKit

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = OnboardingScreenNavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}

