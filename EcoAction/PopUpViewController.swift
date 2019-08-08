//
//  PopUpViewController.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 8/8/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.showAnimate()
        textView.isEditable = false
        textView.isSelectable = false
        // Do any additional setup after loading the view.
    }
    

    @IBAction func closePopUp(_ sender: Any) {
        self.removeAnimate()
        //self.view.removeFromSuperview()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }

}
