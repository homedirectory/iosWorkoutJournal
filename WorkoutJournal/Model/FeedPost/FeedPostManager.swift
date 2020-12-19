//
//  FeedPostManager.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import FirebaseFirestore


public class FeedPostManager {
    
    static let collectionName = "posts"
    
    var fetched: [FeedPost] = []
    
    static let shared = FeedPostManager()
    
    private init() {
        
    }
    
    func savePost(_ post: FeedPost) {
        let db = Firestore.firestore()
        
        let collectionRef = db.collection(FeedPostManager.collectionName)
        
        let postData: [String : Any] = [
                        "id" : post.id,
                        "username" : post.user.name,
                        "activity_name" : post.activityName,
                        "activity_details" : post.activityDetails,
                        "activity_date" : post.activityDate,
                        "date" : post.postedDate
                                            ]
        
        collectionRef.document(post.id).setData(postData) { error in
            if let err = error {
                print("- Failed to save FeedPost to database: \(err.localizedDescription)")
            } else {
                self.fetched.append(post)
                print("- Saved FeedPost to database")
            }
        }
        
    }

    // fetch only those posts that were posted by the users followed by current user
    func fetchAllPosts() {
        // before fetching clear the fetched Array
        self.fetched = []
        
        guard let currentUser = UserManager.shared.currentUser else { return }
        
        let db = Firestore.firestore()
        
        let fetchFromUsers = currentUser.following + [currentUser.name]
        
        db.collection(FeedPostManager.collectionName).whereField("username", in: fetchFromUsers)
            .getDocuments() { (querySnapshot, error) in
                if let err = error {
                    print("- Error getting documents: \(err.localizedDescription)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let post = FeedPost(id: data["id"] as! String, user: User(name: data["username"] as! String, following: []), activityName: data["activity_name"] as! String, activityDetails: data["activity_details"] as! String, activityDate: (data["activity_date"] as! Timestamp).dateValue(), postedDate: (data["date"] as! Timestamp).dateValue())
                        self.fetched.append(post)
                    }
                }
        }
        
    }
    
    func deletePost(_ post: FeedPost, completion: (() -> ())?) {
        if post.user.name != UserManager.shared.currentUser!.name {
            return
        }
        
        let db = Firestore.firestore()
        
        let entryDocRef = db.collection(FeedPostManager.collectionName).document(post.id)
        
        entryDocRef.delete() { error in
            if let err = error {
                print("Firestore: Error removing Post: \(err.localizedDescription)")
            }
            else {
                if let _ = completion {
                    completion!()
                }
                print("Firestore: Post successfully removed!")
            }
        }
    }
    
}
