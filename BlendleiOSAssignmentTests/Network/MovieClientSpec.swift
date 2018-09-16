//
//  MovieClientSpec.swift
//  moviesappTests
//
//  Created by matheus.v.sousa on 5/16/18.
//  Copyright © 2018 Emerson Batista. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import BlendleiOSAssignment

class MovieClientSpec: QuickSpec {
    override func spec() {
        
        var session: URLSessionMock!
        var sut: MovieClient!
        var endpoint: TheMovieDBEndPoint!
        
        
        describe("the MovieClient") {
            
            beforeEach {
                endpoint = .popular(page: 1)
                session = URLSessionMock()
                session.data = self.loadJson(fromFileName: "popularMovies")
                session.error = nil
                session.response = HTTPURLResponse(url: endpoint.request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
                sut = MovieClient(session: session)
            }
            
            describe("when initialized") {
                it("should have set a non nil session") {
                    expect(sut.session).toNot(beNil())
                }
            }
            
            describe("when requested to get popular movies results") {
                var movies: Any!
                
                beforeEach {
                    sut.getMovies(from: TheMovieDBEndPoint.popular(page: 1), completion: { (response) in
                        switch response {
                        case .success(let result):
                            movies = result
                        case .failure(_):
                            break
                        }
                    })
                }
                
                it("should return non nil results") {
                    expect(movies).toEventuallyNot(beNil())
                }
                
                it("should return results on movies correct type") {
                    expect(movies).toEventually(beAKindOf(MovieFeedResult.self))
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
