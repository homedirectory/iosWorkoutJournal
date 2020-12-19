//
//  JournalManager.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import CoreData
import FirebaseFirestore


public class JournalManager {
    
    enum JournalManagerEror: Error {
        case WrongActivityType
        case EntryIdAlreadyExists
    }
    
    // MARK: - properties and init

    var entries: [JournalEntry]
    private var storage: CoreDataStorage = CoreDataStorage.storage
    static let shared = JournalManager()
    
    private init() {
        self.entries = [JournalEntry]()
    }
        
    // MARK: - CRUD
    
    func createEntry(activity: Activity, date: Date) -> JournalEntry? {
        let entry = JournalEntry(id: UUID().uuidString, activity: activity, date: date)
        
        if self.contains(entry: entry) {
            print("- failed creating, error: entryId already exists")
            return nil
        }
        
        entries.insert(entry, at: 0)
        do {
            try self.storage.save(entry: entry)
        } catch let error {
            print("CoreData: failed to save entry: \(error)")
        }
        print("CoreData: saved an entry")
        entry.activity!.updateAchievements()
        type(of: entry.activity!).updateCustomStats()
        
        // save entry to db
        let db = Firestore.firestore()
        let activitiesRef = db.collection("activities")
        let entriesRef = db.collection("entries")
        // 1) save entry
        entriesRef.document(entry.id).setData([
            "id" : entry.id,
            "username" : UserManager.shared.currentUser!.name,
            "date" : date
        ]) { error in
            if let err = error {
                print("Firestore: saving entry failed, \(err.localizedDescription)")
            } else {
                // 2) save activity
                activitiesRef.document(entry.id).setData([
                    "name" : type(of: activity).name,
                    "distance": activity.distance,
                    "duration": activity.duration,
                    "repetitions": activity.repetitions,
                ]) { error in
                    if let err = error {
                        print("Firestore: saving activity failed, \(err.localizedDescription)")
                    }
                }
            }
        }
        
        return entry
    }
    
    func deleteEntry(entryId: String, completion: (() -> ())? = nil) {
        let db = Firestore.firestore()
        
        let entryDocRef = db.collection("entries").document(entryId)
        
        entryDocRef.delete() { error in
            if let err = error {
                print("Firestore: Error removing entry: \(err.localizedDescription)")
            }
            else {
                let activityDocRef = db.collection("activities").document(entryId)
                
                activityDocRef.delete { [weak self] error in
                    if let err = error {
                        print("Firestore: Error remvoving activity: \(err.localizedDescription)")
                    }
                    else {
                        // delete entry from CoreData
                        do {
                            try self!.storage.deleteEntry(entryId: entryId)
                        } catch let error {
                            print("CoreData: failed to delete entry, error: \(error)")
                            return
                        }
                        // update entry object
                        guard let entryIndex = self!.entries.firstIndex(where: {
                            $0.id == entryId
                        }) else {
                            print("- failed deleting ID: \(entryId), error: index was not found")
                            return
                        }
                        if let _ = completion {
                            completion!()
                        }
                        self!.entries[entryIndex].activity!.removeStats()
                        self!.entries[entryIndex].activity!.updateAchievementsAfterDeletion()
                        self!.entries.remove(at: entryIndex)
                        
                        print("Firestore: activity succesfully removed")
                    }
                }
                print("Firestore: entry successfully removed!")
            }
        }
        
        
        
    }
    
    func deleteAllEntries() {
        do {
            try self.storage.deleteAllEntries()
        } catch let error {
            print("CoreData: failed to delete all entries, error: \(error)")
            return
        }
        
        self.entries.forEach({
            $0.activity!.removeStats()
            $0.activity!.updateAchievementsAfterDeletion()
        })
        self.entries = []
    }
    
    func setEntryActivity(entryId: String, newActivity: Activity) {
        let newActivityManagedObject = newActivity.toManagedObject(context: self.storage.persistentContainer.viewContext)
        
        let db = Firestore.firestore()
        let docRef = db.collection("activities").document(entryId)
        
        // create batch to update the data
        let batch = db.batch()
        
        let newData: [String : Any?] = ["distance" : newActivity.distance,
                                        "duration" : newActivity.duration,
                                        "repetitions" : newActivity.repetitions
                                        ]
        
        batch.updateData(newData as [AnyHashable : Any], forDocument: docRef)
        
        // commit the batch
        batch.commit() { [weak self] err in
            if let err = err {
                print("Firestore: Error updating entry activity \(err.localizedDescription)")
            } else {
                print("Firestore: Updating entry activity succeeded.")
                // save to core data
                do {
                    try self!.storage.deleteEntryActivity(entryId: entryId)
                    try self!.storage.updateEntry(entryId: entryId, newValue: newActivityManagedObject, keyPath: "activity")
                    // update entry object
                    let entry = self!.findById(entryId: entryId)
                    entry.activity!.updateAchievementsAfterDeletion()
                    entry.activity = newActivity
                    newActivity.updateAchievements()
                } catch let err {
                    print("CoreData: failed to update entry activity, \(err)")
                }
            }
        }
        
    }
    
