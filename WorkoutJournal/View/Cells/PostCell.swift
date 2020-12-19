//
//  PostCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    var post: FeedPost?

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityDetailsLabel: UILabel!
    @IBOutlet weak var activityDateLabel: UILabel!
    
    func setup(withPost post: FeedPost) {
        self.post = post
        
        self.userImageView.image = UIImage(systemName: User.defaultUserImageName)
        
        self.userLabel.text = post.user.name
        
        self.dateLabel.text = post.postedDate.toString(shortMonthNames: true)
        
        self.activityLabel.text = post.activityName
        
        self.activityDetailsLabel.text = post.activityDetails
        
        self.activityDateLabel.text = post.activityDate.toString(shortMonthNames: true)
    }
    
}
