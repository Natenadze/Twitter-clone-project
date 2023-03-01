//
//  Constants.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 27.02.23.
//

import FirebaseDatabase
import FirebaseStorage

let DB_REF = Database.database().reference()

let REF_USERS = DB_REF.child("users")

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

let REF_TWEETS = DB_REF.child("tweets")
