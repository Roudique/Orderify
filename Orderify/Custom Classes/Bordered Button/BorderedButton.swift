//
//  BorderedButton.swift
//  Orderify
//
//  Created by Roudique on 1/9/17.
//  Copyright © 2017 roudique.com. All rights reserved.
//

import UIKit

@IBDesignable

class BorderedButton: UIButton {
    @IBInspectable var topBorder : Bool = false
    @IBInspectable var botBorder : Bool = false

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if topBorder || botBorder {
            let path = UIBezierPath.init()
            path.lineWidth = 1.0
            
            if topBorder {
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: self.bounds.size.width, y: 0))
            }
            if botBorder {
                path.move(to: CGPoint(x: 0, y: self.bounds.size.height))
                path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
            }
            
            UIColor.lightGray.setStroke()
            path.stroke()
        }
        
    }
}
