//
//  PostsFeedViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class PostsFeedViewController: UIViewController, Storyboarded {
    
    weak var coordinator: PostsFeedCoordinator?
    var posts: [FeedPost] = []
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        
        self.posts = FeedPostDelegate.fetched
    }
    
    @objc func refreshPosts() {
        self.refreshControl.endRefreshing()
        self.posts = FeedPostDelegate.fetched
        self.tableView.reloadData()
    }
    
}


extension PostsFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: PostCell.id) as! PostCell
        cell.setup(withPost: self.posts[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}

extension PostsFeedViewController: UITableViewDelegate {
    
}
