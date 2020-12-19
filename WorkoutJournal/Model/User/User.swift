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
    var credentials: Credentials?
    
    static var currentUser: User? = nil
    
    static var defaultUser: User {
        return User(name: "John", following: [], credentials: nil)
    }
    
    static var defaultUserImageName: String {
        return "person.circle.fill"
    }
    
    init(name: String, following: [String], credentials: Credentials? = nil) {
        self.name = name
        self.following = following
        self.credentials = credentials
    }
    
}
