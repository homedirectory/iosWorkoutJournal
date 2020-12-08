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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }

}


// MARK: - IBActions

extension JournalEntryViewController {
    
    @IBAction func testButtonAction(_ sender: Any) {
        let ip = IndexPath(row: 0, section: 0)
        let cell = self.tableView.cellForRow(at: ip) as! JournalEntryTableViewActivityCell
        print("LOOK HERE, FROM CELL IS: ", cell)
        print(cell.label.text)
        print(cell.chosenActivity)
        self.tableView.reloadData()
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

            return cell
        }
        
        else if Array(1...3).contains(indexPath.row) {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: JournalEntryTableViewDetailsCell.id) as! JournalEntryTableViewDetailsCell
            cell.label.text = self.detailsCellLabels[indexPath.row]
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
        print("selected index path: ", indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let cell = self.tableView.cellForRow(at: indexPath) as! JournalEntryTableViewActivityCell
            self.coordinator!.pushActivitiesListViewController(trigerredCell: cell)
        }
    }
}
