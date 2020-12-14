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
    
    weak var coordinator: CoordinatorOverviewTab?
    var journalManager: JournalManager?
    private var detailsCellLabels = ["Duration", "Distance", "Repetititons"]
    private var selectedActivityInstance: Activity?
    var entryToUpdate: JournalEntry?
    
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
        
        if let _ = self.entryToUpdate {
//            self.setUpdatingEntry()
            self.selectedActivityInstance = self.entryToUpdate!.activity
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func setUpdatingEntry() {
        self.selectedActivityInstance = self.entryToUpdate!.activity
//        self.dateCell.date = self.entryToUpdate!.creationDate
//        self.unlockTextFields()
    }
        
    func unlockTextFields() {
        self.lockTextFields()
        
        let cells = [durationCell, distanceCell, repetitionsCell]
        
        for (index, cell) in cells.enumerated() {
            if let number = self.getSelectedActivityInstanceDetails()[index] {
                cell.unlockTextField()
                cell.setNumber(number: number)
            }
        }
    }
    
    private func lockTextFields() {
        let cells = [durationCell, distanceCell, repetitionsCell]
        cells.forEach({
            $0.lockTextField()
        })
    }
    
    private func getSelectedActivityInstanceDetails() -> [Double?] {
        return [self.selectedActivityInstance!.duration,
                self.selectedActivityInstance!.distance,
                self.selectedActivityInstance!.repetitions]

    }
    
}

// MARK: - IBActions, objc functions

extension JournalEntryViewController {
    
    @objc func resignTextFields() {
        for cell in [self.durationCell, self.distanceCell, self.repetitionsCell] {
            if cell.textField.isFirstResponder {
                cell.textField.resignFirstResponder()
            }
        }
    }
    
    @IBAction func gestureRecognizerAction(_ sender: Any) {
        self.resignTextFields()
    }
    
    @IBAction func testButtonAction(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
//        if let entry = self.entryToUpdate {
//            self.journalManager!.updateEntryActivity(entryId: entry.id, newDistance: self.distanceCell.getNumber())
//            self.journalManager!.updateEntryActivity(entryId: entry.id, newDuration: self.durationCell.getNumber())
//            self.journalManager!.updateEntryActivity(entryId: entry.id, newRepetitions: self.repetitionsCell.getNumber())
//        }
//        else {
//            let activity = self.activityCell.chosenActivity!.init(duration: self.durationCell.getNumber(), distance: self.distanceCell.getNumber(), repetitions: self.repetitionsCell.getNumber())
        #warning("Throw an exception here")
            guard let activity = self.selectedActivityInstance else { return }
            activity.duration = self.durationCell.getNumber()
            activity.distance = self.distanceCell.getNumber()
            activity.repetitions = self.repetitionsCell.getNumber()
            
        if let entry = self.entryToUpdate {
            self.journalManager!.setEntryActivity(entryId: entry.id, newActivity: activity)
        } else {
            self.journalManager!.createEntry(activity: activity, date: Date())
        }
//        }
        
        self.selectedActivityInstance = nil
        self.entryToUpdate = nil
        self.coordinator!.navController?.popViewController(animated: true)
    }
    
}


// MARK: - UITableViewDataSource

extension JournalEntryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("CELL FOR ROW AT")
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewActivityCell.id) as! JournalEntryTableViewActivityCell
            cell.coordinator = self.coordinator!
//            cell.label.text = cell.cellLabel == nil ? "Activity" : cell.cellLabel!
            cell.completion = { [weak self] activityType in
                self?.selectedActivityInstance = activityType!.init()
//                self?.unlockTextFields()
            }
            if let sai = self.selectedActivityInstance {
                cell.chosenActivity = type(of: sai)
            }

            return cell
        }
        
        else if Array(1...3).contains(indexPath.row) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewDetailsCell.id) as! JournalEntryTableViewDetailsCell
            if let _ = self.selectedActivityInstance {
                if let detail = self.getSelectedActivityInstanceDetails()[indexPath.row - 1] {
                    print("unlock")
                    cell.unlockTextField()
                    cell.setup(withText: String(Int(detail)))
                }
                else {
                    print("lock")
                    cell.lockTextField()
                    cell.setup(placeholderText: self.detailsCellLabels[indexPath.row - 1])
                }
            }
            else {
                cell.lockTextField()
                cell.setup(placeholderText: self.detailsCellLabels[indexPath.row - 1])
            }
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
