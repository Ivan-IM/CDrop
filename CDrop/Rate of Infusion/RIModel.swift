//
//  RIModel.swift
//  CDrop
//
//  Created by Иван Маришин on 19.06.2021.
//

import Foundation

struct RateOfInfusion {
    let volume: Float
    let time: Float
    let speed: Float
    
    var getSpeed: Float {
        (volume*20.0)/(time*60)
    }
    var getTime: Float {
        (volume*20.0)/(speed*60)
    }
    var getVolume: Float {
        ((time*60)*speed)/20.0
    }
}
