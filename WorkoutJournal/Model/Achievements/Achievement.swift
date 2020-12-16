//
//  Achievement.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 16.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


protocol Achievement {
    
    var name: String { get set }
    var description: String { get set }
    var currentValue: Double { get set }
    var valueToAchieve: Double { get set }
    var achieved: Bool { get }
    
    func setCurrentValue(_ value: Double)
    
    func updateAfterDeletion(deletedValue: Double)
    
}
