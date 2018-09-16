//
//  MovieCell.swift
//  moviesapp
//
//  Created by Marco Marques on 04/05/18.
//  Copyright © 2018 Emerson Batista. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    lazy var thumbMovie: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var loading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(movie: Movie) {
        guard let imagePath = movie.poster_path else { return }
        self.loading.startAnimating()
        guard let url = URL(string: "\(TheMovieDBEndPoint.popular(page: 0).baseImg)\(imagePath)") else {
            self.loading.stopAnimating()
            return
        }
        self.thumbMovie.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (_, _, _, _) in
            self.loading.stopAnimating()
        }
    }
}

extension MovieCell: ViewCode {
   
    func buildViewHierarchy() {
        addSubview(thumbMovie)
        addSubview(loading)
    }
    
    func setupConstraints() {
        thumbMovie.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
        }
        
        loading.snp.makeConstraints { make in
            make.width.equalTo(self.snp.width)
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func setupAdditionalConfiguration() {
        thumbMovie.contentMode = UIViewContentMode.scaleToFill
        thumbMovie.backgroundColor = .clear
        loading.backgroundColor = .lightGray

    }
}
