//
//  RunningModel+CoreDataClass.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(RunningModel)
public class RunningModel: ActivityModel {

    override public func transform() -> Running {
        let running = Running(duration: self.duration, distance: self.distance)
        return running
    }
    
}
