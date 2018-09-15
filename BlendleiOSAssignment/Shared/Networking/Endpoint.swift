//
//  Endpoint.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 11/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

protocol Endpoint {
    
    var base: String { get }
    var path: String { get }
    var query: String? { get }
}

extension Endpoint {
    
    var apiKey: String {
        return "780517cdd65386623d21c096f42be2ba"
    }
    
    var request: URLRequest {
        let url = URL(string: "\(base)\(path)")
        return URLRequest(url: url!)
    }
}

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
