//
//  ViewController.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 07/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainViewScreen()
    var movieDatasource: MainviewDatasource?

    override func loadView() {
        self.view = mainView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("You should't use storyboard in this app")
    }
    
    override func viewDidLoad() {
        self.setupDatasourceAndDelegates()
        self.requestMovies()
        self.title = "Movies"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieDatasource?.reloadCollection()
    }
    
    func requestMovies() {
        self.movieDatasource?.requestMovies()
    }
    
    func setupDatasourceAndDelegates() {
        self.movieDatasource = MainviewDatasource(listMovies: [], collectionView: mainView.collectionView)
    }
}

