//
//  FollowedUserCell.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 18.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class FollowedUserCell: UITableViewCell {
    
    var user: User?

    @IBOutlet weak var label: UILabel!
    
    func setup(withUser user: User) {
        self.user = user
        self.label.text = user.name
    }
    
}
