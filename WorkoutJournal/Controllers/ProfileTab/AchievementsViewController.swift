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
    
    let achievements: [[Achievement]] = StaticVariables.defaultActivityTypes.map({
        $0.getAchievements($0.init())()
    })
    var achievedCount: Int {
        return self.achievements.flatMap({
            $0.filter({
                $0.achieved
                })
            }).count
    }
    
    @IBOutlet weak var tableLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Achievements"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableLabel.text = "\(self.achievedCount) / \(self.achievements.flatMap({ $0 }).count)"
    }
    
}

extension AchievementsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.achievements.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.achievements[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: AchievementCell.id) as! AchievementCell
        cell.setup(withAchievement: self.achievements[indexPath.section][indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return StaticVariables.defaultActivityNames[section]
    }
    
}

extension AchievementsViewController: UITableViewDelegate {
    
}
