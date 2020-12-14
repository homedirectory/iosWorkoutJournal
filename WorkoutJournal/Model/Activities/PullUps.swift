//
//  PullUps.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class PullUps: Activity {
    
    private static var __totalRepetitions = Stats<Double>(name: "Total pull-ups", value: 0)
    override class var totalRepetitions: Stats<Double> {
        get {
            return Self.__totalRepetitions
        }
    }
    
    override class var name: String {
        return "Pull-ups"
    }
    
    internal required init(duration: Double? = nil, distance: Double? = nil, repetitions: Double? = 0) {
        super.init(duration: nil, distance: nil, repetitions: repetitions)
    }
    
    convenience init(repetitions: Double) {
        self.init(duration: nil, distance: nil, repetitions: repetitions)
    }
    
}
