//
//  RegisterViewController.swift
//  EcoAction
//
//  Created by 蔡曉涵 on 27/5/19.
//  Copyright © 2019 Orbital2019Team1952. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var ref: DatabaseReference! = Database.database().reference()
    
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
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        
        let email = emailTextField.text
        let password = passwordTextField.text
        let nickname = nicknameTextField.text
        
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            /*if user != nil {
                let alert = UIAlertController(title: "Email has been used!", message: "Go to log in page", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Please fill in all information.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }*/
            
            
    
            if error == nil && nickname != "" {
                guard let userID = Auth.auth().currentUser?.uid else { return } // cannot put it when there is error
                
                self.ref.child("users/\(userID)/nickname").setValue(nickname)
                self.ref.child("users/\(userID)/email").setValue(email)
                //self.ref.child("users/\(userID)/password").setValue(password)
                self.ref.child("users/\(userID)/points").setValue(10)
                
                self.sendVerificationMail()
            } else {
                let errorMessage =  nickname != "" ? error?.localizedDescription : "Nickname is empty"
                let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        
    
        }

    }
    

   

}
