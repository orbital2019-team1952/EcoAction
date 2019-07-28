//
//  PlasticButton.swift
//  EcoAction
//
//  Created by Shirley Wang on 26/7/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import FirebaseAuth

import FirebaseDatabase

var ref: DatabaseReference! = Database.database().reference()

class PlasticButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        addTarget(self, action: #selector(PlasticButton.clearPlastic), for: .touchUpInside)
    }
    
    @objc func clearPlastic() {
        self.isHidden = true
        deductPoints()
    }
    
    func deductPoints() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("users/\(userID)/points").runTransactionBlock({ (currentData:MutableData) -> TransactionResult in
            if var points = currentData.value as? Int {
                print(points)
                points -= 10
                currentData.value = points
                
                return TransactionResult.success(withValue: currentData)
            }
            //Abort like if there was a problem
            return TransactionResult.abort()
        })
    }

}
