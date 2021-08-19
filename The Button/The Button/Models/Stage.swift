//
//  Stage.swift
//  The Button
//
//  Created by Andrew Saeyang on 8/18/21.
//

import Foundation

///The object
class Stage: Codable{
    var stageNumber: Int
    var goldAmount: Int
    var events: [String]
    
    
    init(stageNumber: Int, goldAmount: Int = 25, events: [String] = []){
        self.stageNumber = stageNumber
        self.goldAmount = goldAmount
        self.events = events
    }
}
