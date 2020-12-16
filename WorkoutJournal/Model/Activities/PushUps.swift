//
//  PushUps.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class PushUps: Activity {
    
    private static var __totalRepetitions = Stats(name: "Total push-ups", value: 0, units: .numbers)
    override class var totalRepetitions: Stats {
        get {
            return Self.__totalRepetitions
        }
    }
    
    static var achievements: [Achievement] = [AchievementIncreasing(name: "1k push-ups", description: "Total",                                                            valueToAchieve: 1000),
                                                        AchievementIncreasing(name: "10k push-ups", description: "Total", valueToAchieve: 10000)]
    
    override class var name: String {
        return "Push-ups"
    }
    
    internal required init(duration: Double? = nil, distance: Double? = nil, repetitions: Double? = 0) {
        super.init(duration: nil, distance: nil, repetitions: repetitions)
    }
    
    convenience init(repetitions: Double) {
        self.init(duration: nil, distance: nil, repetitions: repetitions)
    }
    
    override class func getStats() -> [Stats] {
        return [totalRepetitions]
    }
    
    public override func updateAchievements() {
        Self.achievements.forEach({
            $0.setCurrentValue(Self.totalRepetitions.value)
        })
    }
    
    public override func updateAchievementsAfterDeletion() {
        Self.achievements.forEach({
            $0.updateAfterDeletion(deletedValue: Self.totalRepetitions.value)
        })
    }
    
}
