//
//  AuthViewController.swift
//  MarvelApp
//
//  Created by Milton Orellana on 11/05/2021.
//

import UIKit
import Firebase
import CryptoKit
import FacebookLogin

class AuthViewController: UIViewController {
    
    @IBOutlet weak var authEmail: UITextField!
    @IBOutlet weak var authPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var authEmailBackground: UIView!
    @IBOutlet weak var authPasswordBackground: UIView!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authEmailBackground.layer.cornerRadius = 5
        authPasswordBackground.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = authEmail.text, let password = authPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: "The combination of Email and Password is not correct. Please retry.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Retry", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: "LoginToCharacters", sender: self)
                }
            }
        }
    }
    
    @IBAction func facebookPressed(_ sender: UIButton) {
        let loginManager = LoginManager()
        
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { (result) in
            
            switch result {
            
            case .success(granted: _, declined: _, token: let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
                
                Auth.auth().signIn(with: credential) { (result, error) in
                    self.performSegue(withIdentifier: "LoginToCharacters", sender: self)
                }
            case .cancelled:
                break
            case .failed(_):
                break
            }
        }
    }
    
    
}
