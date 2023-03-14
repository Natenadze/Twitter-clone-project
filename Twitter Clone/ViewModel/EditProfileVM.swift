//
//  EditProfileVM.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 14.03.23.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname, username, bio
    
    var desctiption: String {
        switch self {
            
        case .fullname: return "Username"
        case .username: return "Name"
        case .bio:      return "Bio"
        }
    }
}


struct EditProfileVM {
    
    // MARK: - Properties
    
    private let user: User
    
    let option: EditProfileOptions
    
    var titleText: String {
        option.desctiption
    }
    
    var optionValue: String? {
        
        switch option {
            
        case .fullname:
            return user.username
        case .username:
            return user.fullname
        case .bio:
            return user.bio
        }
    }
    
    var shouldHideTextField: Bool {
        option == .bio
    }
    
    var shouldHideTextView: Bool {
        option != .bio
    }
    
    var shouldHidePlaceholderLabel: Bool {
        user.bio != nil
    }
    
    // MARK: - Init
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
}
