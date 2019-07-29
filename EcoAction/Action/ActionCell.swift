//
//  ActionCell.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 28/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit

class ActionCell: UITableViewCell {

    @IBOutlet weak var time : UILabel!
    @IBOutlet weak var prepareLunchBoxAct: UIImageView!
    @IBOutlet weak var reduceStrawAct: UIImageView!
    @IBOutlet weak var reusePlasticBagAct: UIImageView!
    @IBOutlet weak var recycleAct: UIImageView!
    @IBOutlet weak var turnOffLightAct: UIImageView!

    func setAction(action: Action) {
        print(action.time)
        time.text = action.time
        prepareLunchBoxAct.image = #imageLiteral(resourceName: "lunch-box")
        reduceStrawAct.image = #imageLiteral(resourceName: "straw")
        reusePlasticBagAct.image = #imageLiteral(resourceName: "reuse")
        recycleAct.image = #imageLiteral(resourceName: "recycle-sign")
        turnOffLightAct.image = #imageLiteral(resourceName: "turn-off")
        
        prepareLunchBoxAct.isHidden = false
        reduceStrawAct.isHidden = false
        reusePlasticBagAct.isHidden = false
        recycleAct.isHidden = false
        turnOffLightAct.isHidden = false
        
        if !action.prepare {
            prepareLunchBoxAct.isHidden = true
        }
        
        if !action.reduce {
            reduceStrawAct.isHidden = true
        }
        
        if !action.reuse {
            reusePlasticBagAct.isHidden = true
        }
        
        if !action.recycle {
            recycleAct.isHidden = true
        }
        
        if !action.turnOff {
            turnOffLightAct.isHidden = true
        }
    }
}
