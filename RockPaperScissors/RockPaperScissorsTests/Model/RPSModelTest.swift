//
//  RPSModelTest.swift
//  RockPaperScissorsTests
//
//  Created by Tuan Nguyen on 11/29/18.
//  Copyright © 2018 Tuan Nguyen. All rights reserved.
//

import XCTest

class RPSModelTest: XCTestCase {
    var rpsModel: RPSModel!
    
    override func setUp() {
        super.setUp()
        rpsModel = RPSModel.shared
    }
    
    override func tearDown() {
        rpsModel = nil
        super.tearDown()
    }
    
    func testCompareHand() {
        XCTAssert(rpsModel.compare(Hand.rock, to: Hand.paper) == Result.loose)
        XCTAssert(rpsModel.compare(Hand.paper, to: Hand.scissors) == Result.loose)
        XCTAssert(rpsModel.compare(Hand.scissors, to: Hand.rock) == Result.loose)
        
        XCTAssert(rpsModel.compare(Hand.rock, to: Hand.rock) == Result.draw)
        XCTAssert(rpsModel.compare(Hand.paper, to: Hand.paper) == Result.draw)
        XCTAssert(rpsModel.compare(Hand.scissors, to: Hand.scissors) == Result.draw)
        
        XCTAssert(rpsModel.compare(Hand.rock, to: Hand.scissors) == Result.win)
        XCTAssert(rpsModel.compare(Hand.paper, to: Hand.rock) == Result.win)
        XCTAssert(rpsModel.compare(Hand.scissors, to: Hand.paper) == Result.win)
    }
    
    func testGetHandByValue() {
        XCTAssert(Hand.rock == rpsModel.getHand(byValue: Hand.rock.rawValue))
        XCTAssert(Hand.rock == rpsModel.getHand(byValue: 0))
        
        XCTAssert(Hand.paper == rpsModel.getHand(byValue: Hand.paper.rawValue))
        XCTAssert(Hand.paper == rpsModel.getHand(byValue: 1))
        
        XCTAssert(Hand.scissors == rpsModel.getHand(byValue: Hand.scissors.rawValue))
        XCTAssert(Hand.scissors == rpsModel.getHand(byValue: 2))
        
        XCTAssert(Hand.rock == rpsModel.getHand(byValue: -1))
        XCTAssert(Hand.rock == rpsModel.getHand(byValue: 3))
    }
    
    func testGetRandomHand() {
        var result: [Int] = [0, 0, 0]
        for _ in 0...1000 {
            let handRawValue = rpsModel.getRandomHand().rawValue
            result[handRawValue] += 1
        }
        // getRandomHand() returns all 3 possible hands
        for index in 0..<result.count {
            XCTAssert(result[index] != 0)
        }
    }
}
