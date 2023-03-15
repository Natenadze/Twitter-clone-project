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
    
    func uploadNotification(toUser user: User,
                            type: NotificationType,
                            tweetID: String? = nil) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970),
                                     "uid": uid,
                                     "type": type.rawValue]
        // if we pass tweet into parameters, it means that notif is for a tweet like, and we will append tweetID to the dictionary
        if let tweetID {
            values["tweetID"] = tweetID
            // tweet.user.uid -> we create notif for that user ( owner of the tweet )
            
        }
        REF_NOTIFICATIONS.child(user.uid).childByAutoId().updateChildValues(values)
        
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { user in
                let notificaiton = Notification(user: user, dictionary: dictionary)
                notifications.append(notificaiton)
                completion(notifications)
            }
            
        }
        
    }
}
