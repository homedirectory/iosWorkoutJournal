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
    var tapRecognizer: UIGestureRecognizer?
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if (self.activityStatsView != nil) && touch.view == self.view {
            self.hideStats()
        }
    }
    
    func showStats(stats: [Stats]) {
        self.hideStats()
        
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
    
    func hideStats() {
        if let _ = self.activityStatsView {
            self.activityStatsView!.removeFromSuperview()
            self.activityStatsView = nil
        }
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
        self.showStats(stats: self.activityTypes[indexPath.row].getStats())
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
