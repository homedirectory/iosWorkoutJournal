//
//  ProfileViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 14.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class ProfileViewController: UIViewController, Storyboarded {
    
    weak var coordinator: CoordinatorProfileTab?
    var journalManager: JournalManager?
    
    @IBOutlet weak var topLabel: UILabel!
    
    
}
