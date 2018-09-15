//
//  APIClient.swift
//  BlendleiOSAssignment
//
//  Created by Matheus Vasconcelos on 15/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Foundation

protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T>) -> Void)
}

extension APIClient {
    
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, completionHandler completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(APIError.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(.success(genericModel))
                    } catch {
                        completion(.failure(APIError.jsonConversionFailure))
                    }
                } else {
                    completion(.failure(APIError.invalidData))
                }
            } else {
                completion(.failure(APIError.responseUnsuccessful))
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T>) -> Void) {
        
        let task = decodingTask(with: request, decodingType: T.self) { (result) in
            switch result {
            case .success(let json):
                guard let value = decode(json) else {
                    completion(.failure(APIError.jsonParsingFailure))
                    break
                }
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
