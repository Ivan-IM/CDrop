//
//  RIModel.swift
//  CDrop
//
//  Created by Иван Маришин on 19.06.2021.
//

import Foundation

struct RateOfInfusion {
    let volume: Float
    let time: Int
    let speed: Float
    
    var getSpeed: Float {
        volume*20.0/Float(time*60)
    }
    var getTime: Int {
        Int(volume*20.0/speed*60)
    }
    var getVolume: Float {
        Float(time*60)*speed/20
    }
}
