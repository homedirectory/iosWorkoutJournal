//
//  UserManager.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 18.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import FirebaseFirestore


class UserManager {
    
    var currentUser: User? = nil
    private var credentialsStorage: CredentialsStorage = CredentialsStorage.storage
    
    static let shared = UserManager()
    
    private init() {
        
    }
    
    // called after signing up
    func setCurrentUser(withName name: String, withCredentials credentials: Credentials) {
        self.currentUser = User(name: name, following: [], credentials: credentials)
        self.fetchFollowing(forUser: self.currentUser!, saveUser: true)
    }
    
    // called after logging in
    func setCurrentUser(withName name: String, withFollowing following: [String], withCredentials credentials: Credentials) {
        self.currentUser = User(name: name, following: following, credentials: credentials)
        do {
            try self.credentialsStorage.save(user: self.currentUser!)
        } catch let err {
            print("failed to save current user to CoreData, \(err)")
        }
    }
    
    func logOutCurrentUser() {
        self.currentUser = nil
        // try to delete saved credentials
        do {
            try CredentialsStorage.storage.deleteUserAndCredentials()
        } catch let err {
            print("- failed to delete credentials: \(err)")
        }
    }
    
    func fetchFollowing(forUser user: User, saveUser: Bool, postFetcher: (() -> ())? = nil) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(user.name)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    user.following = data["following"] as! [String]
                    if let _ = postFetcher {
                        postFetcher!()
                    }
                    if saveUser {
                        // save user to CoreData
                        do {
                            try self.credentialsStorage.save(user: user)
                        } catch let err {
                            print("CoreData: failed to save current user, \(err)")
                        }
                    }
                }
            } else {
                print("User [\(user.name)] does not exist")
            }
        }
        
    }
    
    func findUser(byName name: String, assignUserHandler: @escaping (User?) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(name)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data() {
                    let userName = data["name"] as! String
                    let following = data["following"] as! [String]
                    let user = User(name: userName, following: following)
                    assignUserHandler(user)
                }
                else {
                    assignUserHandler(nil)
                }
            }
            else {
                assignUserHandler(nil)
            }
        }
    }
    
    func updateFollowingAndSave(user: User, followingStatus: Bool, completion: @escaping () -> ()) {
        guard let currentUser = self.currentUser else {
            print("- current user does not exist")
            return
        }
        
        let userName = user.name
        
        if followingStatus {
            if userName == currentUser.name {
                print("- users can't follow themselves")
                return
            }
            
            if currentUser.following.contains(userName) {
                print("- this user is already followed")
                return
            }
        }
        
        
        var arrayToWrite: [String] = []
        
        if followingStatus {
            arrayToWrite = currentUser.following + [userName]
        }
        else {
            if let index = currentUser.following.firstIndex(of: userName) {
                currentUser.following.remove(at: index)
            }
            arrayToWrite = currentUser.following
        }
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(currentUser.name)
        
        // create batch to update the data
        let batch = db.batch()
        
        batch.updateData(["following": arrayToWrite], forDocument: docRef)
        
        // commit the batch
        batch.commit() { err in
            if let err = err {
                print("Firestore: Error updating user \(err)")
            } else {
                print("Firestore: Updating user succeeded.")
                // save to core data
                do {
                    try self.credentialsStorage.updateUser(value: arrayToWrite, forKey: "following")
                    self.currentUser!.following = arrayToWrite
                    completion()
                } catch let err {
                    print("CoreData: failed to update user, \(err)")
                }
            }
        }
    }
    
}
