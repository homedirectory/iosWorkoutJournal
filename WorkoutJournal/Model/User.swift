//
//  User.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class User {
    
    let id: String
    var fullName: String
    
    static var defaultUser: User {
        return User(id: "123", fullName: "John")
    }
    
    static var defaultUserImageName: String {
        return "person.circle.fill"
    }
    
    init(id: String, fullName: String) {
        self.id = id
        self.fullName = fullName
    }
    
}
