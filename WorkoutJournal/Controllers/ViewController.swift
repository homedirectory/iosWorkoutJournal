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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
}

// MARK: - IBActions

extension ViewController {

    @IBAction func newEntryButtonAction(_ sender: Any) {
        self.coordinator!.pushJournalEntryViewController(journalManager: self.journalManager!)
//        self.tableView.reloadData()
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
    
}



