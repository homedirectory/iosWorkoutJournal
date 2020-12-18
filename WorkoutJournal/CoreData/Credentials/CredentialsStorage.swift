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
    
    private init() {
        
    }
    
    enum Issue: Error {
        case noValue
    }
    
    func save(user: User) throws {
        let entityUser = NSEntityDescription.entity(forEntityName: "UserModel", in: persistentContainer.viewContext)!
        let managedObjectUser = NSManagedObject(entity: entityUser, insertInto: persistentContainer.viewContext)
        
        let entityCredentials = NSEntityDescription.entity(forEntityName: "CredentialsModel", in: persistentContainer.viewContext)!
        let managedObjectCredentials = NSManagedObject(entity: entityCredentials, insertInto: persistentContainer.viewContext)
        
        guard let credentials = user.credentials else {
            throw CredentialsStorageError.UserCredentialsNotFound
        }
        
        managedObjectCredentials.setValue(credentials.email, forKey: "email")
        managedObjectCredentials.setValue(credentials.password, forKey: "password")
        
        managedObjectUser.setValue(user.name, forKey: "name")
        managedObjectUser.setValue(user.following, forKey: "following")
        managedObjectUser.setValue(managedObjectCredentials, forKey: "credentials")

        saveContext()
        print("CoreData: saved credentials")
    }
    
    func updateUser(value: Any, forKey key: String) throws {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserModel")
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        
        guard let userManagedObject = results.first else { return }
        
        userManagedObject.setValue(value, forKey: key)
        
        saveContext()
        print("CoreData: updated user")
    }
    
    func fetchUser() throws -> User? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserModel")
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        
        guard let userManagedObject = results.first else {
            return nil
        }
        let credentialsManagedObject = userManagedObject.value(forKey: "credentials") as! NSManagedObject
        let credentials = Credentials(email: credentialsManagedObject.value(forKey: "email") as! String, password: credentialsManagedObject.value(forKey: "password") as! String)
        let user = User(name: userManagedObject.value(forKey: "name") as! String, following: userManagedObject.value(forKey: "following") as! [String], credentials: credentials)
        
        return user
    }
    
    func deleteUserAndCredentials() throws {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserModel")
        let results = try persistentContainer.viewContext.fetch(fetchRequest)
        
        if results.isEmpty {
            print("CoreData: no credentials to delete")
            return
        }
        
        for result in results {
            persistentContainer.viewContext.delete(result)
        }
        
        saveContext()
        print("CoreData: deleted user and credentials")
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


extension CredentialsStorage {
    
    enum CredentialsStorageError: Error {
        case UserCredentialsNotFound
    }
    
}

