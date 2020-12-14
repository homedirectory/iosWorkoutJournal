//
//  Coordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 07.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class CoordinatorOverviewTab {
    
    static var STORYBOARD_NAME: String = "Overview"
    
    var navController: UINavigationController?
    
    init() {
    }
    
    func start(journalManager: JournalManager) {
        let vc = ViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        vc.journalManager = journalManager
        self.navController = UINavigationController(rootViewController: vc)
    }
    
    func pushJournalEntryViewController(journalManager: JournalManager, entryToUpdate entry: JournalEntry? = nil) {
        let vc = JournalEntryViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        vc.journalManager = journalManager
        vc.entryToUpdate = entry
        navController!.pushViewController(vc, animated: true)
    }
    
    func pushActivitiesListViewController(trigerredCell: JournalEntryTableViewActivityCell) {
        let vc = ActivitiesListViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        vc.fromCell = trigerredCell
        navController!.pushViewController(vc, animated: true)
    }
    
    
}
