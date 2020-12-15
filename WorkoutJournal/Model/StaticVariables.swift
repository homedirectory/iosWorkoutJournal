//
//  StaticVariables.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


public class StaticVariables {
    
    static let defaultActivityTypes = [Running.self, PushUps.self, PullUps.self, Plank.self, ExcerciseSession.self]
    
    static let defaultActivityNames = StaticVariables.defaultActivityTypes.map({
        StaticVariables.activityTypeToString(activityType: $0)
    })
    
    static func activityTypeToString(activityType: Activity.Type) -> String {
        return String(describing: activityType).components(separatedBy: ".").last!
    }
    
    static func getTotalTimeSpentOnActivities() -> Stats {
        return Stats(name: "Total time spent excercising", value: Running.totalDuration.value! + Plank.totalDuration.value! + ExcerciseSession.totalDuration.value!, units: .seconds)
    }
    
}
