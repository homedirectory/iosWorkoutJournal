//
//  StatsViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 15.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

class StatsViewController: UIViewController, Storyboarded {
    
    private let activityTypes: [Activity.Type] = StaticVariables.defaultActivityTypes
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
}

extension StatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.activityTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ActivityStatsCell.id) as! ActivityStatsCell
        cell.activityType = self.activityTypes[indexPath.row]
        return cell
    }
    
    
}

extension StatsViewController: UITableViewDelegate {
    
}
