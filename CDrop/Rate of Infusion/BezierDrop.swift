//
//  BezierOne.swift
//  BezierTestApp
//
//  Created by Иван Маришин on 30.06.2021.
//

import UIKit

@IBDesignable
class BezierDrop: UIView {
    
    static func drawDrop(view: UIView) {
        let drop = CAShapeLayer()
        let indexPosition: CGFloat = 0.90
        let center = CGPoint(x: view.frame.width*indexPosition, y: view.frame.origin.y)
        let dropPath = UIBezierPath()
        dropPath.move(to: center)
        dropPath.addCurve(to: center,
                          controlPoint1: CGPoint(x: center.x+30, y: center.y+50),
                          controlPoint2: CGPoint(x: center.x-30, y: center.y+50))
        
        drop.path = dropPath.cgPath
        drop.lineWidth = 1
        drop.strokeColor = UIColor.black.cgColor
        drop.fillColor = UIColor.blue.cgColor
        drop.shadowRadius = 3.0
        drop.shadowOpacity = 0.5
        drop.shadowOffset = CGSize(width: 3, height: 3)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: drop.frame.origin.x, y: view.frame.origin.y)
        animation.byValue = CGPoint(x: drop.frame.origin.x, y: view.frame.maxY)
        animation.duration = 0.25
        
        view.layer.addSublayer(drop)
        drop.add(animation, forKey: "animation")
    }
    
}
