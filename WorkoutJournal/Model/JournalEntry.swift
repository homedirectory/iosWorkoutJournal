//
//  JournalEntry.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class JournalEntry {
    
    let id: String
    var activity: Activity
    var date: Date
    
    init(activity: Activity, date: Date) {
        self.activity = activity
        self.date = date
        self.id = UUID().uuidString
//        print(self.id)
    }
    
    func printInfo() {
        print("""
            -------------------
            entryId: \(id)
            activity: \(activity.toString())
            date: \(date)
            """)
    }
    
}
