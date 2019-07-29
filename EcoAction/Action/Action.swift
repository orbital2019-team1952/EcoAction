//
//  Action.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 28/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Action {
    var time: String
    var prepare: Bool
    var reduce: Bool
    var reuse: Bool
    var recycle: Bool
    var turnOff: Bool
    
    init(time: String, prepare: Bool, reduce: Bool, reuse: Bool, recycle: Bool, turnOff: Bool) {
        print("create action")
        self.time = time
        self.prepare = prepare
        self.reduce = reduce
        self.reuse = reuse
        self.recycle = recycle
        self.turnOff = turnOff
    }
    
}
