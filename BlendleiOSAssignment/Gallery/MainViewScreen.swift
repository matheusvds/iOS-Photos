//
//  MainViewScreen.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 07/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit
import SnapKit

final class MainViewScreen: UIView {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainViewScreen: ViewCode {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .gray
    }
    
    
}
