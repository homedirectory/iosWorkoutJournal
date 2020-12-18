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
        
        let postData: [String : Any] = ["username" : post.user.name,
                        "activity_name" : post.activityName,
                        "activity_details" : post.activityDetails,
                        "activity_date" : post.activityDate,
                        "date" : post.postedDate]
        
        db.collection(FeedPostManager.collectionName).addDocument(data: postData) { (error) in
            if let err = error {
                print("- Failed to save FeedPost to database: \(err.localizedDescription)")
            }
            else {
                self.fetched.append(post)
                print("- Saved FeedPost to database")
            }
        }
    }

    func fetchAllPosts() {
        let db = Firestore.firestore()

    
        db.collection(FeedPostManager.collectionName).getDocuments() { (querySnapshot, err) in
            print("getting documents")
            if let err = err {
                print("- Error getting documents: \(err.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    let post = FeedPost(user: User(name: data["username"] as! String, following: []), activityName: data["activity_name"] as! String, activityDetails: data["activity_details"] as! String, activityDate: (data["activity_date"] as! Timestamp).dateValue(), postedDate: (data["date"] as! Timestamp).dateValue())
                    self.fetched.append(post)
                }
            }
        }

    }
    
}
