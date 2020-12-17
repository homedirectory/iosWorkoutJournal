//
//  LoginViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AuthenticationCoordinator?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.errorLabel.alpha = 0
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        // validate text fields
        if let errorString = self.validateTextFields() {
            self.showError(errorString)
            return
        }
        
        let email = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // perform the sign in operation
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let err = error {
                self.showError(err.localizedDescription)
            }
            else {
                // transition to the main screen
                self.coordinator!.pushTabBarController()
                do {
                    try CredentialsStorage.storage.save(credentials: Credentials(email: email, password: password))
                } catch let err {
                    print("- failed to save credentials: \(err)")
                }
            }
        }
        
    }
    
    // returns an error mesage if validation fails
    private func validateTextFields() -> String? {
        // check email and password for emptiness
        if (self.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! ||
            (self.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    private func showError(_ message: String) {
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == self.view {
                self.view.endEditing(true)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
