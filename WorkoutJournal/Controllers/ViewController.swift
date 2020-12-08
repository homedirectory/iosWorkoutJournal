//
//  ViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    var journalManager: JournalManager?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newEntryButton: UIButton!
    
    // for testing
    @IBOutlet weak var deleteAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        guard let jm = journalManager else { return }
        
        jm.entries.forEach({
            $0.printInfo()
            print(type(of: $0.activity!))
        })
        
    }
    
}

// MARK: - IBActions

extension ViewController {

    @IBAction func newEntryButtonAction(_ sender: Any) {
        self.journalManager!.createEntry(activity: Running(duration: 100, distance: 100), date: Date())
        self.tableView.reloadData()
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
        
        return entryCell
    }
    
}

extension ViewController: UITableViewDelegate {
    
}



