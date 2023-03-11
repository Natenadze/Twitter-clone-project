//
//  Notification.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 11.03.23.
//

import Foundation

// MARK: - Enum
enum NotificationType: Int {
    case follow
    case like
    case reply
    case retweet
    case mention
}


// MARK: - Model Struct

struct Notification {
    
    // MARK: - Properties
    let tweetID: String?
    var timestamp: Date!
    let user: User
    var tweet: Tweet? // optional because during follow notif, there is no tweet needed
    var type: NotificationType!
    
    
    // MARK: - Init
    init(user: User, tweet: Tweet?, dictionary: [String: AnyObject]) {
        self.user = user
        self.tweet = tweet
        self.tweetID = dictionary["tweetID"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
    
}
