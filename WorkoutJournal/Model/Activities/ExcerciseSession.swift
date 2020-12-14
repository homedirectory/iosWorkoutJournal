//
//  ExcerciseSession.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class ExcerciseSession: Activity {
    
    private static var __totalDuration = Stats<Double>(name: "Total Ex. Sessions duration: ", value: 0)
    override class var totalDuration: Stats<Double> {
        get {
            return Self.__totalDuration
        }
    }
    
    override class var name: String {
        return "Excercise Session"
    }
    
    internal required init(duration: Double? = 0, distance: Double? = nil, repetitions: Double? = nil) {
        super.init(duration: duration, distance: nil, repetitions: nil)
    }
    
    convenience init(duration: Double) {
        self.init(duration: duration, distance: nil, repetitions: nil)
    }
    
}
