//
//  JournalEntryViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

#warning("TODO: duration, distance and repetitions cells need to be fixed")
// TODO: TODO
//      1) duration, distance and repetitions cells need to be fixed
//          b) you cant edit inapropriate details for a particular activity type


class JournalEntryViewController: UIViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    var journalManager: JournalManager?
    private var detailsCellLabels = ["", "Duration", "Distance", "Repetititons"]
    
    lazy var activityCell = self.tableView.cellForRow(at: [0, 0]) as! JournalEntryTableViewActivityCell
    lazy var durationCell = self.tableView.cellForRow(at: [0, 1]) as! JournalEntryTableViewDetailsCell
    lazy var distanceCell = self.tableView.cellForRow(at: [0, 2]) as! JournalEntryTableViewDetailsCell
    lazy var repetitionsCell = self.tableView.cellForRow(at: [0, 3]) as! JournalEntryTableViewDetailsCell
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.saveButton.layer.cornerRadius = 25.0
    }
        
    func unlockTextFields() {
        for cell in [durationCell, distanceCell, repetitionsCell] {
            cell.unlockTextField()
        }
    }

}

// MARK: - IBActions

extension JournalEntryViewController {
    
    @IBAction func testButtonAction(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
//        let activityCell = self.tableView.cellForRow(at: [0, 0]) as! JournalEntryTableViewActivityCell
//        let durationCell = self.tableView.cellForRow(at: [0, 1]) as! JournalEntryTableViewDetailsCell
//        let distanceCell = self.tableView.cellForRow(at: [0, 2]) as! JournalEntryTableViewDetailsCell
//        let repetitionsCell = self.tableView.cellForRow(at: [0, 3]) as! JournalEntryTableViewDetailsCell

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
            cell.unlocker = { [weak self] in
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
            let cell = self.tableView.cellForRow(at: indexPath) as! JournalEntryTableViewActivityCell
            self.coordinator!.pushActivitiesListViewController(trigerredCell: cell)
        }
    }
}