    func setEntryDate(entryId: String, newDate: Date?) {
        let db = Firestore.firestore()
        let docRef = db.collection("entries").document(entryId)
                
        // create batch to update the data
        let batch = db.batch()
        
        let newData: [String : Any?] = ["date" : newDate]
        
        batch.updateData(newData as [AnyHashable : Any], forDocument: docRef)
        
        // commit the batch
        batch.commit() { [weak self] err in
            if let err = err {
                print("Firestore: Error updating entry date \(err.localizedDescription)")
            } else {
                print("Firestore: Updating entry date succeeded.")
                // save to core data
                do {
                    try self!.storage.updateEntry(entryId: entryId, newValue: newDate, keyPath: "date")
                    // update entry object
                    let entry = self!.findById(entryId: entryId)
                    entry.creationDate = newDate
                } catch let err {
                    print("CoreData: failed to update entry date, \(err)")
                }
            }
        }
              
        
    }

//    func updateEntryActivity(entryId: String, newDistance: Double?) {
//        guard let newD = newDistance else { return }
//        do {
//            try self.storage.updateEntryActivity(entryId: entryId, newValue: newD, keyPath: "distance")
//        } catch let error {
//            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
//            return
//        }
//
//        let activity = findById(entryId: entryId).activity
//        activity!.distance = newD
//    }
//
//    func updateEntryActivity(entryId: String, newRepetitions: Double?) {
//        guard let newR = newRepetitions else { return }
//        do {
//            try self.storage.updateEntryActivity(entryId: entryId, newValue: newR, keyPath: "repetitions")
//        } catch let error {
//            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
//            return
//        }
//
//        let activity = findById(entryId: entryId).activity
//        activity!.repetitions = newR
//    }
//
//    func updateEntryActivity(entryId: String, newDuration: Double?) {
//        guard let newDur = newDuration else { return }
//        do {
//            try self.storage.updateEntryActivity(entryId: entryId, newValue: newDur, keyPath: "duration")
//        } catch let error {
//            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
//            return
//        }
//
//        let activity = findById(entryId: entryId).activity
//        activity!.duration = newDur
//    }
    
    // MARK: - Core Data and Firestore
    
    func fetchFirestore(completion: (() -> ())?) {
        print("JUST LOGGED IN")
        // if user just logged in -> fetch entries for this username
        guard let currentUser = UserManager.shared.currentUser else { return }
        
        let db = Firestore.firestore()
        // fetch entries
        db.collection("entries").whereField("username", isEqualTo: currentUser.name)
            .getDocuments() { (querySnapshot, error) in
                if let err = error {
                    print("FireBase: failed to fetch entries: \(err.localizedDescription)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let entryId = data["id"] as! String
                        print("fetched entryID: \(entryId) from firestore")
                        let entryDate = (data["date"] as! Timestamp).dateValue()
                        // fetch activity by entryId
                        let docRef = db.collection("activities").document(entryId)
                        
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                if let data = document.data() {
                                    let activityName = data["name"] as! String
                                    let activityDistance = data["distance"] as? Double
                                    let activityDuration = data["duration"] as? Double
                                    let activityRepetitions = data["repetitions"] as? Double
                                    
                                    if let activityType = Activity.getActivityType(byName: activityName) {
                                        let entryActivity = activityType.init(duration: activityDuration, distance: activityDistance, repetitions: activityRepetitions)
                                        let entry = JournalEntry(id: entryId, activity: entryActivity, date: entryDate)
                                        do {
                                            try CoreDataStorage.storage.save(entry: entry)
                                        } catch let err {
                                            print("CoreData: failed to save an entry after fetch from Firestore, \(err)")
                                        }
                                        print("fetched entry and activity [\(entryId)] from firestore, appending")
                                        self.entries.append(entry)
                                        entryActivity.updateAchievements()
                                        activityType.updateCustomStats()
                                    }
                                        // if activity by that name does note exist (unprobable)
                                    else {
                                        return
                                    }
                                }
                            }
                            else {
                                print("Firestore: activity [ID: \(entryId)] does not exist")
                                return
                            }
                        }
                    }
                    self.entries.sort(by: {
                        $0.creationDate! > $1.creationDate!
                    })
                    if let _ = completion {
                        completion!()
                    }
                }
        }
    }
    
    func fetchCoreData() {
        print("fetching entries from CoreData")
        var fetched = [NSManagedObject]()
        do {
            fetched = try self.storage.fetchAll(entityName: "JournalEntryModel")
        } catch let error {
            print("- failed fetching entries, error: \(error)")
            return
        }
        
        self.entries = fetched.map({
            JournalEntry($0 as! JournalEntryModel)
            }).sorted(by: {
                $0.creationDate! > $1.creationDate!
            })
        self.entries.forEach({
            $0.activity!.updateAchievements()
            type(of: $0.activity!).updateCustomStats()
        })
        
    }
    
    // MARK: - Support
    
    func getEntriesForDifferentDays() -> Dictionary<[Int], [JournalEntry]> {
        var entriesDict: [[Int]: [JournalEntry]] = [:]
        
        for entry in self.entries {
            let dateComponents = [entry.creationDate!.get(.day), entry.creationDate!.get(.month), entry.creationDate!.get(.year)]
            
            if let _ = entriesDict[dateComponents] {
                entriesDict[dateComponents]!.append(entry)
            } else {
                entriesDict[dateComponents] = [entry]
            }
        }
        
        return entriesDict
    }

    private func contains(entry journalEntry: JournalEntry) -> Bool {
        let id = journalEntry.id
        for entry in self.entries {
            if entry.id == id {
                return true
            }
        }
        return false
    }
        
    private func findById(entryId: String) -> JournalEntry {
        return self.entries.filter {
            $0.id == entryId
        }.first!
    }
    
    func printEntryInfo(entryId: String) {
        let entry = findById(entryId: entryId)
        entry.printInfo()
    }
    
    
}

