//
//  APIClientSpec.swift
//  moviesappTests
//
//  Created by matheus.v.sousa on 5/8/18.
//  Copyright © 2018 Emerson Batista. All rights reserved.
//
import Foundation
import Quick
import Nimble

@testable import BlendleiOSAssignment

class APIClientSpec: QuickSpec {
    
    override func spec() {
       
        var session: URLSessionMock!
        var endpoint: TheMovieDBEndPoint!
        var sut: MovieClient!
        
        describe("the 'APIClient'") {
            var result: MovieFeedResult!
            var sessionError: APIError!
            
            beforeEach {
                endpoint = .popular(page: 1)
                session = URLSessionMock()
                session.data = self.loadJson(fromFileName: "popularMovies")
                session.error = nil
                session.response = HTTPURLResponse(url: endpoint.request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
                sut = MovieClient(session: session)
            }
            
            describe("when fetching data") {
                
                beforeEach {
                    sut.fetch(with: endpoint.request, decode: { (json) -> MovieFeedResult? in
                        return nil
                    }, completion: { (result) in
                        switch result {
                        case .success(_):
                            break
                        case .failure(let error):
                            sessionError = error as! APIError
                        }
                    })
                }
            }
            
            describe("when decoding task") {
                
                describe("when receive the expected parameters") {
                    
                    beforeEach {
                        _ = sut.decodingTask(with: endpoint.request, decodingType: MovieFeedResult.self, completionHandler: { (response) in
                            switch response {
                            case .success(let movies):
                                result = movies
                            case .failure(let error):
                                sessionError = error as! APIError
                            }
                        }).resume()
                    }
                    
                    it("should return a MovieFeedResult") {
                        expect(result).toEventuallyNot(beNil())
                    }
                }
                
                describe("when response is nil") {
                    
                    beforeEach {
                        session.response = nil
                    }
                    
                    beforeEach {
                        _ = sut.decodingTask(with: endpoint.request, decodingType: MovieFeedResult.self, completionHandler: { (response) in
                            switch response {
                            case .success(let movies):
                                result = movies
                            case .failure(let error):
                                sessionError = error as! APIError
                            }
                        }).resume()
                    }
                    
                    it("should return request fail api error") {
                        expect(sessionError == .requestFailed).toEventually(beTrue())
                    }
                }
                
                describe("when decoding invalid format") {
                    
                    beforeEach {
                        _ = sut.decodingTask(with: endpoint.request, decodingType: Data.self, completionHandler: { (response) in
                            switch response {
                            case .success(_):
                                break
                            case .failure(let error):
                                sessionError = error as! APIError
                            }
                        }).resume()
                    }
                    
                    it("should return request fail api error") {
                        expect(sessionError == .jsonConversionFailure).toEventually(beTrue())
                    }
                }
                
                describe("when received data is nil") {
            
                    beforeEach {
                        session.data = nil
                    }
                    
                    beforeEach {
                        _ = sut.decodingTask(with: endpoint.request, decodingType: MovieFeedResult.self, completionHandler: { (response) in
                            switch response {
                            case .success(let movies):
                                result = movies
                            case .failure(let error):
                                sessionError = error as! APIError
                            }
                        }).resume()
                    }
                    
                    it("should return request fail api error") {
                        expect(sessionError == .invalidData).toEventually(beTrue())
                    }
                }
                
                describe("when response code is not 200") {
                    
                    beforeEach {
                        session.response = HTTPURLResponse(url: endpoint.request.url!, statusCode: 0, httpVersion: nil, headerFields: nil)
                    }
                    
                    beforeEach {
                        _ = sut.decodingTask(with: endpoint.request, decodingType: MovieFeedResult.self, completionHandler: { (response) in
                            switch response {
                            case .success(let movies):
                                result = movies
                            case .failure(let error):
                                sessionError = error as! APIError
                            }
                        }).resume()
                    }
                    
                    it("should return request fail api error") {
                        expect(sessionError == .responseUnsuccessful).toEventually(beTrue())
                    }
                }
            }
        }
    }
    
    func loadJson(fromFileName fileName: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let filePath = bundle.path(forResource: fileName, ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
    }
}

