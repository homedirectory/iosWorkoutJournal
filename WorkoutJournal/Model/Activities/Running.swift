//
//  Running.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class Running: Activity {
    
    private static var __totalDuration = Stats(name: "Total running time", value: 0, units: .seconds)
    override class var totalDuration: Stats {
        get {
            return Self.__totalDuration
        }
    }
    
    private static var __totalDistance = Stats(name: "Total running distance", value: 0, units: .metres)
    override class var totalDistance: Stats {
        get {
            return Self.__totalDistance
        }
    }
    
    static var totalRuns = Stats(name: "Total runs", value: 0, units: .numbers)
    
    static var achievements: [Achievement] = [AchievementRecord(name: "A half-marathon!", description: "Longest distance ran", valueToAchieve: 21000, units: .metres),
                                              AchievementRecord(name: "A full marathon!!!", description: "Longest distance ran", valueToAchieve: 42000, units: .metres),
                                              AchievementRecord(name: "Pro runner confirmed", description: "Max avg. pace reached", valueToAchieve: 15, units: .kmPerHour)]
    
    override class var name: String {
        return "Running"
    }
    
    internal required init(duration: Double? = 0, distance: Double? = 0, repetitions: Double? = nil) {
        super.init(duration: duration, distance: distance, repetitions: nil)
    }
    
    convenience init(duration: Double, distance: Double) {
        self.init(duration: duration, distance: distance, repetitions: nil)
    }
    
    override class func getStats() -> [Stats] {
        return [totalDuration, totalDistance, totalRuns]
    }
    
    override public func removeStats() {
        super.removeStats()
        Self.totalRuns.value -= 1
    }
    
    override func updateAchievements() {
        Self.achievements[0].setCurrentValue(self.distance!)
        Self.achievements[1].setCurrentValue(self.distance!)
        Self.achievements[2].setCurrentValue((self.distance! / self.duration!) * 3.6)
    }
    
    override func updateAchievementsAfterDeletion() {
        Self.achievements[0].updateAfterDeletion(deletedValue: self.distance!)
        Self.achievements[1].updateAfterDeletion(deletedValue: self.distance!)
        Self.achievements[2].updateAfterDeletion(deletedValue: (self.distance! / self.duration!) * 3.6)
    }
    
    override func getAchievements() -> [Achievement] {
        return Self.achievements
    }
    
    override class func updateCustomStats() {
        Self.totalRuns.value += 1
    }
    
}
