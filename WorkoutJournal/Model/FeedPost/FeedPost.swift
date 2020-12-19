//
//  FeedPost.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


class FeedPost {
    
    var id: String
    var user: User
    var activityName: String
    var activityDetails: String
    var activityDate: Date
    var postedDate: Date
    
    // init for creating a post after it is fetched
    init(id: String, user: User, activityName: String, activityDetails: String, activityDate: Date, postedDate: Date = Date()) {
        self.id = id
        self.user = user
        self.activityName = activityName
        self.activityDetails = activityDetails
        self.activityDate = activityDate
        self.postedDate = postedDate
    }
    
    // init for creating a post
    init(user: User, journalEntry: JournalEntry, postedDate: Date = Date()) {
        self.id = UUID().uuidString
        self.user = user
        self.activityName = type(of: journalEntry.activity!).name
        self.activityDetails = journalEntry.activity!.details
        self.activityDate = journalEntry.creationDate!
        self.postedDate = postedDate
    }
    
}
