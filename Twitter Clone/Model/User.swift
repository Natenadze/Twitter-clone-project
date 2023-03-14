//
//  User.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 28.02.23.
//

import Foundation
import FirebaseAuth


struct User {
    
    var fullname: String
    let email: String
    var username: String
    var profileImageUrl: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    var bio: String?
    
    var isCurrentUser: Bool {
        Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
        
        if let imageUrlString = dictionary["profileImageUrl"] as? String {
            profileImageUrl = URL(string: imageUrlString)
        }
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
