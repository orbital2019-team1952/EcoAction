//
//  AddActionViewController.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 1/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit

class AddActionViewController: UIViewController {

    @IBOutlet weak var prepareLunchBoxAct: CheckButton!
    @IBOutlet weak var reduceStrawAct: CheckButton!
    @IBOutlet weak var reusePlasticBagAct: CheckButton!
    @IBOutlet weak var recycleAct: CheckButton!
    @IBOutlet weak var turnOffLightAct: CheckButton!
    
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
    
}
