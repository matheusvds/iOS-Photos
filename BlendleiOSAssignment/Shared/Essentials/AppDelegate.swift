//
//  AppDelegate.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 07/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainViewController = MainViewController()
        let collectionNavigationController = NavigationController(rootViewController: mainViewController)
        
        let tabBarController = TabBarController(imageCollectionController: collectionNavigationController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = tabBarController
        self.window = window
        
        window.makeKeyAndVisible()
        return true
    }

}

