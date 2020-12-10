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
    
    weak var coordinator: Coordinator?
    var completion: ((Activity.Type?) -> ())?
    var cellLabel: String?
    var chosenActivity: Activity.Type? {
        didSet {
            print("chosen activity was set to: ", chosenActivity ?? "wut")
            self.cellLabel = StaticVariables.activityTypeToString(activityType: self.chosenActivity!)
            self.label.text = cellLabel
            self.completion!(self.chosenActivity!)
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //self.label.text = "Activity"
    }
    
//    func selectAction() {
//        self.coordinator!.pushActivitiesListViewController(trigerredCell: self)
//    }
    
}
