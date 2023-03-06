//
//  ProfileHeaderViewModel.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 03.03.23.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var desctiption: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}


struct ProfileHeaderViewModel {
    
    private let user: User
    let userName: String
    
    var followersString: NSAttributedString? {
//        guard let TypeHere else { return }
        return attributedText(withValue: user.stats?.followers ?? 0, text: "Followers")
    }
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "Following")
    }
    
    var actionButtonLabel: String {
        
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return "Loading"
    }
    
    init(user: User) {
        self.user = user
        self.userName = "@" + user.username
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)",
                                                        attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        // p.s shorthand  -> .font; .foreground
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        return attributedTitle
    }
    
}

