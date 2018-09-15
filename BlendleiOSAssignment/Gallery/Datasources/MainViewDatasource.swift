//
//  MainViewDatasource.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 15/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import UIKit

class MainviewDatasource: NSObject {
    
    var listMovies: [Movie]
    var collectionView: UICollectionView
    var movieClient: BaseClient
    
    init(listMovies: [Movie], collectionView: UICollectionView, client: BaseClient = MovieClient()) {
        self.movieClient = client
        self.listMovies = listMovies
        self.collectionView = collectionView
        super.init()
        self.registerCell()
        self.setupCollectionView()
        
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func registerCell() {
        self.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: Constants.CellIdentifier.movieCellIdentifier)
    }
    
    func setMovies(movies: [Movie]) {
        self.listMovies.append(contentsOf: movies)
        reloadCollection()
    }
    
    func requestMovies() {
        movieClient.getMovies(from: .popular(page: 1)) { results in
            switch results {
            case .success(let result):
                guard let popularMovies = result?.results else { return }
                self.setMovies(movies: popularMovies)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MainviewDatasource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.movieCellIdentifier, for: indexPath) as? MovieCell {
            myCell.fill(movie: self.listMovies[indexPath.row])
            return myCell
        }
        
        return UICollectionViewCell()
    }
}

extension MainviewDatasource:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 3.1
        let height = UIScreen.main.bounds.height / 4
        
        return CGSize(width: width, height: height);
    }
}
