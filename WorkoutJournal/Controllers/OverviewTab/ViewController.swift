//
//  ViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: CoordinatorOverviewTab?
    var journalManager: JournalManager?
    private var entriesForDifferentDays: Dictionary<[Int], [JournalEntry]>?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newEntryButton: UIButton!
    
    // for testing
    @IBOutlet weak var deleteAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jm = journalManager else { return }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.entriesForDifferentDays = jm.getEntriesForDifferentDays()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
}

// MARK: - IBActions

extension ViewController {

    @IBAction func newEntryButtonAction(_ sender: Any) {
        self.coordinator!.pushJournalEntryViewController(journalManager: self.journalManager!)
    }
    
    @IBAction func deleteAllButtonAction(_ sender: Any) {
        self.journalManager!.deleteAllEntries()
        self.tableView.reloadData()
      }
    
}

// MARK: - UITableView extensions

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.entriesForDifferentDays!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keyByIndex = Array(self.entriesForDifferentDays!.keys)[section]
        return StaticVariables.dateComponentsToString(keyByIndex)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keyByIndex = Array(self.entriesForDifferentDays!.keys)[section]
        return self.entriesForDifferentDays![keyByIndex]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entryCell = tableView.dequeueReusableCell(withIdentifier: JournalEntryCell.id) as! JournalEntryCell
        let keyByIndex = Array(self.entriesForDifferentDays!.keys)[indexPath.section]
        entryCell.entry = self.entriesForDifferentDays![keyByIndex]![indexPath.row]
        entryCell.configureDetails()
        
        return entryCell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let entry = (self.tableView.cellForRow(at: indexPath) as! JournalEntryCell).entry!
        self.coordinator!.pushJournalEntryViewController(journalManager: self.journalManager!, entryToUpdate: entry)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = self.tableView.cellForRow(at: indexPath) as! JournalEntryCell
        guard let entry = cell.entry else { return UISwipeActionsConfiguration(actions: []) }
        
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in
            self.journalManager?.deleteEntry(entryId: entry.id)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        })
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}



