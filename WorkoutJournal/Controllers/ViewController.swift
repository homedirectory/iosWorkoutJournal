//
//  ViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let storage = CoreDataStorage()
        let jm = JournalManager.shared
//        jm.storage = storage
//        jm.fetch()
        
        let r = Activity(name: "Climbing", duration: 3600, distance: 100)

//        do {
//            try jm.createEntry(activity: r, date: Date())
//        } catch let error {
//            print(error)
//        }
//        jm.deleteAllEntries()
        
        
        jm.entries.forEach({
            $0.printInfo()
        })
        
//        jm.setEntryActivity(entryId: 1, newActivity: r)
        
//        jm.setEntryActivityDistance(entryId: 1, newDistance: 1)
 
    }


}

