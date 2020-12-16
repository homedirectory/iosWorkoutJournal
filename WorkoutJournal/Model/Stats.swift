//
//  Stats.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 06.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class Stats {
    
    var name: String
    var value: Double
    var image: UIImage?
    let units: StatsUnits
    
    init(name: String, value: Double, units: StatsUnits) {
        self.name = name
        self.value = value
        self.units = units
    }
    
    public func toString() -> String {
        var valueString = ""
        
        switch self.units {
            case .metres:
                valueString = String(format: "%.2f km", self.value/1000)
            case .seconds:
                let hours = floor(self.value / 3600)
                let minutes = (self.value - (hours * 3600)) / 60
                valueString = "\(Int(hours)) h \(Int(minutes)) min"
            case .numbers:
                valueString = String(Int(self.value))
        }
    
        return "\(self.name): \(valueString)"
    }
    
}

extension Stats {
    
    enum StatsUnits {
        case metres
        case seconds
        case numbers
    }
    
}
