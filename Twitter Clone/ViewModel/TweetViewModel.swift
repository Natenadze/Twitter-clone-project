//
//  TweetViewModel.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 02.03.23.
//

import UIKit

struct TweetViewModel {
    
    let tweet: Tweet
    let user: User
    
    var timestamp: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now)
    }
    
    var profileImageUrl: URL? {
        tweet.user.profileImageUrl
    }
    var userInfoText: NSAttributedString {
        
        // this is mutable cause we're appending another string later
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        // this is normal attributed string
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]) )
        
        title.append(NSAttributedString(string: " ∙ \(timestamp ?? "")",
                                        attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return title
        
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
}
