//
//  CheckButton.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 22/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit

class CheckButton: UIButton {

    var isChecked = false
    
    func toggle() {
        if !isChecked {
            isChecked = true
        } else {
            isChecked = false
        }
    }
    
    func state() -> Bool {
        return isChecked
    }
    
    func buttonClicked(sender: CheckButton!) {
        if(sender == self) {
            toggle()
            if state() {
                
            }
        }
    }

}
