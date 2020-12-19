//
//  Activity.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


protocol Activity {
    
    var name: String {get}
    
    func toString() -> String
    
}


extension Activity {
    
    var name: String {
        get {
            let str = String(describing: self)
            let name = str.components(separatedBy: ".").last ?? str
            return name
        }
    }

}
