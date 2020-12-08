//
//  Coordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 07.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class Coordinator {
    
    var navController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start(journalManager: JournalManager) {
        let vc = ViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self
        vc.journalManager = journalManager
        navController!.pushViewController(vc, animated: true)
    }
    
}
