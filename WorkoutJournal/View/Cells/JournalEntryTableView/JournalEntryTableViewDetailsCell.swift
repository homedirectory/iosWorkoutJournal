//
//  JournalEntryTableViewDetailsCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class JournalEntryTableViewDetailsCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    
    var locked: Bool = true
    
    func setup(placeholderText text: String) {
        self.textField.delegate = self
        self.textField.text = ""
        self.textField.placeholder = text
        self.selectionStyle = .none
    }
    
    func setup(withText text: String) {
        self.textField.delegate = self
        self.textField.text = text
        self.selectionStyle = .none
    }
    
    func unlockTextField() {
        self.textField.isEnabled = true
        self.textField.isUserInteractionEnabled = true
        self.locked = false
    }
    
    func lockTextField() {
        self.textField.isEnabled = false
        self.textField.isUserInteractionEnabled = false
        self.locked = true
    }
    
    func getText() -> String {
        return self.textField.text!
    }
    
    #warning("warning if text input is not a number")
    func getNumber() -> Double? {
        if !locked {
            return Double(self.textField.text!)
        }
        return nil
    }
    
    func setNumber(number: Double) {
        self.textField.text = String(number)
    }
}

// MARK: - UITextFieldDelegate

extension JournalEntryTableViewDetailsCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
}
