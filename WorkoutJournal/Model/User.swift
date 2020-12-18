//
//  User.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import FirebaseFirestore


class User {
    
    var name: String
    var following: [String]
    
    static var currentUser: User? = nil
    
    static var defaultUser: User {
        return User(name: "John", following: [])
    }
    
    static var defaultUserImageName: String {
        return "person.circle.fill"
    }
    
    init(name: String, following: [String]) {
        self.name = name
        self.following = following
    }
    
    static func setCurrentUser(withUID: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(withUID)
        let followingRef = docRef.collection("following")

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let name = data!["name"] as! String
                
                User.currentUser = User(name: name, following: [])
               
                followingRef.getDocuments { (querySnapshot, error) in
                    print("getting following")
                    if let err = error {
                        print("- Error getting documents from collection [following]: \(err.localizedDescription)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID)")
                            User.currentUser!.following.append(document.documentID)
                        }
                    }
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    static func logOutCurrentUser() {
        User.currentUser = nil
    }
    
}
