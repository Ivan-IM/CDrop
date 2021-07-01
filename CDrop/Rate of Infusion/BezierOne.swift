//
//  BezierOne.swift
//  BezierTestApp
//
//  Created by Иван Маришин on 30.06.2021.
//

import UIKit

@IBDesignable
class BezierOne: UIView {

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: self.bounds.origin.x+30, y: self.bounds.origin.y+65)
        
        let drop = UIBezierPath()
        drop.move(to: center)
        drop.addCurve(to: center,
                      controlPoint1: CGPoint(x: center.x+30, y: center.y+50),
                      controlPoint2: CGPoint(x: center.x-30, y: center.y+50))
        let color = UIColor.blue
        color.setStroke()
        color.setFill()
        drop.fill()
        drop.lineWidth = 2
        drop.stroke()
        
        
    
    }
}
