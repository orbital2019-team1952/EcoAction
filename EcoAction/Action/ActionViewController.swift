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
        actions =  [Action(time: "201888849", prepare: true, reduce: true, reuse: false, recycle: true, turnOff: false)] //Action.readData()
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
