//
//  ActivityTypeCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class ActivityTypeCell: UITableViewCell {
    
    @IBOutlet weak var activityLabel: UILabel!
    
    var activityType: Activity.Type? {
        didSet {
            self.activityLabel.text = StaticVariables.activityTypeToString(activityType: self.activityType!)
        }
    }
    
}
