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
    
    #warning("TODO: fix image")
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var labelActivityName: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    public func configureDetails() {
        guard let activity = self.entry?.activity else { return }
        
        self.labelActivityName.text = type(of: activity).name
                
        self.detailsLabel.text = activity.details
        self.detailsLabel.textColor = .gray
    }
    
    
}


