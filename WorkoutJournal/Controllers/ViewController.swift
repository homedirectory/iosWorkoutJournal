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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newEntryButton: UIButton!
    
    // for testing
    @IBOutlet weak var deleteAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let jm = journalManager else { return }
        
        tableView.delegate = self
        tableView.dataSource = self
                
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.journalManager!.entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entryCell = tableView.dequeueReusableCell(withIdentifier: JournalEntryCell.id) as! JournalEntryCell
        entryCell.entry = journalManager!.entries[indexPath.row]
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
    
}



