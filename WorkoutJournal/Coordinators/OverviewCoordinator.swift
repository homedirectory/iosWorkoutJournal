//
//  Coordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 07.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class OverviewCoordinator {
    
    static var STORYBOARD_NAME: String = "Overview"
    
    var navController: UINavigationController?
    
    init() {
    }
    
    func start() {
        let vc = OverviewViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController = UINavigationController(rootViewController: vc)
    }
    
    func pushJournalEntryViewController(entryToUpdate entry: JournalEntry? = nil) {
        let vc = JournalEntryViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        vc.entryToUpdate = entry
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushActivitiesListViewController(trigerredCell: JournalEntryTableViewActivityCell) {
        let vc = ActivitiesListViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        vc.fromCell = trigerredCell
        self.navController!.pushViewController(vc, animated: true)
    }
    
    
}
