//
//  UIView+Gradient.swift
//  Orderify
//
//  Created by Roudique on 1/8/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    enum GradientDirection {
        case topLeft
        case top
        case topRight
        case left
        case right
        case botLeft
        case bot
        case botRight
    }
    
    func applyGradient(colors: [UIColor], start: GradientDirection, end: GradientDirection) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.startPoint = pointForDirection(direction: start)
        gradient.endPoint = pointForDirection(direction: end)
        
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    fileprivate func pointForDirection(direction: GradientDirection) -> CGPoint {
        switch direction {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .top:
            return CGPoint(x: 0.5, y: 0)
        case .topRight:
            return CGPoint(x: 1, y: 0)
        case .left:
            return CGPoint(x: 0, y: 0.5)
        case .right:
            return CGPoint(x: 1, y: 0.5)
        case .botLeft:
            return CGPoint(x: 0, y: 1)
        case .bot:
            return CGPoint(x: 0.5, y: 0.5)
        case .botRight:
            return CGPoint(x: 1, y: 1)
        }
    }
}
