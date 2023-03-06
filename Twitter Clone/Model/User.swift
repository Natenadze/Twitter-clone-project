//
//  User.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 28.02.23.
//

import Foundation
import FirebaseAuth


struct User {
    
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    
    var isCurrentUser: Bool {
        Auth.auth().currentUser?.uid == uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let imageUrlString = dictionary["profileImageUrl"] as? String {
            profileImageUrl = URL(string: imageUrlString)
        }
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
