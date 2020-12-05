//
//  Running.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class Running: Activity {
    
    private override init(name: String, duration: Double? = nil, distance: Double? = nil, repetitions: Int? = nil) {
        super.init(name: name, duration: duration, distance: distance, repetitions: nil)
    }
    
    convenience init(duration: Double, distance: Double) {
        self.init(name: "Running", duration: duration, distance: distance, repetitions: nil)
    }
    
}
