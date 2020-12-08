//
//  JournalEntryCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class JournalEntryCell: UITableViewCell {
    
    var entry: JournalEntry? {
        didSet {
            guard let activity = entry!.activity else {
                activityImage.isHidden = true
                labelActivityName.text = "[Empty]"
                labelActivityName.isHidden = true
                labelDistance.isHidden = true
                labelRepetitions.isHidden = true
                return
            }
            configureDetails(activity: activity)

        }
    }
    
    #warning("TODO: fix image")
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var labelActivityName: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelRepetitions: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.entry = nil
    }
    
    func configureDetails(activity: Activity) {
//        activityImage.image = UIImage(named: "il_570xN.1565327576_3yrc.jpg")
        labelActivityName.text = activity.name
        
        if let _ = activity.distance {
            labelDistance.text = activity.distanceString
        } else {
            labelDistance.isHidden = true
        }
        
        if let _ = activity.duration {
            labelDuration.text = activity.durationString
        } else {
            labelDuration.isHidden = true
        }
        
        if let _ = activity.repetitions {
            labelRepetitions.text = activity.repetitionsString
        } else {
            labelRepetitions.isHidden = true
        }
    }
    
    
}


extension UITableViewCell {
    static var id: String {
        String(describing: Self.self)
    }
}
