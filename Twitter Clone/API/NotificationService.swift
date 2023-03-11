//
//  NotificationService.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 11.03.23.
//

import Foundation
import FirebaseAuth

struct NotificationService {
    
    static let shared = NotificationService()
    
    func uploadNotification(type: NotificationType, tweet: Tweet? = nil, user: User? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970),
                                     "uid": uid,
                                     "type": type.rawValue]
        // if we pass tweet into parameters, it means that notif is for a tweet like, and we will append tweetID to the dictionary
        if let tweet {
            values["tweetID"] = tweet.tweetID
            // tweet.user.uid -> we create notif for that user ( owner of the tweet )
            REF_NOTIFICATIONS.child(tweet.user.uid).childByAutoId().updateChildValues(values)
        } else {
            if let user {
                REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
            }
            
        }
        
    }
}
