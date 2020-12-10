//
//  JournalEntryViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class JournalEntryViewController: UIViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    var journalManager: JournalManager?
    private var detailsCellLabels = ["", "Duration", "Distance", "Repetititons"]
    private var selectedActivityInstance: Activity? = nil
    
    lazy var activityCell = self.tableView.cellForRow(at: [0, 0]) as! JournalEntryTableViewActivityCell
    lazy var durationCell = self.tableView.cellForRow(at: [0, 1]) as! JournalEntryTableViewDetailsCell
    lazy var distanceCell = self.tableView.cellForRow(at: [0, 2]) as! JournalEntryTableViewDetailsCell
    lazy var repetitionsCell = self.tableView.cellForRow(at: [0, 3]) as! JournalEntryTableViewDetailsCell
    lazy var dateCell = self.tableView.cellForRow(at: [0, 4]) as! JournalEntryTableViewDateCell
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet var gestureRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.saveButton.layer.cornerRadius = 25.0
        
    }
        
    func unlockTextFields() {
        self.lockTextFields()
        let cells = [durationCell, distanceCell, repetitionsCell]
        let selectedActivityInstanceDetails = [self.selectedActivityInstance!.duration, self.selectedActivityInstance!.distance, self.selectedActivityInstance!.repetitions] as [Any?]
        
        for (index, cell) in cells.enumerated() {
            if let _ = selectedActivityInstanceDetails[index] {
                cell.unlockTextField()
            }
        }
    }
    
    func lockTextFields() {
        let cells = [durationCell, distanceCell, repetitionsCell]
        cells.forEach({
            $0.lockTextField()
        })
    }
    
    @objc func resignTextFields() {
        for cell in [self.durationCell, self.distanceCell, self.repetitionsCell] {
            if cell.textField.isFirstResponder {
                cell.textField.resignFirstResponder()
            }
        }
    }

  
}

// MARK: - IBActions

extension JournalEntryViewController {
    
    @IBAction func gestureRecognizerAction(_ sender: Any) {
        self.resignTextFields()
    }
    
    @IBAction func testButtonAction(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let reps = self.repetitionsCell.getNumber() == nil ? nil : Int(self.repetitionsCell.getNumber()!)
        let activity = self.activityCell.chosenActivity!.init(duration: self.durationCell.getNumber(), distance: self.distanceCell.getNumber(), repetitions: reps)
        
        self.journalManager?.createEntry(activity: activity, date: Date())
        
        self.coordinator!.navController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDataSource

extension JournalEntryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewActivityCell.id) as! JournalEntryTableViewActivityCell
            cell.coordinator = self.coordinator!
            cell.label.text = cell.cellLabel == nil ? "Activity" : cell.cellLabel!
            cell.completion = { [weak self] activityType in
                self?.selectedActivityInstance = activityType!.init()
                self?.unlockTextFields()
            }

            return cell
        }
        
        else if Array(1...3).contains(indexPath.row) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewDetailsCell.id) as! JournalEntryTableViewDetailsCell
            cell.setup(initialText: self.detailsCellLabels[indexPath.row])
            return cell
        }
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewDateCell.id) as! JournalEntryTableViewDateCell
        cell.label.text = "Date"
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension JournalEntryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.coordinator!.pushActivitiesListViewController(trigerredCell: self.activityCell)
        }
        
        if indexPath.row == 4 {
//            let datePicker = UIDatePicker()
//            self.dateCell.datePicker = datePicker
            
        }
    }
}
