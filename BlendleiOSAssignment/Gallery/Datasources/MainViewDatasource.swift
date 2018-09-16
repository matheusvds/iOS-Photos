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
    var page: Int = 1
    
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
        movieClient.getMovies(from: .popular(page: page)) { results in
            switch results {
            case .success(let result):
                guard let popularMovies = result?.results else { return }
                self.setMovies(movies: popularMovies)
                self.page += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
//MARK: - CollectionView Datasource
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
//MARK: - CollectionView DelegateFlowLayout
extension MainviewDatasource:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width / 3.1
        let height = UIScreen.main.bounds.height / 4
        
        return CGSize(width: width, height: height);
    }
}
extension MainviewDatasource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.listMovies.count - 1 {
            requestMovies()
        }
    }
}
