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
        
        let jm = JournalManager.shared
//        let running = Running(duration: 2400, distance: 6000)
        
//        jm.createEntry(activity: running, date: Date())
//        jm.deleteAllEntries()
        
//        jm.deleteAllEntries()
//        jm.createEntry(activity: Running(duration: 50, distance: 200), date: Date())
//        jm.createEntry(activity: Plank(duration: 50), date: Date())
//        jm.updateEntryActivity(entryId: 1, newDuration: 15)
//        jm.updateEntryActivity(entryId: 1, newDuration: 50)
//        jm.createEntry(activity: Plank(duration: 120), date: Date())
        print(Running.totalDistance.value, Running.totalDistance.value)
        print(Plank.totalDistance.value)
        print(Activity.totalDistance.value, Activity.totalDistance.value)
        
        jm.entries.forEach({
            $0.printInfo()
            print(type(of: $0.activity!))
        })
        
    }


}

