//
//  PushUpsModel+CoreDataClass.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PushUpsModel)
public class PushUpsModel: ActivityModel {

    override public func transform() -> PushUps {
        let pushUps = PushUps(duration: nil, distance: nil, repetitions: self.repetitions)
        return pushUps
    }
    
}
