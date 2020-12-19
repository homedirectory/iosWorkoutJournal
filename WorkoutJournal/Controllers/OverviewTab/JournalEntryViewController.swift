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
    
    weak var coordinator: OverviewCoordinator?
    var journalManager: JournalManager = JournalManager.shared
    let feedPostManager: FeedPostManager = FeedPostManager.shared
    private var detailsCellLabels = ["Duration", "Distance", "Repetititons"]
    private var selectedActivityInstance: Activity?
    var entryToUpdate: JournalEntry?
    var selectedDate: Date?
    
    lazy var activityCell = self.tableView.cellForRow(at: [0, 0]) as! JournalEntryTableViewActivityCell
    lazy var durationCell = self.tableView.cellForRow(at: [0, 1]) as! JournalEntryTableViewDetailsCell
    lazy var distanceCell = self.tableView.cellForRow(at: [0, 2]) as! JournalEntryTableViewDetailsCell
    lazy var repetitionsCell = self.tableView.cellForRow(at: [0, 3]) as! JournalEntryTableViewDetailsCell
    lazy var dateCell = self.tableView.cellForRow(at: [0, 4]) as! JournalEntryTableViewDateCell
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var shareSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.saveButton.layer.cornerRadius = 25.0
        
        self.testButton.isEnabled = false
        self.testButton.isHidden = true
        
        if let _ = self.entryToUpdate {
            self.selectedActivityInstance = self.entryToUpdate!.activity
            self.selectedDate = self.entryToUpdate!.creationDate
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
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
    
    @IBAction func shareSwitchAction(_ sender: Any) {
    }
        
    @IBAction func testButtonAction(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        #warning("Throw an exception here instead of return")
        guard let _ = self.selectedActivityInstance else { return }
        
        let activity = type(of: self.selectedActivityInstance!).init(duration: self.durationCell.getNumber(),
                                                                     distance: self.distanceCell.getNumber(),
                                                                     repetitions: self.repetitionsCell.getNumber())
            
        if let entry = self.entryToUpdate {
            self.journalManager.setEntryActivity(entryId: entry.id, newActivity: activity)
            self.journalManager.setEntryDate(entryId: entry.id, newDate: self.selectedDate ?? Date())
            // if switch is on and this entry is updated, create new post and write it into db
            if self.shareSwitch.isOn {
                self.feedPostManager.savePost(FeedPost(user: UserManager.shared.currentUser!, journalEntry: entry))
            }
        }
        else {
            let entry = self.journalManager.createEntry(activity: activity, date: self.selectedDate ?? Date())
            // if switch is on and entry is valid, create new post and write it into db
            if self.shareSwitch.isOn && entry != nil {
                self.feedPostManager.savePost(FeedPost(user: UserManager.shared.currentUser!, journalEntry: entry!))
            }
        }

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
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewActivityCell.id) as! JournalEntryTableViewActivityCell
            cell.coordinator = self.coordinator!
            cell.completion = { [weak self] activityType in
                self?.selectedActivityInstance = activityType!.init()
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
                    cell.unlockTextField()
                    cell.setup(withText: String(Int(detail)))
                }
                else {
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
        cell.setup(date: self.selectedDate, handler: { [weak self] date in
            self!.view.endEditing(true)
            self!.selectedDate = date
        })
        
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if touch.view == self.view {
            print("touch")
            self.dateCell.displayDate()
            self.view.endEditing(true)
        }
    }
    
    
}

// MARK: - UITableViewDelegate

extension JournalEntryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            self.coordinator!.pushActivitiesListViewController(trigerredCell: self.activityCell)
        }
        
    }
    
}
