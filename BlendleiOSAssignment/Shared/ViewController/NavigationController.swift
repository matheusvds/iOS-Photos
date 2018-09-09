//
//  NavigationController.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 09/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = .black
    }
}
