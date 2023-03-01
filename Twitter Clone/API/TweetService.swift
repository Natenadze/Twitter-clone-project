//
//  TweetService.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 01.03.23.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct TweetService {
    
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // timestamp is a number of seconds
        let values: [String : Any] = ["uid": uid,
                                      "timestamp": Int(NSDate().timeIntervalSince1970),
                                      "likes": 0,
                                      "retweets": 0,
                                      "caption": caption
        ]
        
        // upload Tweet
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        
    }
}