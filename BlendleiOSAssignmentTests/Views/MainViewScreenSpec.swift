//
//  BlendleiOSAssignmentTests.swift
//  BlendleiOSAssignmentTests
//
//  Created by Matheus Vasconcelos on 07/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import BlendleiOSAssignment

class MainViewScreenSpec: QuickSpec {
    
    var sut: MainViewScreen!
    
    override func spec() {
        
        describe("The MainViewScreen UI") {
            
            beforeEach {
                let frame = UIScreen.main.bounds
                self.sut = MainViewScreen(frame: frame)
            }
            
            it("need to have the look and feel") {
                expect(self.sut) == snapshot("mainViewScreen")
            }
        }
    }
    
}
