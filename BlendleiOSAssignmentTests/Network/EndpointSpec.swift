//
//  EndpointSpec.swift
//  moviesappTests
//
//  Created by matheus.v.sousa on 5/8/18.
//  Copyright © 2018 Emerson Batista. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import BlendleiOSAssignment

class EndpointSpec: QuickSpec {
    override func spec() {
        describe("TheMovieDBAPI Endpoint") {
            
            context("when endpoint is choosen"){
               var sut: TheMovieDBEndPoint!
                
                beforeEach {
                    sut = .popular(page: 1)
                }
                
                it("should return the correct endpoint for popular movies") {
                    expect(sut.path).to(equal("/movie/popular?api_key=780517cdd65386623d21c096f42be2ba&page=1"))
                }
                
                it("should use the correct api key") {
                    expect(sut.apiKey).to(equal("780517cdd65386623d21c096f42be2ba"))
                }
                
                it("should have the correct base path") {
                    expect(sut.base).to(equal("https://api.themoviedb.org/3"))
                }
                
                it("should have the correct base image path") {
                    expect(sut.baseImg).to(equal("https://image.tmdb.org/t/p/w300"))
                }
                
                it("should have a non nil request") {
                    expect(sut.request).toNot(beNil())
                }
                
                it("should have a non nil url") {
                    expect(sut.request.url).toNot(beNil())
                }
            }
        }
    }
}
