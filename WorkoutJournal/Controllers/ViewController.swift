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
        let running = Running(duration: 2400, distance: 6000)
        
//        jm.createEntry(activity: running, date: Date())
        
        jm.entries.forEach({
            $0.printInfo()
        })
        
    }


}

