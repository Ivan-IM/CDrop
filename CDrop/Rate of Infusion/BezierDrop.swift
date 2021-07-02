//
//  BezierOne.swift
//  BezierTestApp
//
//  Created by Иван Маришин on 30.06.2021.
//

import UIKit

@IBDesignable
class BezierDrop: UIView {
    
    static func drawDrop(view: UIView, bar: UINavigationController, interval: Float) {
        let drop = CAShapeLayer()
        let indexPosition: CGFloat = 0.10
        let center = CGPoint(x: view.frame.width*indexPosition, y: bar.navigationBar.frame.maxY)
        let dropPath = UIBezierPath()
        dropPath.move(to: center)
        dropPath.addCurve(to: center,
                          controlPoint1: CGPoint(x: center.x+30, y: center.y+50),
                          controlPoint2: CGPoint(x: center.x-30, y: center.y+50))
        
        drop.path = dropPath.cgPath
        drop.lineWidth = 1
        drop.strokeColor = UIColor.black.cgColor
        drop.fillColor = UIColor.blue.cgColor
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = CGPoint(x: drop.frame.origin.x, y: bar.navigationBar.frame.maxY)
        animation.byValue = CGPoint(x: drop.frame.origin.x, y: view.frame.maxY)
        animation.duration = 0.25
        
        view.layer.addSublayer(drop)
        drop.add(animation, forKey: "animation")
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250), execute: {
            view.layer.sublayers?.removeLast()
        })
    }
    
}
