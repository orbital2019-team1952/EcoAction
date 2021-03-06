//
//  GameViewController.swift
//  EcoAction
//
//  Created by Shirley Wang on 29/6/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GameViewController: UIViewController {
    
    @IBOutlet weak var bag1: PlasticButton!
    @IBOutlet weak var bag2: PlasticButton!
    @IBOutlet weak var bag3: PlasticButton!
    @IBOutlet weak var straw1: PlasticButton!
    @IBOutlet weak var straw2: PlasticButton!
    @IBOutlet weak var straw3: PlasticButton!
    @IBOutlet weak var bag4: PlasticButton!
    @IBOutlet weak var straw4: PlasticButton!
    
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var point: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
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
    
    @IBAction func showPopUp(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbPopUpID") as! PopUpViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    

}
