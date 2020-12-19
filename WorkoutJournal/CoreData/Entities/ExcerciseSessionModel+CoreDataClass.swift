//
//  ExcerciseSessionModel+CoreDataClass.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ExcerciseSessionModel)
public class ExcerciseSessionModel: ActivityModel {

    override public func transform() -> ExcerciseSession {
        let session = ExcerciseSession(duration: self.duration, distance: nil, repetitions: nil)
        return session
    }
    
}
