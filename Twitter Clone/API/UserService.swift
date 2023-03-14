//
//  UserService.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 28.02.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    func fetchUser(uid: String, completion: @escaping (User) -> Void) {
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            // represent info as a dictionary
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            
            completion(user)
        }
    }
    
    func fetchUser(completion: @escaping ([User]) -> Void) {
        var users = [User]()
        REF_USERS.observe(.childAdded) { snapshot in
            let uid = snapshot.key
            
            guard let dictionary = snapshot.value as? [String: AnyObject]  else { return }
            
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
    
    // typealias for completions
    func followUser(uid: String, completion: @escaping(DatabaseCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUid).updateChildValues([uid: 1]) { err, ref in
            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUid: 1],
                                                            withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping(DatabaseCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUid).child(uid).removeValue { error, ref in
            REF_USER_FOLLOWERS.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUid).child(uid).observeSingleEvent(of: .value) { snapshot in
            // tells us, if the child, we are looking for, exists
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping(UserRelationStats) -> Void) {
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            let followers = snapshot.children.allObjects.count
            
            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { snapshot in
                let following = snapshot.children.allObjects.count
                
                let stats = UserRelationStats(followers: followers, following: following)
                completion(stats)
            }
        }
    }
    
    // update Profile Image to Firebase
    func updateProfileImage(image: UIImage, completion: @escaping(URL?) -> Void) {
        // convert image to jpegData
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let filename = NSUUID().uuidString
        let ref = STORAGE_PROFILE_IMAGES.child(filename)
        
        ref.putData(imageData) { meta, err in
            // get image Download Url
            ref.downloadURL { url, err in
                guard let profileImageUrl = url?.absoluteString else { return }
                let values = ["profileImageUrl": profileImageUrl]
                
                REF_USERS.child(uid).updateChildValues(values) { err, ref in
                    completion(url)
                }
            }
        }
    }
    
    func saveUserData(user: User, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["fullname": user.fullname,
                      "username": user.username,
                      "bio": user.bio ?? "" ]
        
        REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
}
