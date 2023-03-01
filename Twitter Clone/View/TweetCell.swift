//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 01.03.23.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    // MARK: - properties
    
    private let stackview = UIStackView()
    private  let profileImageView = UIImageView()
    private let captionLabel = UILabel()
    private let infoLabel = UILabel()
    
    private let actionStackView = UIStackView()
    private let commentButton = UIButton(type: .system)
    private let retweetButton = UIButton(type: .system)
    private let likeButton    = UIButton(type: .system)
    private let shareButton   = UIButton(type: .system)
    
    private let underlineView = UIView()
    
    
    // MARK: - Override func
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TweetCell {
    
    func style() {
        
        
        // profile Image
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 48/2
        profileImageView.backgroundColor = .twitterBlue
        
        
        // caption Label
        captionLabel.font = UIFont.systemFont(ofSize: 12)
        captionLabel.numberOfLines = 0
        captionLabel.text = "Some test caption"
        
        // infoLabel
        infoLabel.font = UIFont.systemFont(ofSize: 12)
        
        // stackview
        stackview.axis = .vertical
        stackview.distribution = .fillProportionally
        
        // infoLabel
        infoLabel.text = "Mark Jija @venom"
        
        // action  StackView
        actionStackView.distribution = .fillEqually
        actionStackView.spacing = 72
        
        
        // comment Btn
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        commentButton.tintColor = .darkGray
        commentButton.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        // retweeet Btn
        retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
        retweetButton.tintColor = .darkGray
        retweetButton.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        
        // Like Btn
        likeButton.setImage(UIImage(named: "like"), for: .normal)
        likeButton.tintColor = .darkGray
        likeButton.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        // share Btn
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.tintColor = .darkGray
        shareButton.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        
        
        //underlineView
        underlineView.backgroundColor = .systemGroupedBackground
    }
    
    // MARK: - layout
    
    func layout() {
        addSubview(profileImageView)
        stackview.addArrangedSubview(infoLabel)
        stackview.addArrangedSubview(captionLabel)
        addSubview(stackview)
        actionStackView.addArrangedSubview(commentButton)
        actionStackView.addArrangedSubview(retweetButton)
        actionStackView.addArrangedSubview(likeButton)
        actionStackView.addArrangedSubview(shareButton)
        addSubview(actionStackView)
        addSubview(underlineView)
        
        // profileImage
        profileImageView.setDimensions(width: 48, height: 48)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 8, paddingLeft: 8)
        
        // stackview
        stackview.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor,
                         right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        // Comment Btn
        commentButton.setDimensions(width: 20, height: 20)
//
        // retweet Btn
        retweetButton.setDimensions(width: 20, height: 20)

        // like Btn
        likeButton.setDimensions(width: 20, height: 20)

        // share Btn
        shareButton.setDimensions(width: 20, height: 20)
//
        // action Stack
        actionStackView.anchor(left: profileImageView.rightAnchor, bottom: underlineView.topAnchor, paddingBottom: 8)
        
        //underlineView
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
    }
    
}


// MARK: -  Actions

extension TweetCell {
    @objc  func handleCommentTapped() {
        
    }
    
    @objc  func handleRetweetTapped() {
        
    }
    
    @objc  func handleLikeTapped() {
        
    }
    
    @objc  func handleShareTapped() {
        
    }
    
}
