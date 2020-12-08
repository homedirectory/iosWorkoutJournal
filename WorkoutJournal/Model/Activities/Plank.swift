//
//  Plank.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class Plank: Activity {
    
    private static var __totalDuration = Stats<Double>(name: "Total plank time", value: 0)
    override class var totalDuration: Stats<Double> {
        get {
            return Self.__totalDuration
        }
    }
    
    internal required init(name: String, duration: Double? = nil, distance: Double? = nil, repetitions: Int? = nil) {
        super.init(name: "Plank", duration: duration, distance: nil, repetitions: nil)
    }
    
    convenience init(duration: Double) {
        self.init(name: "Plank", duration: duration, distance: nil, repetitions: nil)
    }
    
}
