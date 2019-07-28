//
//  ActionViewController.swift
//  EcoAction
//
//  Created by Shirley Wang on 29/6/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ActionViewController: UIViewController {

    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var point: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        // Do any additional setup after loading the view.
        readDate()
    }
    

    func setLabel() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users").child(userID).observe( DataEventType.value, with: { (snapshot) in
            
            guard let dict = snapshot.value as? [String:AnyObject] else { return }
            
            guard let nicknameText = dict["nickname"] as? String else { return }
            
            guard let pointNum = dict["points"] as? Int else { return }
            
            self.nickname.text = nicknameText
            
            self.point.text = "\(pointNum)"
        })
        
    }
    
    func readDate() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users/\(userID)/achievement").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let results = snapshot.value as! [String: Any]
            let keyInOrder = results.keys.sorted(by: >)
            var count = 10
            for key in keyInOrder {
                let action = results[key] as! [String: Any]
                let timeInterval = action["timeInterval"] as! TimeInterval
                let prepare = action["prepare your own lunchbox"] as! Bool
                let reduce = action["reduce using plastic straw"] as! Bool
                let reuse = action["reuse plastic bag or bring your own bag"] as! Bool
                let recycle = action["recycle plastic or can or paper"] as! Bool
                let turnOff = action["turn off the light when leaving"] as! Bool
                
                let date = self.dateToString(date: Date(timeIntervalSince1970: timeInterval))
                count -= 1
                if count > 0 {
                    print("\(date)  \(timeInterval)")
                    print("prepare  \(prepare)")
                    print("reduce  \(reduce)")
                    print("reuse  \(reuse)")
                    print("recycle  \(recycle)")
                    print("turnOff  \(turnOff)")
                } else {
                    break
                }
            }
        })
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }

}
