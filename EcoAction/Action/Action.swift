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
    
    class func readData() {
        var ref: DatabaseReference! = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        var tempActions: [Action] = []
        
        ref.child("users/\(userID)/achievement").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let results = snapshot.value as! [String: Any]
            let keyInOrder = results.keys.sorted(by: >)
            for key in keyInOrder {
                let action = results[key] as! [String: Any]
                let timeInterval = action["timeInterval"] as! TimeInterval
                let prepare = action["prepare your own lunchbox"] as! Bool
                let reduce = action["reduce using plastic straw"] as! Bool
                let reuse = action["reuse plastic bag or bring your own bag"] as! Bool
                let recycle = action["recycle plastic or can or paper"] as! Bool
                let turnOff = action["turn off the light when leaving"] as! Bool
                
                let date = self.dateToString(date: Date(timeIntervalSince1970: timeInterval))
                let tempAct = Action(time: date, prepare: prepare, reduce: reduce, reuse: reuse, recycle: recycle, turnOff: turnOff)
                tempActions.append(tempAct)
                print(tempActions.count)
            }
            getActions(actions: tempActions)
        })
        
    }
    
    class func getActions(actions: [Action]) -> [Action]{
        return actions
    }
    
    class func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
    
}
