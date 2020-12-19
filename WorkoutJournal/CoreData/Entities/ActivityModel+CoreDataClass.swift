//
//  ActivityModel+CoreDataClass.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ActivityModel)
public class ActivityModel: NSManagedObject {

    open func transform() -> Activity {
        let activity = Activity(duration: self.duration, distance: self.distance, repetitions: self.repetitions)
        return activity
    }
    
}
