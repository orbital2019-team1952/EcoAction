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
    @IBOutlet weak var pointsAdded: UILabel!
    
    func setAction(action: Action) {
        
        var currentPoints = 0
        
        self.selectionStyle = .none
        print(action.time)
        time.text = action.time
        prepareLunchBoxAct.image = #imageLiteral(resourceName: "lunch-box")
        reduceStrawAct.image = #imageLiteral(resourceName: "straw")
        reusePlasticBagAct.image = #imageLiteral(resourceName: "reuse")
        recycleAct.image = #imageLiteral(resourceName: "recycle-sign")
        turnOffLightAct.image = #imageLiteral(resourceName: "turn-off")
        
        prepareLunchBoxAct.alpha = 1
        reduceStrawAct.alpha = 1
        reusePlasticBagAct.alpha = 1
        recycleAct.alpha = 1
        turnOffLightAct.alpha = 1
        
        if !action.prepare {
            prepareLunchBoxAct.alpha = 0.1
            //prepareLunchBoxAct.isHidden = true
        } else {
            currentPoints += 5
        }
        
        if !action.reduce {
            reduceStrawAct.alpha = 0.1
            //reduceStrawAct.isHidden = true
        } else {
            currentPoints += 5
        }
        
        if !action.reuse {
            reusePlasticBagAct.alpha = 0.1
            //reusePlasticBagAct.isHidden = true
        } else {
            currentPoints += 5
        }
        
        if !action.recycle {
            recycleAct.alpha = 0.1
            //recycleAct.isHidden = true
        } else {
            currentPoints += 5
        }
        
        if !action.turnOff {
            turnOffLightAct.alpha = 0.1
            //turnOffLightAct.isHidden = true
        } else {
            currentPoints += 5
        }
        
        pointsAdded.text = String(currentPoints) + " points"
    }
}
