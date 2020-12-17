//
//  FeedPostDelegate.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 17.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FeedPostDelegate {
    
    static let collectionName = "posts"
    
    static var fetched: [FeedPost] = []
    
    static func savePost(_ post: FeedPost) {
        let db = Firestore.firestore()
        
        let postData: [String : Any] = ["user_id" : post.user.id,
                        "activity_name" : post.activityName,
                        "activity_details" : post.activityDetails,
                        "activity_date" : post.activityDate,
                        "date" : post.postedDate]
        
        db.collection(FeedPostDelegate.collectionName).addDocument(data: postData) { (error) in
            if let err = error {
                print("- Failed to save FeedPost to database: \(err.localizedDescription)")
            }
            else {
                print("- Saved FeedPost to database")
            }
        }
    }

    static func fetchAllPosts() {
        let db = Firestore.firestore()

    
        db.collection(FeedPostDelegate.collectionName).getDocuments() { (querySnapshot, err) in
            print("getting documents")
            if let err = err {
                print("- Error getting documents: \(err.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    let post = FeedPost(user: User(id: data["user_id"] as! String, fullName: "John"), activityName: data["activity_name"] as! String, activityDetails: data["activity_details"] as! String, activityDate: (data["activity_date"] as! Timestamp).dateValue(), postedDate: (data["date"] as! Timestamp).dateValue())
                    Self.fetched.append(post)
                }
            }
        }

    }
    
}
