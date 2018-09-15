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
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        let searchQuery = URLQueryItem(name: "query", value: query)
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems = [apiQuery, searchQuery]
        components.queryItems = components.queryItems?.filter { $0.value != nil }
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
