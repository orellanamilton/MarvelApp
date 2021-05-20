//
//  RegisterViewController.swift
//  MarvelApp
//
//  Created by Milton Orellana on 11/05/2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordBackground: UIView!
    @IBOutlet weak var emailBackground: UIView!
    @IBOutlet weak var signupButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordBackground.layer.cornerRadius = 5
        emailBackground.layer.cornerRadius = 5
        signupButton.layer.cornerRadius = 5
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "RegisterToCharacters", sender: self)
                }
            }
        }
        
    }
    


}

