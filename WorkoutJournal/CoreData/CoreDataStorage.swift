//
//  CoreDataStorage.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 01.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import CoreData


final class CoreDataStorage {
    
    static let storage = CoreDataStorage()
    
    private init() {
        
    }
    
    enum Issue: Error {
        case noValue
    }
    
    func save(entry: JournalEntry) throws {
        let activityEntity = NSEntityDescription.entity(forEntityName: entry.activity!.entityName, in: persistentContainer.viewContext)!
        let activityManagedObject = NSManagedObject(entity: activityEntity, insertInto: persistentContainer.viewContext)
        activityManagedObject.setValue(entry.activity!.duration, forKey: "duration")
        activityManagedObject.setValue(entry.activity!.distance, forKey: "distance")
        activityManagedObject.setValue(entry.activity!.repetitions, forKey: "repetitions")

        let entryEntity = NSEntityDescription.entity(forEntityName: "JournalEntryModel", in: persistentContainer.viewContext)!
        let entryManagedObject = NSManagedObject(entity: entryEntity, insertInto: persistentContainer.viewContext)
        entryManagedObject.setValue(entry.id, forKey: "id")
        entryManagedObject.setValue(entry.creationDate, forKey: "date")
        entryManagedObject.setValue(activityManagedObject, forKey: "activity")

        print("CoreData: saved an entry")
        saveContext()
    }
    
    func fetchAll(entityName: String) throws -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        
        print("CoreData: fetched \(results.count) entries")
        return results
    }
    
    func fetch(entityName: String, id: String) throws -> NSManagedObject {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [id])
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        guard let managedObject = results.first else {
            throw Issue.noValue
        }
        return managedObject
    }
    
    func updateEntry(entryId: String, newValue: Any?, keyPath: String) throws {
        let managedObject = try self.fetch(entityName: "JournalEntryModel", id: entryId)
        
        managedObject.setValue(newValue, forKey: keyPath)
        saveContext()
        print("CoreData: updated an entry(ID:\(entryId))")
    }
    
    func updateEntryActivity(entryId: String, newValue: Any?, keyPath: String) throws {
        let managedObject = try self.fetch(entityName: "JournalEntryModel", id: entryId)
        
        let activity: NSManagedObject = managedObject.value(forKey: "activity") as! NSManagedObject
        activity.setValue(newValue, forKey: keyPath)
        saveContext()
        print("CoreData: updated an entry activity(ID:\(entryId))")
    }
        
    func delete(objects: [NSManagedObject]) {
        if objects.isEmpty {
            print("nothing to delete bruv")
            return
        }
        
        for object in objects {
            persistentContainer.viewContext.delete(object)
        }
        
        saveContext()
        print("CoreData: deleted \(objects.count) entries")
    }
    
    func deleteEntry(entryId: String) throws {
        let result = try self.fetch(entityName: "JournalEntryModel", id: entryId)
        delete(objects: [result])
    }
    
    func deleteAllEntries() throws {
        let results = try self.fetchAll(entityName: "JournalEntryModel")
        delete(objects: results)
    }
    
    func deleteEntryActivity(entryId: String) throws {
        let result = try self.fetch(entityName: "JournalEntryModel", id: entryId)
        let activity = result.value(forKey: "activity") as! NSManagedObject
        delete(objects: [activity])
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        
        let container = NSPersistentContainer(name: "WorkoutJournal")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        print("saved context")
    }
    
    
}

