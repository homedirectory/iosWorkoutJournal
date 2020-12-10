//
//  JournalEntryTableViewDateCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

#warning("TODO: complete this cell with date picker")
class JournalEntryTableViewDateCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: Date?
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}

// MARK: - IBActions

extension JournalEntryTableViewDateCell {
    
    @IBAction func datePickerAction(_ sender: Any) {
    }
    
}
