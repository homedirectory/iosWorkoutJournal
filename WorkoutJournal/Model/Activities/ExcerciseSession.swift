//
//  ExcerciseSession.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class ExcerciseSession: Activity {
    
    private static var __totalDuration = Stats(name: "Total Ex. Sessions duration: ", value: 0, units: .seconds)
    override class var totalDuration: Stats {
        get {
            return Self.__totalDuration
        }
    }
    
    static var achievements: [Achievement] = [AchievementIncreasing(name: "100 hours of ex. sessions", description: "Total duration of ex. sessions", valueToAchieve: 360000, units: .seconds)]
    
    override class var name: String {
        return "Excercise Session"
    }
    
    override class var imageName: String {
        return "excercise_session"
    }
    
    internal required init(duration: Double? = 0, distance: Double? = nil, repetitions: Double? = nil) {
        super.init(duration: duration, distance: nil, repetitions: nil)
    }
    
    convenience init(duration: Double) {
        self.init(duration: duration, distance: nil, repetitions: nil)
    }
    
    override class func getStats() -> [Stats] {
        return [totalDuration]
    }
    
    public override func updateAchievements() {
        Self.achievements[0].setCurrentValue(Self.totalDuration.value)
    }
    
    public override func updateAchievementsAfterDeletion() {
        Self.achievements[0].setCurrentValue(Self.totalDuration.value)
    }
    
    override func getAchievements() -> [Achievement] {
          return Self.achievements
      }
    
}
