//
//  AchievementsViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 16.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class AchievementsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
}

extension AchievementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension AchievementsViewController: UITableViewDelegate {
    
}
