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
    var date: Date?
    
    init(id: Int, activity: Activity, date: Date) {
        self.activity = activity
        self.date = date
        self.id = id
    }
    
    init(_ managedObject: JournalEntryModel) {
//        print("- init from JournalEntryModel")
        self.id = managedObject.value(forKey: "id") as! Int
        let activity = managedObject.value(forKey: "activity")! as! ActivityModel
//        print("type of fetched activity: ", type(of: activity))
        self.activity = activity.transform()
//        print("transformed activity: ", type(of: self.activity!))
        self.date = managedObject.value(forKey: "date") as? Date
    }
    
    
    func printInfo() {
        print("""
            -------------------
            entryId: \(id)
            activity: \(activity?.toString() ?? "none")
            date: \(String(describing: date))
            """)
    }
    
}
