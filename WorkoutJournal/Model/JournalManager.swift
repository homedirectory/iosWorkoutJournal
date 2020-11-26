//
//  JournalManager.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class JournalManager {
    
    // MARK: - properties and init
    
    var entries: [JournalEntry]
    static let shared = JournalManager()
    
    private init() {
        self.entries = [JournalEntry]()
    }
        
    // MARK: - CRUD methods
    
    func createEntry(activity: Activity, date: Date) -> String {
        let entry = JournalEntry(activity: activity, date: date)
        entries.append(entry)
        return entry.id
    }
    
    func deleteEntry(entryId: String) {
        guard let entryIndex = self.entries.firstIndex(where: {
            $0.id == entryId
        }) else {
            return
        }
        self.entries.remove(at: entryIndex)
    }
    
    func setEntryActivity(entryId: String, newActivity: Activity) {
        let entry = findById(entryId: entryId)
        entry.activity = newActivity
    }
    
    func setEntryDate(entryId: String, newDate: Date) {
        let entry = findById(entryId: entryId)
        entry.date = newDate
    }
    
    func setEntryActivityDistance(entryId: String, newDistance: Double) {
        guard var entryActivity = findById(entryId: entryId).activity as? DistanceActivity else {
            return
        }
        entryActivity.distance = newDistance
    }
    
    func setEntryActivityRepetitions(entryId: String, newRepetitions: Int) {
        guard var entryActivity = findById(entryId: entryId).activity as? RepetitionActivity else {
            return
        }
        entryActivity.repetitions = newRepetitions
    }
    
    func setEntryActivityDuration(entryId: String, newDuration: Double) {
        guard var entryActivity = findById(entryId: entryId).activity as? DurationActivity else {
            return
        }
        entryActivity.duration = newDuration
    }
    
    // MARK: - Supporting methods
    
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

