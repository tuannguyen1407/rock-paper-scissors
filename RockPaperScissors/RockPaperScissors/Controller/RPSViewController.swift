//
//  RPSViewController.swift
//  RockPaperScissors
//
//  Created by Tuan Nguyen on 11/29/18.
//  Copyright © 2018 Tuan Nguyen. All rights reserved.
//

import UIKit

class RPSViewController: UIViewController {
    var rpsView: RPSView!
    var rpsLogic: RPSLogic!

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rpsView = RPSView()
        view = rpsView
        rpsView.rpsViewDelegate = self
        
        rpsLogic = RPSLogic(rpsView: rpsView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - RPSViewDelegate
extension RPSViewController: RPSViewDelegate {
    func rpsView(_ rpsView: RPSView, didPlayHand: Hand) {
        if rpsView == self.rpsView {
            displayGameResult(withPlayerHand: didPlayHand)
        }
    }
    
    private final func displayGameResult(withPlayerHand hand: Hand) {
        rpsLogic.updateRPSGameView(withPlayerHand: hand)
    }
}

