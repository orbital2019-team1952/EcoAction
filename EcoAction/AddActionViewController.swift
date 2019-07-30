//
//  AddActionViewController.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 1/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddActionViewController: UIViewController {

    @IBOutlet weak var prepareLunchBoxAct: CheckButton!
    @IBOutlet weak var reduceStrawAct: CheckButton!
    @IBOutlet weak var reusePlasticBagAct: CheckButton!
    @IBOutlet weak var recycleAct: CheckButton!
    @IBOutlet weak var turnOffLightAct: CheckButton!
    
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancel() {
        self.performSegue(withIdentifier: "GoToAction", sender: self)
    }
    
    @IBAction func checkboxTapped(_ sender: CheckButton) {
        sender.toggle()
        sender.state() ? sender.setBackgroundImage(UIImage(named: "checked"), for: .normal) :
            sender.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
    }
    
//    func generateDate() -> Date {
//        let today = Date()
//        let zone = NSTimeZone.system
//        let interval = zone.secondsFromGMT()
//        let now = today.addingTimeInterval(TimeInterval(interval))
//        return now
//    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    @IBAction func addTodayAction() {
        //guard let userID = Auth.auth().currentUser?.uid else { return }
        
        var actList = actionToList(prepare: prepareLunchBoxAct, reduce: reduceStrawAct, reuse: reusePlasticBagAct, recycle: recycleAct, turnOff: turnOffLightAct)
        let today = Date()
        let timeInterval = today.timeIntervalSince1970
        
        var publicList: [String: Int] = [:]
        
        for (act, isDone) in actList {
            if let state = isDone as? Bool {
                if state {
                    publicList[act] = 1
                    addPoints()
                } else {
                    publicList[act] = 0
                }
            }
        }
        
        actList["timeInterval"] = timeInterval
        uploadAction(act: actList)
        addToPublic(date: dateToString(date: today), achievements: publicList)
    }

    func actionToList(prepare: CheckButton, reduce: CheckButton, reuse: CheckButton, recycle: CheckButton, turnOff: CheckButton) -> Dictionary<String, Any> {
        return [
                 "prepare your own lunchbox" : prepare.isChecked,
                 "reduce using plastic straw" : reduce.isChecked,
                 "reuse plastic bag or bring your own bag" : reuse.isChecked,
                 "recycle plastic or can or paper" : recycle.isChecked,
                 "turn off the light when leaving" : turnOff.isChecked
               ]
    }
    
    func addPoints() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users/\(userID)/points").runTransactionBlock({ (currentData:MutableData) -> TransactionResult in
            if var points = currentData.value as? Int {
                print(points)
                points += 5
                currentData.value = points
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        })
    }
    
    func uploadAction(act: Dictionary<String, Any>) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("/users/\(userID)/achievement").childByAutoId().setValue(act)
        
    }
    
    func addToPublic(date: String, achievements:[String: Int]) {
        
        ref.child("public").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild("\(date)"){
                for (act, num) in achievements {
                    self.updatePublic(date: date, act: act, num: num)
                }
                
            }else{
                for (act, num) in achievements {
                    self.ref.child("public/\(date)/\(act)").setValue(num)
                }
            }
            
            
        })
    }
    
    func updatePublic(date: String, act: String, num: Int) {
        print("\(date)/\(act)")
        var temp : Int?
        ref.child("public/\(date)/\(act)").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            temp = snapshot.value as? Int
            print(temp)
        });
        
        ref.child("public/\(date)/\(act)").runTransactionBlock({ (currentData:MutableData) -> TransactionResult in
            if var points = currentData.value as? Int {
                print(points)
                points += num
                currentData.value = points
                
                return TransactionResult.success(withValue: currentData)
            }
            //Abort like if there was a problem
            //return TransactionResult.abort()
            return TransactionResult.success(withValue: currentData)
        })
    }
    
}
