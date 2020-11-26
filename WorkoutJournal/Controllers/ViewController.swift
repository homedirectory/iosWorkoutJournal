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
        
        sleep(3)
        print("HELLo")
        
        let jm = JournalManager.shared
        
        let r: Activity = Running(distance: 1000, duration: 60)
        print(r.name)
        
        let rId = jm.createEntry(activity: r, date: Date())
        
        jm.printEntryInfo(entryId: rId)
        jm.setEntryDate(entryId: rId, newDate: Date(timeIntervalSince1970: 150))
        jm.printEntryInfo(entryId: rId)
        jm.setEntryActivityDistance(entryId: rId, newDistance: 20000)
        jm.setEntryActivityDuration(entryId: rId, newDuration: 6000)
        jm.printEntryInfo(entryId: rId)
        jm.setEntryActivityRepetitions(entryId: rId, newRepetitions: 20)
        jm.printEntryInfo(entryId: rId)
        
    }


}

