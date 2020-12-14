//
//  JournalEntryCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

#warning("TODO: Fix date so it is actually displayed, n00b")
class JournalEntryCell: UITableViewCell {
    
    var entry: JournalEntry?
//        didSet {
//            print("DIDSET")
//            guard let activity = entry!.activity else { return }
//            configureDetails(activity: activity)
//        }
//    }
    
    #warning("TODO: fix image")
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var labelActivityName: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRepetitions: UILabel!
    
    func configureDefaults() {
        self.labelActivityName.text = ""
        self.labelDistance.text = "Distance"
        self.labelDuration.text = "Duration"
        self.labelRepetitions.text = "Repetitions"
        
        self.labelDistance.isHidden = true
        self.labelDuration.isHidden = true
        self.labelRepetitions.isHidden = true
    }
    
    public func configureDetails() {
        guard let activity = self.entry?.activity else { return }
        self.configureDefaults()
        
        self.labelActivityName.text = type(of: activity).name
        
        if let _ = activity.distance {
            self.labelDistance.text = activity.getDistanceString()
            self.labelDistance.isHidden = false
        }
        
        if let _ = activity.duration {
            print(activity.duration)
            self.labelDuration.text = activity.getDurationString()
            self.labelDuration.isHidden = false
        }
        
        if let _ = activity.repetitions {
            self.labelRepetitions.text = activity.getRepetitionsString()
            self.labelRepetitions.isHidden = false
        }
    }
    
    
}


