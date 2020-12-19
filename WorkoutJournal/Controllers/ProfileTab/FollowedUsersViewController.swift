//
//  FollowedUsersViewController.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 18.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

class FollowedUsersViewController: UIViewController, Storyboarded {
    
    private var foundUser: User?
    var followedUsers: [User] = []
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserManager.shared.currentUser!.following)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.searchTextField.delegate = self
        
        self.messageLabel.alpha = 0
        
        self.followButton.isEnabled = false
        
        self.followedUsers = UserManager.shared.currentUser!.following.map({
            User(name: $0, following: [])
        })
    }
    
    @IBAction func followButtonAction(_ sender: Any) {
        guard let foundUser = self.foundUser else { return }
        
        // add found user to current user following list
        UserManager.shared.updateFollowingAndSave(user: foundUser, followingStatus: true, completion: { [weak self] in
            // add found user's name to table view
            if let self = self {
                self.followedUsers.append(foundUser)
                self.tableView.reloadData()
                self.foundUser = nil
                self.searchTextField.text = ""
                self.followButton.isEnabled = false
            }
        })
    }
    
    func showMessage(_ message: String, failure: Bool) {
        if failure {
            self.messageLabel.textColor = .systemRed
        }
        else {
            self.messageLabel.textColor = .systemGreen
        }
        self.messageLabel.text = message
        self.messageLabel.alpha = 0.7
    }
    
}

extension FollowedUsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: FollowedUserCell.id) as! FollowedUserCell
        cell.setup(withUser: self.followedUsers[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Followed users"
    }
    
    
}

extension FollowedUsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = self.tableView.cellForRow(at: indexPath) as! FollowedUserCell
        guard let user = cell.user else { return nil }
        
        let action = UIContextualAction(style: .destructive, title: "Unfollow", handler: { (action, view, completionHandler) in
            UserManager.shared.updateFollowingAndSave(user: user, followingStatus: false, completion: {
                self.followedUsers.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                completionHandler(true)
            })
            
        })
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

extension FollowedUsersViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = self.searchTextField.text {
            // check if entered text is not empty
            let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedText.isEmpty {
                self.searchTextField.resignFirstResponder()
                self.foundUser = nil
                self.followButton.isEnabled = false
                return true
            }
            
            // users can't follow themselves
            if text == UserManager.shared.currentUser!.name {
                self.showMessage("You can't follow yourself", failure: true)
                return true
            }
            
            // users can't follow a user who is already followed
            if UserManager.shared.currentUser!.following.contains(text) {
                self.showMessage("This user is already followed", failure: true)
                return true
            }
            
            // find user by entered name
            UserManager.shared.findUser(byName: trimmedText, assignUserHandler: { [weak self] user in
                if let self = self {
                    self.searchTextField.resignFirstResponder()
                    // if user was found display success message and enable button
                    if let _ = user {
                        self.showMessage("User was found", failure: false)
                        self.followButton.isEnabled = true
                        self.foundUser = user
                    }
                    // if user was not found display error message
                    else {
                        self.showMessage("User was not found", failure: true)
                        self.followButton.isEnabled = false
                        self.foundUser = nil
                    }
                }
            })
        }
        
        return true
    }
    
}
