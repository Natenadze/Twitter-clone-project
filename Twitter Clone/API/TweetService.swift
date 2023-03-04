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
        //        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        
        let ref = REF_TWEETS.childByAutoId()
        ref.updateChildValues(values) { error, ref in
            // update user-tweet structure, after tweet upload completes
            guard let tweetID = ref.key else { return }
            REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
    }
    
    // fetch all tweets
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        var tweetsArray = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweetsArray.append(tweet)
                completion(tweetsArray)
            }
        }
    }
    
    // fetch certain users tweets
    func fetchTweets(forUser user: User, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        // get not only current user uid but any user uid
        REF_USER_TWEETS.child(user.uid).observe(.childAdded) { snapshot in
            let tweetID = snapshot.key
            
            REF_TWEETS.child(tweetID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                
                UserService.shared.fetchUser(uid: uid) { user in
                    let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
}
