//
//  TheMovieDBEndPoint.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 15/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

enum TheMovieDBEndPoint {
    case popular(page: Int)
}

extension TheMovieDBEndPoint: Endpoint {
    
    var base: String {
        return "https://api.themoviedb.org/3"
    }
    
    var baseImg: String {
        return "https://image.tmdb.org/t/p/w300"
    }
    
    var query: String? {
        switch self {
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .popular(let page):
            return "/movie/popular?api_key=\(apiKey)&page=\(page)"
        }
    }
}
