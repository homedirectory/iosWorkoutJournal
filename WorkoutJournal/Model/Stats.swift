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
    
    var value: Double?
    var image: UIImage?
    
    init(name: String, value: Double, units: StatsUnits) {
        self.name = name
        self.value = value
    }
    
}
