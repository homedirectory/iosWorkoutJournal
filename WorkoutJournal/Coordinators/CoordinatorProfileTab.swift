//
//  CoordinatorProfileTab.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 14.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class CoordinatorProfileTab {
    
    static var STORYBOARD_NAME: String = "Profile"
    
    var navController: UINavigationController?
    
    init() {
    }
    
    func start(journalManager: JournalManager) {
        self.navController = UINavigationController()
    }
        
}