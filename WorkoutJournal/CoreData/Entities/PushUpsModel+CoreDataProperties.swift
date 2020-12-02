//
//  PushUpsModel+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData


extension PushUpsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PushUpsModel> {
        return NSFetchRequest<PushUpsModel>(entityName: "PushUpsModel")
    }


}
