//
//  Extention+UIImage.swift
//  CDrop
//
//  Created by Иван Маришин on 23.06.2021.
//

import UIKit

extension UIImageView {
    func dropAnimation() {
        let animation = CABasicAnimation (keyPath: "position")
        animation.fromValue = CGPoint(x: self.frame.origin.x + (self.frame.size.width/2),
                                      y: self.frame.origin.y + (self.frame.size.height/2))
        animation.toValue = CGPoint(x: self.frame.origin.x + (self.frame.size.width/2),
                                    y: 1000.0)
        animation.isRemovedOnCompletion = true
        animation.duration = 1.0
        animation.speed = 1.0
        animation.repeatCount = 0
        layer.add(animation, forKey: nil)
    }
}
