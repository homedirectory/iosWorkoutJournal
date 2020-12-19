//
//  PlankModel+CoreDataClass.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(PlankModel)
public class PlankModel: ActivityModel {

    override public func transform() -> Plank {
        let plank = Plank(duration: self.duration, distance: nil, repetitions: nil)
        return plank
    }
    
}
