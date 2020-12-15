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
    private var activityStatsView: ActivityStatsView?
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func showStats(stats: [Stats]) {
        if stats.isEmpty {
            return
        }
        
        let y = self.view.frame.origin.y + self.view.frame.height * CGFloat([(0.75 / Double(stats.count)) * 2, 0.6].min()!)
        
        self.activityStatsView = ActivityStatsView(frame: CGRect(x: self.view.frame.origin.x,
                                                                 y: y,
                                                                 width: self.view.frame.width,
                                                                 height: self.view.frame.height - y))
        self.activityStatsView!.setup(stats: stats)
        self.view.addSubview(self.activityStatsView!)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.activityStatsView = ActivityStatsView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
////        self.activityStatsView!.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
//        self.activityStatsView!.isHidden = false
//        self.activityStatsView!.alpha = 1
////        self.activityStatsView?.draw(CGRect(x: 200, y: 200, width: 100, height: 100))
//        self.view.addSubview(self.activityStatsView!)
//        self.view.bringSubviewToFront(self.activityStatsView!)
//        print("woo")
        self.showStats(stats: self.activityTypes[indexPath.row].getStats())
    }
    
}
