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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonAction(_ sender: Any) {
        self.coordinator!.pushLoginViewController()
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        self.coordinator!.pushSignUpViewController()
    }
}
