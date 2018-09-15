//
//  TheMovieDBEndPoint.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 15/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation
enum TheMovieDBEndPoint {
    case popular
    case genres
    case search(nameMovie: String)
}

extension TheMovieDBEndPoint: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org"
    }
    
    var query: String? {
        switch self {
        case .search(let movieName):
            return "\(movieName)"
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .popular:
            return "/3/movie/popular"
        case .genres:
            return "/3/genre/movie/list"
        case .search:
            return "/3/search/movie"
            
        }
    }
}
