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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //emailTextField.text = "Email"
        //passwordTextField.text = "Password"
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
                self.ref.child("users/\(userID)/password").setValue(password)
                self.ref.child("users/\(userID)/points").setValue(10)
                self.performSegue(withIdentifier: "signup", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        
    
        }

    }
    

   

}
