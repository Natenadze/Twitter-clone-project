//
//  NotificationViewModel.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 11.03.23.
//

import UIKit

struct NotificationViewModel {
    
    // MARK: - Properties
    private let notification: Notification
    private let type: NotificationType
    private let user: User
    
    // timestamp
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now)
    }
    
    // Notification Message
    var notifMessage: String {
        switch type {
        
        case .follow:  return " started following you"
        case .like:    return " liked your tweet"
        case .reply:   return " replied to your tweet"
        case .retweet: return " retweeted your tweet"
        case .mention: return " mentioned you in tweet"
        }
    }
    
    var notifText: NSAttributedString? {
        guard let timestampString else { return nil }
        
        let attributedText = NSMutableAttributedString(string: user.username,
                                                       attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        //
        attributedText.append(NSAttributedString(string: notifMessage,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        //
        attributedText.append(NSAttributedString(string: " \(timestampString)", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
    // Profile Image
    var profileImageUrl: URL? {
        user.profileImageUrl
    }
    
    var shouldHideFollowButton: Bool {
        return type != .follow
    }
    
    var followButtonText: String {
        user.isFollowed ? "Following" : "Follow"
    }
    
    // MARK: - INIT
    
    init(notification: Notification) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
        
    }
    

}
