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
    
    func pushJournalEntryViewController(journalManager: JournalManager, entryToUpdate entry: JournalEntry? = nil) {
        let vc = JournalEntryViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self
        vc.journalManager = journalManager
        vc.entryToUpdate = entry
        navController!.pushViewController(vc, animated: true)
    }
    
    func pushActivitiesListViewController(trigerredCell: JournalEntryTableViewActivityCell) {
        let vc = ActivitiesListViewController.instantiate(storyboardName: "Main")
        vc.coordinator = self
        vc.fromCell = trigerredCell
        navController!.pushViewController(vc, animated: true)
    }
    
    
}
