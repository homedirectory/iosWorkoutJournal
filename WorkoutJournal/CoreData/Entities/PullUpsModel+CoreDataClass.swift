//
//  PullUpsModel+CoreDataClass.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PullUpsModel)
public class PullUpsModel: ActivityModel {

    override public func transform() -> PullUps {
        let pullUps = PullUps(repetitions: self.repetitions)
        return pullUps
    }
    
}
