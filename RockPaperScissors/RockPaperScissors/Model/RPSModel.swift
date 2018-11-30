//
//  RPSModel.swift
//  RockPaperScissors
//
//  Created by Tuan Nguyen on 11/29/18.
//  Copyright © 2018 Tuan Nguyen. All rights reserved.
//

import UIKit

enum Hand: Int {
    case rock = 0
    case paper = 1
    case scissors = 2
}

enum Result {
    case win
    case loose
    case draw
}

class RPSModel {
    static let shared = RPSModel()
    
    private init() {
    }
    
    final func compare(_ first: Hand, to second: Hand) -> Result {
        if first.rawValue == second.rawValue {
            return Result.draw
        }
        else if first.rawValue == second.rawValue + 1 {
            return Result.win
        }
        else if first.rawValue == second.rawValue - 1 {
            return Result.loose
        }
        else {
            // Rock vs Scissors
            if first == Hand.rock {
                return Result.win
            }
            else {
                return Result.loose
            }
        }
    }
    
    final func getHand(byValue value: Int) -> Hand {
        switch value {
        case 0:
            return Hand.rock
        case 1:
            return Hand.paper
        case 2:
            return Hand.scissors
        default:
            return Hand.rock
        }
    }
    
    final func getRandomHand() -> Hand {
        let value = Int(arc4random_uniform(3))
        return getHand(byValue: value)
    }
}

