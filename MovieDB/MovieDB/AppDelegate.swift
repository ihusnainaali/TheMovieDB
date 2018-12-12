//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Christos Home on 03/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController(rootViewController: SplashViewController())
        navigationController.navigationBar.barTintColor = .darkGreen
        navigationController.navigationBar.tintColor = .white
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -200, vertical: 0), for:.default)
        window?.rootViewController = navigationController
        
        return true
    }
}

