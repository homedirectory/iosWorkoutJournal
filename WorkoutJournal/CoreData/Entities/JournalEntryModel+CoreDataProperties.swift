//
//  JournalEntryModel+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 02.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//
//

import Foundation
import CoreData


extension JournalEntryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JournalEntryModel> {
        return NSFetchRequest<JournalEntryModel>(entityName: "JournalEntryModel")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var activity: ActivityModel?

}
