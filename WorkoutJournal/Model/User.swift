//
//  User.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class User {
    
    let id: Int
    var fullName: String
    
    init(id: Int, fullName: String) {
        self.id = id
        self.fullName = fullName
    }
}
