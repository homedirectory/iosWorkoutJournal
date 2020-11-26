//
//  Running.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 26.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class Running: DistanceActivity, DurationActivity {
    
    var distance: Double
    var duration: Double
    
    init(distance: Double, duration: Double) {
        self.distance = distance
        self.duration = duration
    }
    
    func toString() -> String {
        return "\(self.name) - \(self.distance / 1000) km, \(self.duration / 60) minutes"
    }
        
}
