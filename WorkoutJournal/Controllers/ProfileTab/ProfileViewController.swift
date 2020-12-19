//
//  ProfileViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 14.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ProfileCoordinator?
    var journalManager: JournalManager = JournalManager.shared
    
    let cellLabels = ["Stats", "Achievements"]
    let cellImages = ["chart.bar", "a.circle"]
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.backgroundColor = .lightGray
        
        self.userNameLabel.text = UserManager.shared.currentUser?.name ?? "??"
        
        self.profileImageView.image = UIImage(systemName: User.defaultUserImageName)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(UserManager.shared.justLoggedIn)
        print(JournalManager.shared.entries.map({
            $0.id
        }))
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        // attempt to sign out
        do {
            try firebaseAuth.signOut()
            // log out current user
            UserManager.shared.logOutCurrentUser()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            return
        }
        
        // transition to launch screen (ViewController)
        self.coordinator!.popToViewController()
    }
    
    @IBAction func followingButtonAction(_ sender: Any) {
        print(UserManager.shared.currentUser!.following)
        self.coordinator!.pushFollowedUsersViewController()
    }
    
}


extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ImageTextCell.id, for: indexPath) as! ImageTextCell
        
        cell.backgroundColor = .white
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.cornerRadius = 25.0
        
        cell.imageView.frame = CGRect(x: cell.frame.width / 4, y: cell.frame.height / 8,
                                      width: cell.frame.width / 2, height: cell.frame.height / 2)
        cell.imageView.image = UIImage(systemName: self.cellImages[indexPath.row])
        
        cell.label.frame = CGRect(x: cell.frame.width * 0.01, y: cell.imageView.frame.maxY + cell.label.frame.height, width: cell.frame.width * 0.99, height: cell.label.frame.height)
        cell.label.textAlignment = .center
        cell.label.text = self.cellLabels[indexPath.row]
        
        
        return cell
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.coordinator!.pushStatsViewController()
        }
        else if indexPath.row == 1 {
            self.coordinator!.pushAchievementsViewController()
        }
    }
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width * 0.45
        let height = self.collectionView.frame.height * 0.8
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}
