//
//  Achievement.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 16.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class AchievementRecord: Achievement {
    
    var name: String
    var description: String
    var valueToAchieve: Double
    private var valueHistory: [Double] = []
    var currentValue: Double {
        didSet {
            if self.currentValue >= self.valueToAchieve {
                self.achieved = true
            }
            else {
                self.achieved = false
            }
        }
    }
    var achieved: Bool = false
    
    init(name: String, description: String = "", valueToAchieve: Double, currentValue: Double = 0) {
        self.name = name
        self.description = description
        self.valueToAchieve = valueToAchieve
        self.currentValue = currentValue
    }
    
    public func setCurrentValue(_ value: Double) {
        self.currentValue = max(self.currentValue, value)
        self.valueHistory.append(value)
        self.valueHistory.sort()
    }
    
    public func updateAfterDeletion(deletedValue: Double) {
        self.valueHistory.remove(at: self.valueHistory.firstIndex(of: deletedValue)!)
        if self.currentValue == deletedValue {
            self.currentValue = self.valueHistory.max() ?? 0
        }
    }
    
}
