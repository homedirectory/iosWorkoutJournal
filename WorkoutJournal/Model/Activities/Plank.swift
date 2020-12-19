//
//  Plank.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class Plank: Activity {
    
    private static var __totalDuration = Stats(name: "Total plank time", value: 0, units: .seconds)
    override class var totalDuration: Stats {
        get {
            return Self.__totalDuration
        }
    }
    
    static var achievements: [Achievement] = [AchievementRecord(name: "10 minutes plank", description: "Max plank duration", valueToAchieve: 600, units: .seconds),
                                              AchievementRecord(name: "30 minutes plank", description: "Max plank duration", valueToAchieve: 1800, units: .seconds),
                                              AchievementRecord(name: "60 minutes plank O_o", description: "Max plank duration", valueToAchieve: 3600, units: .seconds),
                                              AchievementIncreasing(name: "Reach 1000 minutes of plank", description: "Total time spent doing plank", valueToAchieve: 60000, units: .seconds)]
    
    override class var name: String {
        return "Plank"
    }
    
    override class var imageName: String {
        return "plank"
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
        for i in 0...2 {
            Self.achievements[i].setCurrentValue(self.duration!)
        }
        Self.achievements[3].setCurrentValue(Self.totalDuration.value)
    }
    
    override func getAchievements() -> [Achievement] {
          return Self.achievements
      }
    
}
