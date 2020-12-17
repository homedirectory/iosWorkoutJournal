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
        // create the user
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                self.showError(err.localizedDescription)
            }
            else {
                let db = Firestore.firestore()
                // store the created user in the database
                db.collection("users").addDocument(data: ["name": name, "uid": result!.user.uid]) { (error) in
                    if let err = error {
                        self.showError(err.localizedDescription)
                    }
                }
                if !self.failed {
                    // transition to the main screen
                    self.coordinator!.pushTabBarController()
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
