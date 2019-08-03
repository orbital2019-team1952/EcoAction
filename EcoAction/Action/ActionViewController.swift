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
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference! = Database.database().reference()
    
    var actions: [Action] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        readData()
//        actions =  [Action(time: "201888849", prepare: true, reduce: true, reuse: false, recycle: true, turnOff: false)]
        // Do any additional setup after loading the view.
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
    
    func readData() {
        var ref: DatabaseReference! = Database.database().reference()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users/\(userID)/achievement").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            guard let results = snapshot.value as? [String: Any] else { return } //changed
            let keyInOrder = results.keys.sorted(by: >)
            var tempAction: [Action] = []
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
                tempAction.append(tempAct)
                print(tempAction.count)
            }
            self.actions = tempAction
            self.tableView.reloadData()
        })
        
    }
    

    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date)
    }

}

extension ActionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let action = actions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell") as! ActionCell
        
        cell.setAction(action: action)
        
        return cell
    }
    
    
    
}

