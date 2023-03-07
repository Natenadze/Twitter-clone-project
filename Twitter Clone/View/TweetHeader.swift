//
//  TweetHeader.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 07.03.23.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    private let profileImageView = UIImageView()
    private let userDetailStack = UIStackView()
    private let fullNameLabel = UILabel()
    private let userNameLabel = UILabel()
    private let captionLabel = UILabel()
    private let dateLabel = UILabel()
    private var optionsButton = UIButton(type: .system)
    
    private let statsView = UIView()
    private let dividerTop = UIView()
    private let dividerBottom = UIView()
    private let retweetsLabel = UILabel()
    private let likesLabel = UILabel()
    
    private let actionStackView = UIStackView()
    private lazy var commentButton: UIButton = {
        let button = createButton(withImageName: "comment", target: self, action: #selector(handleCommentTapped))
        return button
    }()
     
    private lazy var retweetButton: UIButton = {
        let button = createButton(withImageName: "retweet", target: self, action: #selector(handleRetweetTapped))
        return button
    }()
     
    private lazy var likeButton: UIButton = {
        let button = createButton(withImageName: "like", target: self, action: #selector(handleLikeTapped))
        return button
    }()
     
    private lazy var shareButton: UIButton = {
        let button = createButton(withImageName: "share", target: self, action: #selector(handleShareTapped))
        return button
    }()
    
    // MARK: - Override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func createButton(withImageName imageName: String, target: Any, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .darkGray
        button.setDimensions(width: 20, height: 20)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return button
    }
    
    func configure() {
        guard let tweet else { return }
        
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        fullNameLabel.text = tweet.user.fullname
        userNameLabel.text = viewModel.userNameText
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTimeStamp
        retweetsLabel.attributedText = viewModel.retweetsAttributedString
        likesLabel.attributedText = viewModel.likesAttributedString
    }
    
}


// MARK: - Style & Layout

extension TweetHeader {
    
    func style() {
        
        // profile Image
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 48/2
        profileImageView.backgroundColor = .twitterBlue
        // gesture recognizer code
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true // by default interaction is not enabled
        
        // userDetailStack
        userDetailStack.axis = .vertical
        userDetailStack.distribution = .fillProportionally
        userDetailStack.spacing = 4
        
        // fullname label
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        fullNameLabel.text = "mariaana"
        
        // username label
        userNameLabel.font = UIFont.systemFont(ofSize: 16)
        userNameLabel.textColor = .lightGray
        userNameLabel.text = "gurami"
        
        // optionsButton
        optionsButton.tintColor = .lightGray
        optionsButton.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        optionsButton.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        
        // caption Label
        captionLabel.font = UIFont.systemFont(ofSize: 20)
        captionLabel.numberOfLines = 0
        captionLabel.text = "Some test caption"
        
        // dateLabel
        dateLabel.textColor = .lightGray
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textAlignment = .left
        dateLabel.text = "6:20 PM - 21-03-2023"
        
        // dividers
        dividerTop.backgroundColor = .systemGroupedBackground
        dividerBottom.backgroundColor = .systemGroupedBackground
        
        // actionStackView
        actionStackView.distribution = .fillEqually
        actionStackView.spacing = 72
        
     }
    
    // MARK: - Layout
    
    func layout() {
        addSubview(profileImageView)
        userDetailStack.addArrangedSubview(fullNameLabel)
        userDetailStack.addArrangedSubview(userNameLabel)
        addSubview(userDetailStack)
        addSubview(captionLabel)
        addSubview(dateLabel)
        addSubview(optionsButton)
        statsView.addSubview(dividerTop)
        statsView.addSubview(retweetsLabel)
        statsView.addSubview(likesLabel)
        statsView.addSubview(dividerBottom)
        addSubview(statsView)
        actionStackView.addArrangedSubview(commentButton)
        actionStackView.addArrangedSubview(retweetButton)
        actionStackView.addArrangedSubview(likeButton)
        actionStackView.addArrangedSubview(shareButton)
        addSubview(actionStackView)
        
        
        // profileImage
        profileImageView.setDimensions(width: 48, height: 48)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 8, paddingLeft: 8)
        
        // userDetail StackView
        userDetailStack.anchor(top: topAnchor, left: profileImageView.rightAnchor,
                               paddingTop: 8, paddingLeft: 8)
        
        // stackview
        captionLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        // dateLabel
        dateLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor,paddingTop: 20, paddingLeft: 16)
        
        // optionsButton
        optionsButton.centerY(inView: userDetailStack)
        optionsButton.anchor(right: rightAnchor, paddingRight: 8)
        
        // stats View
        statsView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 12, height: 40)
        
        // retweets Label
        retweetsLabel.centerY(inView: statsView)
        retweetsLabel.anchor(top: dividerTop.bottomAnchor, left: statsView.leftAnchor)
        
        // likes Label
        likesLabel.centerY(inView: retweetsLabel)
        likesLabel.anchor(left: retweetsLabel.rightAnchor, paddingLeft: 12)
        
        // dividers
        dividerTop.anchor(top: statsView.topAnchor, left: leftAnchor, right: rightAnchor, height: 1)
        dividerBottom.anchor(left: leftAnchor, bottom: statsView.bottomAnchor, right: rightAnchor, height: 1)
        
        // actionStackView
        actionStackView.anchor(top: dividerBottom.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: 4)
    }
}


// MARK: -  Actions

extension TweetHeader {
    
    @objc  func handleProfileImageTapped() {
        print("go to users profile")
    }
    
    @objc  func showActionSheet() {
        print("options button")
    }
    
    @objc  func handleCommentTapped() {
        print("any button")
    }
    
    @objc  func handleRetweetTapped() {
        print("any button")
    }
    
    @objc  func handleLikeTapped() {
        print("any button")
    }
    
    @objc  func handleShareTapped() {
        print("any button")
    }
}
