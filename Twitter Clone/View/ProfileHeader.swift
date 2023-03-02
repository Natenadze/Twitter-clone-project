//
//  ProfileHeader.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 02.03.23.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    private lazy var containerView = UIView()
    private lazy var backButton = UIButton(type: .system)
    private lazy var profileImageView = UIImageView()
    private lazy var editProfileFollowButton = UIButton(type: .system)
    
    private let userDetailStack = UIStackView()
    private let bioLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let userNameLabel = UILabel()
    
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Style & Layout

extension ProfileHeader {
    
    func style() {
        backgroundColor = .white
        
        // containerView
        containerView.backgroundColor = .twitterBlue
        
        // profileImageView
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 4
        
        // editProfileButton
        editProfileFollowButton.backgroundColor = .white
        editProfileFollowButton.setTitle("Loading", for: .normal)
        editProfileFollowButton.layer.borderColor = UIColor.twitterBlue.cgColor
        editProfileFollowButton.layer.borderWidth = 1.3
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        editProfileFollowButton.titleLabel?.textAlignment = .center
        editProfileFollowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        editProfileFollowButton.setTitleColor(.twitterBlue, for: .normal)
        editProfileFollowButton.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        
        // backButton
        guard let image = UIImage(named: "baseline_arrow_back_white_24dp") else { return }
        backButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        
        // userDetailStack
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        userDetailStack.spacing = 4
        
        // fullname label
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        fullNameLabel.text = "James Hetfield"
        
        // username label
        userNameLabel.font = UIFont.systemFont(ofSize: 16)
        userNameLabel.textColor = .lightGray
        userNameLabel.text = "@endsOfSanity"
        
        // bioLabel
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        bioLabel.numberOfLines = 3
        bioLabel.text = "This is a user bio that will span more than one line for test purposes"
    }
    
    
    // MARK: - Layout
    
    func layout() {
        containerView.addSubview(backButton)
        addSubview(containerView)
        addSubview(profileImageView)
        addSubview(editProfileFollowButton)
        userDetailStack.addArrangedSubview(fullNameLabel)
        userDetailStack.addArrangedSubview(userNameLabel)
        userDetailStack.addArrangedSubview(bioLabel)
        addSubview(userDetailStack)
        
        // backButton
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        
        // containerView
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        // profileImageView
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimensions(width: 80, height: 80)
        
        // editProfileButton
        editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor,
                                       paddingTop:12, paddingRight: 12, width: 100, height: 36)
        
        // userDetail StackView
        userDetailStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
                               right: rightAnchor, paddingTop: 8,
                               paddingLeft: 8, paddingRight: 8)
        
        
    }
}



// MARK: - Actions

extension ProfileHeader {
    
    @objc func handleDismissal() {
        
    }
    
    @objc func handleEditProfileFollow() {
        
    }
    
}
