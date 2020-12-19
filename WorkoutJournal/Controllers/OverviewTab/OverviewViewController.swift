//
//  OverviewViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, Storyboarded {
    
    weak var coordinator: OverviewCoordinator?
    var journalManager: JournalManager = JournalManager.shared
    private var entriesForDifferentDays: [(key: [Int], value: [JournalEntry])]?
    
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newEntryButton: UIButton!
    
    // for testing
    @IBOutlet weak var deleteAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = self.refreshControl
        
        self.title = "Overview"
        
        self.deleteAllButton.isEnabled = false
        self.deleteAllButton.isHidden = true
        
        self.refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        self.entriesForDifferentDays = self.journalManager.getEntriesForDifferentDays().sorted(by: {_,_ in
            true
        })
    }
    
    @objc func refreshTable() {
        self.sortEntries()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    private func sortEntries() {
        self.entriesForDifferentDays = self.journalManager.getEntriesForDifferentDays().sorted(by: {
            if $0.key[2] == $1.key[2] {
                if $0.key[1] == $1.key[1] {
                    return $0.key[0] > $1.key[0]
                }
                else {
                    return $0.key[1] > $1.key[1]
                }
            }
            else {
                return $0.key[2] > $1.key[2]
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}

// MARK: - IBActions

extension OverviewViewController {

    @IBAction func newEntryButtonAction(_ sender: Any) {
        self.coordinator!.pushJournalEntryViewController()
    }
    
    @IBAction func deleteAllButtonAction(_ sender: Any) {
        self.journalManager.deleteAllEntries()
        self.tableView.reloadData()
      }
    
}

// MARK: - UITableView extensions

extension OverviewViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.entriesForDifferentDays!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let components = self.entriesForDifferentDays![section].key
        return StaticVariables.dateComponentsToString(components, shortMonthNames: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entriesForDifferentDays![section].value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entryCell = tableView.dequeueReusableCell(withIdentifier: JournalEntryCell.id) as! JournalEntryCell
        entryCell.entry = self.entriesForDifferentDays![indexPath.section].value[indexPath.row]
        entryCell.configureDetails()
        
        return entryCell
    }
    
}

extension OverviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let entry = (self.tableView.cellForRow(at: indexPath) as! JournalEntryCell).entry!
        self.coordinator!.pushJournalEntryViewController(entryToUpdate: entry)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = self.tableView.cellForRow(at: indexPath) as! JournalEntryCell
        guard let entry = cell.entry else { return UISwipeActionsConfiguration(actions: []) }
        
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { (action, view, completionHandler) in
            self.journalManager.deleteEntry(entryId: entry.id, completion: {
                self.entriesForDifferentDays![indexPath.section].value.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            })
        })
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}



