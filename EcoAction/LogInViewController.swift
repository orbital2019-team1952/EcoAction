//
//  LogInViewController.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 27/5/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import TweeTextField

class LogInViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: TweePlaceholderTextField!
    @IBOutlet weak var passwordTextField: TweePlaceholderTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //emailTextField.text = "Email"
        //passwordTextField.text = "Password"
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                let alert = UIAlertController(title: "Error", message: "Login failed", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    

}
