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
    
    func uploadTweet(caption: String, type: UploadTweetConfiguration, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // timestamp is a number of seconds
        let values: [String : Any] = ["uid": uid,
                                      "timestamp": Int(NSDate().timeIntervalSince1970),
                                      "likes": 0,
                                      "retweets": 0,
                                      "caption": caption]
        
        
        switch type {
        case .tweet:
            // upload Tweet part 1
            //        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
            
            //upload tweet. if type is tweet
            REF_TWEETS.childByAutoId().updateChildValues(values) { error, ref in
                // update user-tweet structure, after tweet upload completes
                guard let tweetID = ref.key else { return }
                REF_USER_TWEETS.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
            }
        case .reply(let tweet):
            // upload reply. if type is reply
            REF_TWEET_REPLIES.child(tweet.tweetID).updateChildValues(values, withCompletionBlock: completion)
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
            print(snapshot.value!)  // აქ dictionary მოაქვს ჩვეულებრივ
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
    
    func fetchReplies(forTweet tweet: Tweet, completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        
        REF_TWEET_REPLIES.child(tweet.tweetID).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else {
                print("fail creating dictionary")
                return
                
            }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let tweet = Tweet(user: user, tweetID: tweetID, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func likeTweet(tweet: Tweet, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // if tweet is liked, when pressing like button, will decrease/increase by 1
        let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
        // go to tweets, find id, go to likes and update it
        REF_TWEETS.child(tweet.tweetID).child("likes").setValue(likes)
        
        if tweet.didLike {
            // remove like
            REF_USER_LIKES.child(uid).child(tweet.tweetID).removeValue { err, ref in
                REF_TWEET_LIKES.child(tweet.tweetID).removeValue(completionBlock: completion)
            }
        } else {
            // add like
            REF_USER_LIKES.child(uid).updateChildValues([tweet.tweetID: 1]) { err, ref in
                REF_TWEET_LIKES.child(tweet.tweetID).updateChildValues([uid: 1], withCompletionBlock: completion)
            }
        }
    }
    
    func checkIfUserLikesTweet( _ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        REF_USER_LIKES.child(uid).child(tweet.tweetID).observeSingleEvent(of: .value) { snapshot in
            completion(snapshot.exists()) // returns true or false
        }
    }
}
