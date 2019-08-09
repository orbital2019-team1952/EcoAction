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
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
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
    
    func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signup", sender: self)
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
        }
        else {
            let alertController = UIAlertController(title: "Error", message: "The user is not available or already verified.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil && (user?.user.isEmailVerified)! {
                self.performSegue(withIdentifier: "login", sender: self)
            } else {
                let errorMessage =  error != nil ? error?.localizedDescription : "Not Verified"
                if error == nil {
                    self.sendVerificationMail()
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Reset") as! ResetPasswordViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    

}
