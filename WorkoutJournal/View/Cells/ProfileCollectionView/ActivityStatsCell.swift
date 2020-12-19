//
//  ActivityStatsCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 15.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class ActivityStatsCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var activityType: Activity.Type? {
        didSet {
            guard let aT = self.activityType else { return }
            self.label.text = aT.name
        }
    }

}
