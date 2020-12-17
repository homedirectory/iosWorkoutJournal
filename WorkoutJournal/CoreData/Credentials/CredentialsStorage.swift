//
//  CredentialsStorage.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import CoreData


final class CredentialsStorage {
    
    static let storage = CredentialsStorage()
    
    enum Issue: Error {
        case noValue
    }
    
    func save(credentials: Credentials) throws {
        let entity = NSEntityDescription.entity(forEntityName: "CredentialsModel", in: persistentContainer.viewContext)!
        let managedObject = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
        managedObject.setValue(credentials.email, forKey: "email")
        managedObject.setValue(credentials.password, forKey: "password")

        saveContext()
        print("- saved credentials")
    }
    
    func fetchCredentials() throws -> Credentials? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CredentialsModel")
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        
        guard let managedObject = results.first else {
            return nil
        }
        let credentials = Credentials(email: managedObject.value(forKey: "email") as! String, password: managedObject.value(forKey: "password") as! String)
        
        return credentials
    }
    
    func deleteCredentials() throws {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CredentialsModel")
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        
        if results.isEmpty {
            print("no credentials to delete")
            return
        }
        
        for result in results {
            persistentContainer.viewContext.delete(result)
        }
        
        saveContext()
        print("- deleted credentials")
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Credentials")
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
    }
    
    
}

