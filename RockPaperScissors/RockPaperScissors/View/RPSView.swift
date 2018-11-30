//
//  RPSView.swift
//  RockPaperScissors
//
//  Created by Tuan Nguyen on 11/29/18.
//  Copyright © 2018 Tuan Nguyen. All rights reserved.
//

import UIKit

class RPSView: UIView {
    static let rockText = "Rock"
    static let paperText = "Paper"
    static let scissorsText = "Scissors"
    
    static let startText = "Let's Start!"
    static let loadingText = "Thinking ..."
    
    static let defaultResultColor = UIColor.green
    static let defaultTextColor = UIColor.black
    static let defaultHighlightedTextColor = UIColor.cyan
    
    // MARK: - Labels, Buttons and ImageViews
    private var rockButton: UIButton = {
        let rockButton = UIButton()
        rockButton.setTitle(rockText, for: .normal)
        return rockButton
    }()
    
    private var paperButton: UIButton = {
        let paperButton = UIButton()
        paperButton.setTitle(paperText, for: .normal)
        return paperButton
    }()
    
    private var scissorsButton: UIButton = {
        let scissorsButton = UIButton()
        scissorsButton.setTitle(scissorsText, for: .normal)
        return scissorsButton
    }()
    
    var opponentImageView: UIImageView = {
        let opponentImageView = UIImageView(image: #imageLiteral(resourceName: "opponent_rock"))
        opponentImageView.contentMode = .scaleAspectFit
        return opponentImageView
    }()
    
    var resultLabel: UILabel = {
        let resultLabel = UILabel()
        return resultLabel
    }()
    
    var playerImageView: UIImageView = {
        let playerImageView = UIImageView(image: #imageLiteral(resourceName: "my_rock"))
        playerImageView.contentMode = .scaleAspectFit
        return playerImageView
    }()
    
    private static let textFont = UIFont.systemFont(ofSize: 20)
    private static let resultFont = UIFont.systemFont(ofSize: 30)
    
    // MARK: - GameView Delegate
    weak var rpsViewDelegate: RPSViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
        loadViews()
    }
    
    private final func loadViews() {
        addViews()
        layoutViews()
        
        backgroundColor = UIColor.white
        
        setMultiTouchEnabled(false)
        setExclusiveTouch(true)
        
        setButtonsStyles(forButtons: [rockButton, paperButton, scissorsButton])
        setLabelStyles(forLabels: [resultLabel])
        
        setButtonsActions()
    }
    
    private final func addViews() {
        addSubview(rockButton)
        addSubview(paperButton)
        addSubview(scissorsButton)
        
        addSubview(opponentImageView)
        addSubview(resultLabel)
        addSubview(playerImageView)    }
    
    private final func layoutViews() {
        let buttonHeight: CGFloat = 80
        let buttonSize = CGSize(width: 0, height: buttonHeight)
        
        let labelSize = CGSize(width: 200, height: 100)
        let imageViewSize = CGSize(width: 180, height: 180)
        
        let labelSpacing: CGFloat = 20
        
        rockButton.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, size: buttonSize)
        paperButton.anchor(top: nil, leading: rockButton.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, size: buttonSize)
        scissorsButton.anchor(top: nil, leading: paperButton.trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, size: buttonSize)
        
        rockButton.widthAnchor.constraint(equalTo: paperButton.widthAnchor).isActive = true
        paperButton.widthAnchor.constraint(equalTo: scissorsButton.widthAnchor).isActive = true
        
        opponentImageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: labelSpacing, left: labelSpacing, bottom: 0, right: 0), size: imageViewSize)
        playerImageView.anchor(top: nil, leading: nil, bottom: rockButton.topAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: labelSpacing, right: labelSpacing), size: imageViewSize)
        
        resultLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: labelSize)
        resultLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        anchorYAxisSpacingEqually(forViews: [opponentImageView, resultLabel, playerImageView])
    }
    
    private final func setButtonsActions() {
        rockButton.addTarget(self, action: #selector(rockButtonClicked), for: .touchUpInside)
        paperButton.addTarget(self, action: #selector(paperButtonClicked), for: .touchUpInside)
        scissorsButton.addTarget(self, action: #selector(scissorsButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Allow only one touch at a time
    final func setMultiTouchEnabled(_ enabled: Bool) {
        isMultipleTouchEnabled = enabled
        
        for view in subviews {
            view.isMultipleTouchEnabled = enabled
        }
    }
    
    final func setExclusiveTouch(_ enabled: Bool) {
        isExclusiveTouch = enabled
        
        for view in subviews {
            view.isExclusiveTouch = enabled
        }
    }
    
    // MARK: - Setup view styles
    private final func setButtonsStyles(forButtons buttons: [UIButton]) {
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = RPSView.defaultTextColor.cgColor
            
            button.setTitleColor(RPSView.defaultTextColor, for: .normal)
            button.setTitleColor(RPSView.defaultHighlightedTextColor, for: .highlighted)
        }
    }
    
    private final func setLabelStyles(forLabels labels: [UILabel]) {
        for label in labels {
            label.textAlignment = .center
            label.text = RPSView.startText
            label.font = RPSView.resultFont
        }
    }
    
    // MARK: - Buttons clicked
    @objc private final func rockButtonClicked() {
        disableAllButtons()
        rpsViewDelegate?.rpsView(self, didPlayHand: .rock)
    }
    
    @objc private final func paperButtonClicked() {
        disableAllButtons()
        rpsViewDelegate?.rpsView(self, didPlayHand: .paper)
    }
    
    @objc private final func scissorsButtonClicked() {
        disableAllButtons()
        rpsViewDelegate?.rpsView(self, didPlayHand: .scissors)
    }
    
    private final func allButtons() -> [UIButton] {
        return [rockButton, paperButton, scissorsButton]
    }
    
    private final func disableAllButtons() {
        for button in allButtons() {
            button.isEnabled = false
        }
    }
    
    private final func enableAllButtons() {
        for button in allButtons() {
            button.isEnabled = true
        }
    }
}

// MARK: - Functional methods
extension RPSView {
    // MARK: Update view based on models
    private final func setResultLabelStyles(text: String, textColor: UIColor) {
        resultLabel.text = text
        resultLabel.textColor = textColor
    }
    
    final func displayResult(playerImage: UIImage, opponentImage: UIImage, resultText: String, resultColor: UIColor) {
        setResultLabelStyles(text: resultText, textColor: resultColor)
        
        playerImageView.image = playerImage
        opponentImageView.image = opponentImage
        
        enableAllButtons()
    }
    
    final func animateResult(playerImage: UIImage, opponentImage: UIImage, resultText: String, resultColor: UIColor, countDownTime count: Int) {
        if count > 0 {
            UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveEaseInOut], animations: {
                self.setResultLabelStyles(text: "\(count)", textColor: RPSView.defaultTextColor)
                self.resultLabel.alpha = 0.1
                
            }, completion: { _ in
                self.resultLabel.alpha = 1
                self.animateResult(playerImage: playerImage, opponentImage: opponentImage, resultText: resultText, resultColor: resultColor, countDownTime: count - 1)
            })
        }
        else {
            resultLabel.alpha = 1
            displayResult(playerImage: playerImage, opponentImage: opponentImage, resultText: resultText, resultColor: resultColor)
        }
    }
}

protocol RPSViewDelegate: class {
    func rpsView(_: RPSView, didPlayHand: Hand)
}
