//
//  TweetCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 01.03.23.
//

import UIKit
import ActiveLabel

// MARK: - Protocol
protocol TweetCellDelegate: AnyObject {
    func handleProfileImageTapped(_ cell: TweetCell)
    func handleReplyTapped(_ cell: TweetCell)
    func handleLikeTapped(_ cell: TweetCell)
    func handleFetchUser(withUsername username: String)
}

// MARK: - Class

class TweetCell: UICollectionViewCell {
    
    // MARK: - properties
    
    // anytime tweet property changes, it calls configure and refreshes data
    var tweet: Tweet? {
        didSet { configure() }
    }
    
    weak var delegate: TweetCellDelegate?
    
    private let mainStack = UIStackView()
    private let captionStackview = UIStackView()
    private let imageCaptionStack = UIStackView()
    private let profileImageView = UIImageView()
    private let captionLabel = ActiveLabel()
    private let infoLabel = UILabel()
    
    private let actionStackView = UIStackView()
    
    private let commentButton = UIButton(type: .system)
    private let retweetButton = UIButton(type: .system)
    private let likeButton    = UIButton(type: .system)
    private let shareButton   = UIButton(type: .system)
    
    private let replyLabel = ActiveLabel()
    
    private let underlineView = UIView()
    
    
    // MARK: - Override func
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        configureMentionHandler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure functions
    
    func configure() {
        guard let tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        infoLabel.attributedText = viewModel.userInfoText
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        replyLabel.isHidden = viewModel.shouldHideReplyLabel
        replyLabel.text = viewModel.replyText
    }
    
    func configureMentionHandler() {
        captionLabel.handleMentionTap { mention in
            self.delegate?.handleFetchUser(withUsername: mention)
        }
    }
}


extension TweetCell {
    
    func style() {
        
        // mainStack
        mainStack.axis = .vertical
        mainStack.spacing = 8
        
        // stackview
        captionStackview.axis = .vertical
        captionStackview.distribution = .fillProportionally
        
        // action  StackView
        actionStackView.distribution = .fillEqually
        actionStackView.spacing = 72
        
        // imageCaption StackView
        imageCaptionStack.distribution = .fillProportionally
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        
        
        // profile Image
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 48/2
        profileImageView.backgroundColor = .twitterBlue
        // gesture recognizer code
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true // by default interaction is not enabled
        
        
        // caption Label
        captionLabel.font = UIFont.systemFont(ofSize: 14)
        captionLabel.numberOfLines = 0
        captionLabel.minimumScaleFactor = 13
        captionLabel.mentionColor = .twitterBlue
        captionLabel.hashtagColor = .twitterBlue
        
        
        // infoLabel
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
      
        
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
        likeButton.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        
        // share Btn
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.tintColor = .darkGray
        shareButton.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        
        // reply label
        replyLabel.textColor = .lightGray
        replyLabel.font = UIFont.systemFont(ofSize: 12)
        replyLabel.mentionColor = .twitterBlue
        
        //underlineView
        underlineView.backgroundColor = .systemGroupedBackground
    }
    
    // MARK: - layout
    
    func layout() {
//        addSubview(profileImageView)
        captionStackview.addArrangedSubview(infoLabel)
        captionStackview.addArrangedSubview(captionLabel)
        
        actionStackView.addArrangedSubview(commentButton)
        actionStackView.addArrangedSubview(retweetButton)
        actionStackView.addArrangedSubview(likeButton)
        actionStackView.addArrangedSubview(shareButton)
        addSubview(actionStackView)
        imageCaptionStack.addArrangedSubview(profileImageView)
        imageCaptionStack.addArrangedSubview(captionStackview)
        addSubview(underlineView)
        
        // mainStack
        mainStack.addArrangedSubview(replyLabel)
        mainStack.addArrangedSubview(imageCaptionStack)
        addSubview(mainStack)
        
        mainStack.anchor(top: topAnchor, left: leftAnchor,
                         right: rightAnchor, paddingTop: 4, paddingLeft: 12, paddingRight: 12)
        
        // profileImage
        profileImageView.setDimensions(width: 48, height: 48)

        
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
        actionStackView.centerX(inView: self)
        actionStackView.anchor(bottom: bottomAnchor, paddingBottom: 8)
       
        
        //underlineView
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
    }
    
}


// MARK: -  Actions

extension TweetCell {
    
    @objc  func handleProfileImageTapped() {
        delegate?.handleProfileImageTapped(self)
    }
    
    @objc  func handleCommentTapped() {
        delegate?.handleReplyTapped(self)
    }
    
    @objc  func handleRetweetTapped() {
        
    }
    
    @objc  func handleLikeTapped() {
        delegate?.handleLikeTapped(self)
    }
    
    @objc  func handleShareTapped() {
        
    }
    
}
