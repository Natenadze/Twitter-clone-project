//
//  ProfileHeader.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 02.03.23.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject {
    func handleDismissal()
    func HandleEditProfileFollow(_ header: ProfileHeader)
    func didSelect(filter: ProfileFilterOptions)
}


class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private lazy var containerView = UIView()
    private lazy var backButton = UIButton(type: .system)
    private lazy var profileImageView = UIImageView()
    lazy var editProfileFollowButton = UIButton(type: .system)
    
    private let userDetailStack = UIStackView()
    private let bioLabel = UILabel()
    private let fullNameLabel = UILabel()
    private let userNameLabel = UILabel()
    
    private let followStackView = UIStackView()
    private let followingLabel = UILabel()
    private let followersLabel = UILabel()
    private let filterBar = ProfileFilterView()
    
    weak var delegate: ProfileHeaderDelegate?
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterBar.delegate = self
        style()
        layout()
    }
    

    
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - helper function
    
    func configure() {
        guard let user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonLabel, for: .normal)
        
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        
        fullNameLabel.text = user.fullname
        userNameLabel.text = viewModel.userName
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
        
        
        // username label
        userNameLabel.font = UIFont.systemFont(ofSize: 16)
        userNameLabel.textColor = .lightGray
        
        
        // bioLabel
        bioLabel.font = UIFont.systemFont(ofSize: 16)
        bioLabel.numberOfLines = 3
        bioLabel.text = "This is a user bio that will span more than one line for test purposes"
        
        // follow stack
        followStackView.distribution = .fillEqually
        followStackView.spacing = 8
        followStackView.axis = .horizontal
        
        // following
        let followingTap = UITapGestureRecognizer(target: followingLabel.self, action: #selector(handleFollowingTaped))
        followingLabel.isUserInteractionEnabled = true
        followingLabel.addGestureRecognizer(followingTap)
        
        // followers
        let followersTap = UITapGestureRecognizer(target: followingLabel.self, action: #selector(handleFollowersTaped))
        followersLabel.isUserInteractionEnabled = true
        followersLabel.addGestureRecognizer(followersTap)
        
       
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
        
        followStackView.addArrangedSubview(followingLabel)
        followStackView.addArrangedSubview(followersLabel)
        addSubview(followStackView)
        
        addSubview(filterBar)
        
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
        
        // follow stack
        followStackView.anchor(top: userDetailStack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        // filterBar
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right:  rightAnchor, height: 50)
        
    }
}


// MARK: - Actions

extension ProfileHeader {
    
    @objc func handleDismissal() {
        delegate?.handleDismissal()
        
    }
    
    @objc func handleEditProfileFollow() {
        delegate?.HandleEditProfileFollow(self)
    }
    
    @objc func handleFollowingTaped() {
        
    }
     
    @objc func handleFollowersTaped() {
        
    }
    
}

extension ProfileHeader: ProfileFilterViewDelegate {
    
    func filterView(_ view: ProfileFilterView, didSelect index: Int) {
        
        guard let filter = ProfileFilterOptions(rawValue: index) else { return }
        delegate?.didSelect(filter: filter)
    }
}
