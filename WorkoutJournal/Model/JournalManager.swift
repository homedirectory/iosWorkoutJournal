//
//  JournalManager.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import CoreData


class JournalManager {
    
    enum JournalManagerEror: Error {
        case WrongActivityType
        case EntryIdAlreadyExists
    }
    
    // MARK: - properties and init
    private var lastId: Int
    var entries: [JournalEntry]
    private var storage: CoreDataStorage?
    static let shared = JournalManager()
    
    private init() {
        self.entries = [JournalEntry]()
        self.lastId = 0
        self.storage = CoreDataStorage()
        self.fetch()
    }
        
    // MARK: - CRUD
    
    func createEntry(activity: Activity, date: Date) {
        let entry = JournalEntry(id: self.lastId + 1, activity: activity, date: date)
        
        if self.contains(entry: entry) {
            print("- failed creating, error: entryId already exists")
            return
        }
        
        entries.insert(entry, at: 0)
        do {
            try self.storage?.save(entry: entry)
        } catch let error {
            print("failed saving to core data: \(error)")
        }
        self.lastId += 1
        print("- saved to core data")
    }
    
    func deleteEntry(entryId: Int) {
        do {
            try self.storage?.deleteEntry(entryId: entryId)
        } catch let error {
            print("- failed deleting, error: \(error)")
            return
        }
        
        guard let entryIndex = self.entries.firstIndex(where: {
            $0.id == entryId
        }) else {
            print("- failed deleting ID: \(entryId), error: index was not found")
            return
        }
        self.entries[entryIndex].activity!.removeStats()
        self.entries.remove(at: entryIndex)
    }
    
    func deleteAllEntries() {
        do {
            try self.storage?.deleteAllEntries()
        } catch let error {
            print("- failed deleting all, error: \(error)")
            return
        }
        
        self.entries.forEach({
            $0.activity!.removeStats()
        })
        self.entries = []
        self.lastId = 0
    }
    
    func setEntryActivity(entryId: Int, newActivity: Activity) {
        print(type(of: newActivity))
        let newActivityManagedObject = newActivity.toManagedObject(context: self.storage!.persistentContainer.viewContext)
        print(type(of: newActivityManagedObject))

        do {
            try self.storage!.deleteEntryActivity(entryId: entryId)
            try self.storage!.updateEntry(entryId: entryId, newValue: newActivityManagedObject, keyPath: "activity")
        } catch let error {
            print("- updating Entry (ID: \(entryId), error: \(error)")
            return
        }

        let entry = findById(entryId: entryId)
        entry.activity = newActivity
    }
    
    func setEntryDate(entryId: Int, newDate: Date?) {
        do {
            try self.storage!.updateEntry(entryId: entryId, newValue: newDate, keyPath: "date")
        } catch let error {
            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
            return
        }
        
        let entry = findById(entryId: entryId)
        entry.creationDate = newDate
    }
    
    func updateEntryActivity(entryId: Int, newDistance: Double?) {
        do {
            try self.storage!.updateEntryActivity(entryId: entryId, newValue: newDistance, keyPath: "distance")
        } catch let error {
            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
            return
        }
        
        let activity = findById(entryId: entryId).activity
        activity!.distance = newDistance
    }
    
    func updateEntryActivity(entryId: Int, newRepetitions: Int?) {
        do {
            try self.storage!.updateEntryActivity(entryId: entryId, newValue: newRepetitions, keyPath: "repetitions")
        } catch let error {
            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
            return
        }
        
        let activity = findById(entryId: entryId).activity
        activity!.repetitions = newRepetitions
    }
    
    func updateEntryActivity(entryId: Int, newDuration: Double?) {
        do {
            try self.storage!.updateEntryActivity(entryId: entryId, newValue: newDuration, keyPath: "duration")
        } catch let error {
            print("- failed updating Entry (ID: \(entryId)), error: \(error)")
            return
        }
        
        let activity = findById(entryId: entryId).activity
        activity!.duration = newDuration
    }
    
    // MARK: - Core Data
    
    func fetch() {
        var fetched = [NSManagedObject]()
        do {
            fetched = try self.storage!.fetchAll(entityName: "JournalEntryModel")
        } catch let error {
            print("- failed fetching entries, error: \(error)")
            return
        }

        self.entries = fetched.map({
            JournalEntry($0 as! JournalEntryModel)
            }).sorted(by: {
                $0.creationDate! > $1.creationDate!
            })
        self.lastId = self.entries.map({
            $0.id
            }).max() ?? 0
    }
    
    // MARK: - Support
    
    private func contains(entry journalEntry: JournalEntry) -> Bool {
        let id = journalEntry.id
        for entry in self.entries {
            if entry.id == id {
                return true
            }
        }
        return false
    }
        
    private func findById(entryId: Int) -> JournalEntry {
        return self.entries.filter {
            $0.id == entryId
        }.first!
    }
    
    func printEntryInfo(entryId: Int) {
        let entry = findById(entryId: entryId)
        entry.printInfo()
    }
    
    
}

