//
//  JournalEntry.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class JournalEntry {
    
    let id: Int
    var activity: Activity?
    var creationDate: Date?
    
    init(id: Int, activity: Activity, date: Date) {
        self.activity = activity
        self.creationDate = date
        self.id = id
    }
    
    init(_ managedObject: JournalEntryModel) {
        self.id = managedObject.value(forKey: "id") as! Int
        let activity = managedObject.value(forKey: "activity")! as! ActivityModel
        self.activity = activity.transform()
        self.creationDate = managedObject.value(forKey: "date") as? Date
    }
    
    
    func printInfo() {
        print("""
            -------------------
            entryId: \(id)
            activity: \(activity?.toString() ?? "none")
            date: \(String(describing: creationDate))
            """)
    }
    
}
