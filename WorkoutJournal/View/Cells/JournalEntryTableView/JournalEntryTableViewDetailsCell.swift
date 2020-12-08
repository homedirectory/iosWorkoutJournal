//
//  JournalEntryTableViewDetailsCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class JournalEntryTableViewDetailsCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    func setup(initialText: String) {
        self.textField.delegate = self
        self.textField.placeholder = initialText
        self.selectionStyle = .none
    }
    
    func unlockTextField() {
        self.textField.isEnabled = true
    }
    
    func getText() -> String {
        return self.textField.text!
    }
    
    func getNumber() -> Double? {
        return Double(self.textField.text!)
    }
}

// MARK: - UITextFieldDelegate

extension JournalEntryTableViewDetailsCell {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
}
