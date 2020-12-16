//
//  JournalEntryTableViewDateCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class JournalEntryTableViewDateCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    
    var date: Date?
    let datePicker = UIDatePicker()
    var endEditingHandler: ((Date?) -> ())?
    
    func setup(date: Date?, handler: @escaping (Date?) -> ()) {
        self.date = date
        self.endEditingHandler = handler
        
        if let date = self.date {
            self.datePicker.date = date
            self.displayDate()
        }
        else {
            self.textField.text = "Today"
            self.datePicker.date = Date()
        }
                
        self.datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(displayDate))
        toolbar.setItems([doneButton], animated: true)
        
        self.textField.font = .systemFont(ofSize: 20)
        self.textField.inputAccessoryView = toolbar
        self.textField.inputView = self.datePicker
    }
    
    @objc func displayDate() {
        self.date = self.datePicker.date
        let dateComponents = [self.datePicker.date.get(.day), self.datePicker.date.get(.month), self.datePicker.date.get(.year)]
        self.textField.text = StaticVariables.dateComponentsToString(dateComponents)
        self.endEditingHandler!(self.date)
    }
    
}
