//
//  PushUps.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class PushUps: Activity {
    
    private static var __totalRepetitions = Stats<Int>(name: "Total push-ups", value: 0)
    override class var totalRepetitions: Stats<Int> {
        get {
            return Self.__totalRepetitions
        }
    }
    
    private override init(name: String, duration: Double? = nil, distance: Double? = nil, repetitions: Int? = nil) {
        super.init(name: name, duration: nil, distance: nil, repetitions: repetitions)
    }
    
    convenience init(repetitions: Int) {
        self.init(name: "Push-ups", duration: nil, distance: nil, repetitions: repetitions)
    }
    
}
