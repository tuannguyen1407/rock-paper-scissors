//
//  UIViewExtension.swift
//  RockPaperScissors
//
//  Created by Tuan Nguyen on 11/29/18.
//  Copyright © 2018 Tuan Nguyen. All rights reserved.
//

import UIKit

extension UIView {
    private func setAutoLayout(_ value: Bool) {
        translatesAutoresizingMaskIntoConstraints = value
    }
    
    final func anchorCenter(inView: UIView) {
        setAutoLayout(false)
        centerXAnchor.constraint(equalTo: inView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: inView.centerYAnchor).isActive = true
    }
    
    final func anchorCenterX(inView: UIView) {
        setAutoLayout(false)
        centerXAnchor.constraint(equalTo: inView.centerXAnchor).isActive = true
    }
    
    final func anchorCenterY(inView: UIView) {
        setAutoLayout(false)
        centerYAnchor.constraint(equalTo: inView.centerYAnchor).isActive = true
    }
    
    final func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor? , padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        setAutoLayout(false)
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    final func anchorYAxisSpacingEqually(forViews views: [UIView]) {
        var topIndex = 0
        while topIndex + 2 < views.count {
            let topSpace = views[topIndex].centerYAnchor.anchorWithOffset(to: views[topIndex + 1].centerYAnchor)
            let bottomSpace = views[topIndex + 1].centerYAnchor.anchorWithOffset(to: views[topIndex + 2].centerYAnchor)
            topSpace.constraint(equalTo: bottomSpace, multiplier: 1).isActive = true
            topIndex += 1
        }
    }
    
    final var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    final var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}
