//
//  JournalEntryTableViewActivityCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class JournalEntryTableViewActivityCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    weak var coordinator: Coordinator?
    var completion: ((Activity.Type?) -> ())?
    var cellLabel: String?
    
    var chosenActivity: Activity.Type? {
        didSet {
            guard let aT = self.chosenActivity else {
                self.label.text = "Activity"
                return
            }
//            self.cellLabel = activity.name
            self.label.text = aT.name
//            self.completion!(self.chosenActivity!)
        }
    }
    
    func chooseActivity(_ activityType: Activity.Type?) {
        guard let aT = activityType else { return }
        self.chosenActivity = aT
        self.completion!(aT)
        
    }
    
}
