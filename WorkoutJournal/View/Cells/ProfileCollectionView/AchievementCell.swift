//
//  AchievementCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 16.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class AchievementCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var achievedImageView: UIImageView!
    
    func setup(withAchievement achievement: Achievement) {
        self.nameLabel.text = achievement.name
        self.descriptionLabel.text = achievement.descriptionString
        if achievement.achieved {
            self.achievedImageView.image = UIImage(systemName: "checkmark.circle.fill")
            self.achievedImageView.alpha = 1
        }
        else {
            self.achievedImageView.image = UIImage(systemName: "checkmark.circle")
            self.achievedImageView.tintColor = .lightGray
            self.achievedImageView.alpha = 0.25
        }
    }
    
}
