//
//  ViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: AuthenticationCoordinator?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.setTitleColor(.white, for: .normal)
        self.loginButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.loginButton.layer.cornerRadius = 15.0
        
        self.signUpButton.setTitleColor(.white, for: .normal)
        self.signUpButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        self.signUpButton.layer.cornerRadius = 15.0
    }
    

    @IBAction func loginButtonAction(_ sender: Any) {
        self.coordinator!.pushLoginViewController()
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        self.coordinator!.pushSignUpViewController()
    }
}
