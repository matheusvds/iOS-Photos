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
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.minimumLineSpacing = 15
        return flowLayout
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainViewScreen: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(self.collectionView)
    }
    
    func setupConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .gray
        self.collectionView.backgroundColor = .yellow
    }
    
    
}
