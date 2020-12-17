//
//  AuthenticationCoordinator.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

class AuthenticationCoordinator {
    
    static var STORYBOARD_NAME: String = "Authentication"
    
    var overviewCoordinator: OverviewCoordinator?
    var profileCoordinator: ProfileCoordinator?
    
    var navController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let vc = ViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushLoginViewController() {
        let vc = LoginViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushSignUpViewController() {
        let vc = SignUpViewController.instantiate(storyboardName: Self.STORYBOARD_NAME)
        vc.coordinator = self
        self.navController!.pushViewController(vc, animated: true)
    }
    
    func pushTabBarController() {
        let tabBarController = UITabBarController()

        self.overviewCoordinator = OverviewCoordinator()
        self.overviewCoordinator!.start(journalManager: JournalManager.shared)
        let navControllerOverview = self.overviewCoordinator!.navController!
        navControllerOverview.title = "Overview"

        self.profileCoordinator = ProfileCoordinator()
        self.profileCoordinator!.popToViewControllerHandler = { [weak self] in
            if let _ = self {
                self!.navController!.popToRootViewController(animated: true)
                self!.navController!.isNavigationBarHidden = false
            }
        }
        self.profileCoordinator!.start(journalManager: JournalManager.shared)
        let navControllerProfile = self.profileCoordinator!.navController!
        navControllerProfile.title = "Profile"

        tabBarController.setViewControllers([navControllerOverview, navControllerProfile], animated: true)

        let imageNames: [String] = ["house", "person"]

        guard let items = tabBarController.tabBar.items else { return }

        for (i, item) in items.enumerated() {
            item.image = UIImage(systemName: imageNames[i])
        }

        self.navController!.pushViewController(tabBarController, animated: true)
        self.navController!.isNavigationBarHidden = true
    }
    
}
