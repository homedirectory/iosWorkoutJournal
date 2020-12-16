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
        let valueString = Stats.valueInStatsUnitsToString(self.value, units: self.units)
        
        return "\(self.name): \(valueString)"
    }
    
}

extension Stats {
    
    enum StatsUnits {
        case metres
        case seconds
        case numbers
        case kmPerHour
    }
    
    static func valueInStatsUnitsToString(_ value: Double, units: StatsUnits) -> String {
        var valueString = ""
        
        switch units {
            case .metres:
                valueString = value.kmString
            case .seconds:
                valueString = value.secondsString
            case .numbers:
                valueString = String(Int(value))
            case .kmPerHour:
                valueString = value.kmPerHourString
        }
        
        return valueString
    }
    
}
