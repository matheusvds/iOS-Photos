//
//  TabBarController.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 09/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    init(imageCollectionController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        setupTabBarItems(imageCollectionController)
        setupAppearance()
        self.viewControllers = [imageCollectionController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBarItems(_ imageCollectionController: UIViewController) {
        imageCollectionController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
    }
    
    private func setupAppearance() {
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = .black
    }
}
