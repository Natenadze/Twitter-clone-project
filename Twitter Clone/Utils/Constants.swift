//
//  Constants.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 27.02.23.
//

import FirebaseDatabase
import FirebaseStorage

let DB_REF = Database.database().reference()

// firebase ზე აისახება კატეგორიები Database ში, იმ სახელებით რა სტრინგსაც აქ ვარქმევთ
let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let REF_TWEETS = DB_REF.child("tweets")
let REF_USER_TWEETS = DB_REF.child("user-tweets")

// Follows
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWING = DB_REF.child("user-following")

// Reply
let REF_TWEET_REPLIES = DB_REF.child("tweet-replies")

// likes
let REF_USER_LIKES = DB_REF.child("user-likes")
let REF_TWEET_LIKES = DB_REF.child("tweet-likes")

// notifications
let REF_NOTIFICATIONS = DB_REF.child("notifications")
