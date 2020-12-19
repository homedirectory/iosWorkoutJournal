//
//  SignUpViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AuthenticationCoordinator?
    private var failed: Bool = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signUpButton.setTitleColor(.white, for: .normal)
        self.signUpButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.signUpButton.layer.cornerRadius = 15.0

        self.errorLabel.alpha = 0
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        self.failed = false

        // validate text fields
        if let errorString = self.validateTextFields() {
            self.showError(errorString)
            return
        }
        
        let name = self.nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        let db = Firestore.firestore()
        
        let usersRef = db.collection("users")
        let usernamesRef = db.collection("usernames")
        
        // check if this username is available
        let usernameRef = usernamesRef.document(name)
        
        usernameRef.getDocument { (docSnapshot, error) in
            if let err = error {
                self.showError(err.localizedDescription)
            }
            else {
                // if username exists
                if docSnapshot!.exists {
                    print("this username exists")
                    self.showError("This username is unavailable")
                }
                    // if username is available
                else {
                    // create user
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if let err = error {
                            self.showError(err.localizedDescription)
                        }
                        else {
                            // write new user into db users
                            usersRef.document(name).setData(["uid" : result!.user.uid, "name": name, "following": [String]()]) { error in
                                if let err = error {
                                    self.showError(err.localizedDescription)
                                } else {
                                    // write new username into db usernames
                                    usernamesRef.document(name).setData([:])
                                    // set current user
                                    UserManager.shared.setCurrentUser(withName: name, withCredentials: Credentials(email: email, password: password))
                                    // transition to the main screen
                                    self.coordinator!.pushTabBarController(fetchNeeded: false)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
                
    // returns an error mesage if validation fails
    private func validateTextFields() -> String? {
        // check input fields for emptiness
        if (self.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! ||
            (self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! ||
            (self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            return "Please fill in all fields"
        }
        // check password with regular expressions
        if !StaticVariables.validatePassword(self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) {
            return "Please make sure your password is at least 8 characters long, contains a special character and a number"
        }
        // TODO: check email with regular expressions
        
        return nil
    }
    
    private func showError(_ message: String) {
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
        self.failed = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view != self.nameTextField && touch.view != self.emailTextField && touch.view != self.passwordTextField {
                self.view.endEditing(true)
            }
        }
    }

}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
