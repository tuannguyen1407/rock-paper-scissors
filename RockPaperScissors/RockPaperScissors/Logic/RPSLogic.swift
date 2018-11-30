//
//  RPSLogic.swift
//  RockPaperScissors
//
//  Created by Tuan Nguyen on 11/29/18.
//  Copyright © 2018 Tuan Nguyen. All rights reserved.
//

import UIKit

class RPSLogic {
    static let winText = "You Win!"
    static let looseText = "You Loose!"
    static let drawText = "Draw!"
    
    static let winColor = UIColor.green
    static let drawColor = UIColor.cyan
    static let looseColor = UIColor.red
    
    private var animationEnabled = true
    
    var rpsView: RPSView
    
    init(rpsView: RPSView) {
        self.rpsView = rpsView
    }
    
    final func enableAnimation() {
        animationEnabled = true
    }
    
    final func disableAnimation() {
        animationEnabled = false
    }
    
    private final func getPlayerImage(forHand hand: Hand) -> UIImage {
        switch hand {
        case .rock: return #imageLiteral(resourceName: "my_rock")
        case .paper: return #imageLiteral(resourceName: "my_paper")
        case .scissors: return #imageLiteral(resourceName: "my_scissors")
        }
    }
    
    private final func getOpponentImage(forHand hand: Hand) -> UIImage {
        switch hand {
        case .rock: return #imageLiteral(resourceName: "opponent_rock")
        case .paper: return #imageLiteral(resourceName: "opponent_paper")
        case .scissors: return #imageLiteral(resourceName: "opponent_scissors")
        }
    }
    
    private final func getText(forResult result: Result) -> String {
        switch result {
        case .win: return RPSLogic.winText
        case .draw: return RPSLogic.drawText
        case .loose: return RPSLogic.looseText
        }
    }
    
    private final func getTextColor(forResult result: Result) -> UIColor {
        switch result {
        case .win: return RPSLogic.winColor
        case .draw: return RPSLogic.drawColor
        case .loose: return RPSLogic.looseColor
        }
    }
    
    final func updateRPSGameView(withPlayerHand playerHand: Hand) {
        let opponentHand = RPSModel.shared.getRandomHand()
        let matchResult = RPSModel.shared.compare(playerHand, to: opponentHand)
        
        let playerImage = getPlayerImage(forHand: playerHand)
        let opponentImage = getOpponentImage(forHand: opponentHand)
        
        let resultText = getText(forResult: matchResult)
        let resultTextColor = getTextColor(forResult: matchResult)
        
        if animationEnabled {
            rpsView.animateResult(playerImage: playerImage, opponentImage: opponentImage, resultText: resultText, resultColor: resultTextColor, countDownTime: 3)
        }
        else {
            rpsView.displayResult(playerImage: playerImage, opponentImage: opponentImage, resultText: resultText, resultColor: resultTextColor)
        }
    }
}
