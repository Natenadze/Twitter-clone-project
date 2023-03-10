//
//  ActionSheetViewModel.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 10.03.23.
//

import Foundation

struct ActionSheetViewModel {
    
    private let user: User
    
    // Array
    var options: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        }else {
            // are we following the user?
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOption)
        }
        results.append(.report)
        return results
    }
    
    init(user: User) {
        self.user = user
    }
    
}

enum ActionSheetOptions {
    case follow(User) // associatedtype: User
    case unfollow(User)
    case report
    case delete
    
    var description: String {
        switch self {
        case .follow(let user):   return "Follow @\(user.username)"
        case .unfollow(let user): return "Unfollow @\(user.username)"
        case .report:             return "Report Tweet"
        case .delete:             return "Delete Tweet"
        }
    }
}
