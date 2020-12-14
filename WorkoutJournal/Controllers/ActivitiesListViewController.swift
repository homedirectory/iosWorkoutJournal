//
//  ActivitiesListViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 08.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class ActivitiesListViewController: UIViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    var fromCell: JournalEntryTableViewActivityCell?
    let activityTypes = StaticVariables.defaultActivityTypes
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension ActivitiesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ActivityTypeCell.id) as! ActivityTypeCell
        cell.activityType = self.activityTypes[indexPath.row]
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension ActivitiesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath) as! ActivityTypeCell
        self.fromCell!.chooseActivity(cell.activityType)
        self.coordinator!.navController?.popViewController(animated: true)
    }
    
}
