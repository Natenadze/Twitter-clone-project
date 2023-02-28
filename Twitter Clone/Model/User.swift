//
//  User.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 28.02.23.
//

import Foundation


struct User {
    
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
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
