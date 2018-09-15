//
//  MoviesClient.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 15/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

protocol BaseClient: APIClient {
    func getMovies(from movieFeedType: TheMovieDBEndPoint, completion: @escaping (Result<MovieFeedResult?>) -> Void)
}

class MovieClient: BaseClient {

    var session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    convenience init() {
        self.init(session: .shared)
    }

    func getMovies(from endpoint: TheMovieDBEndPoint, completion: @escaping (Result<MovieFeedResult?>) -> Void) {
        fetch(with: endpoint.request, decode: { (json) -> MovieFeedResult? in
            guard let movieFeedResult = json as? MovieFeedResult else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}
