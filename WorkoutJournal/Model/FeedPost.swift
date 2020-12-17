//
//  FeedPost.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class FeedPost {
    
    var user: User
    var activityName: String
    var activityDetails: String
    var activityDate: Date
    var postedDate: Date
    
    init(user: User, activityName: String, activityDetails: String, activityDate: Date, postedDate: Date = Date()) {
        self.user = user
        self.activityName = activityName
        self.activityDetails = activityDetails
        self.activityDate = activityDate
        self.postedDate = postedDate
    }
    
    init(user: User, journalEntry: JournalEntry, postedDate: Date = Date()) {
        self.user = user
        self.activityName = type(of: journalEntry.activity!).name
        self.activityDetails = journalEntry.activity!.details
        self.activityDate = journalEntry.creationDate!
        self.postedDate = postedDate
    }
    
}
