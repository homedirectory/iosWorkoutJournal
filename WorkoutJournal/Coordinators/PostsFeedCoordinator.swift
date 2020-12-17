//
//  PostsFeedCoordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


class PostsFeedCoordinator {
    
    static let STORYBOARD_NAME = "PostsFeed"
    
    var navController: UINavigationController?
    
    
    func start() {
        let vc = PostsFeedViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController = UINavigationController(rootViewController: vc)
    }
    
}
