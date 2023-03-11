//
//  UploadTweetController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 01.03.23.
//

import UIKit



class UploadTweetController: UIViewController {
    
    // MARK: - properties
    
    private let actionButton = UIButton(type: .system)
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private let imageCaptionStack = UIStackView()
    private let captionTextview = CaptionTextView()
    private let profileImage = UIImageView()
    
    private let mainStackView = UIStackView()
    
    private let replyLabel = UILabel()
    
    
    // MARK: - ViewDidLoad -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
    }
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    func setup() {
        // navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
        
        
    }
    
    
    
}



// MARK: - Style 

extension UploadTweetController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        // captionText
        captionTextview.placeholderLabel.text = viewModel.placeholderText
        
        //ActionButton
        actionButton.backgroundColor = .twitterBlue
        actionButton.setTitle("Tweet", for: .normal)
        actionButton.titleLabel?.textAlignment =  .center
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 32 / 2
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        // stackView
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading  // upload tweet graph increases with text if needed

        
        // Profile image
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 48/2
        profileImage.sd_setImage(with: user.profileImageUrl)
        
        // reply Label
        replyLabel.font = UIFont.systemFont(ofSize: 14)
        replyLabel.textColor = .gray
        replyLabel.text = viewModel.replyText ?? ""
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        
        
        
        // main stack
        mainStackView.axis = .vertical
        mainStackView.spacing = 12
        
    }
    
    // MARK: - Layout
    
    func layout() {
        
        imageCaptionStack.addArrangedSubview(profileImage)
        imageCaptionStack.addArrangedSubview(captionTextview)
        
        mainStackView.addArrangedSubview(replyLabel)
        mainStackView.addArrangedSubview(imageCaptionStack)
        view.addSubview(mainStackView)
        
        // Action button
        actionButton.setDimensions(width: 64, height: 32)
        
        
        // stackView
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor, right: view.rightAnchor,
                             paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        // Profile image
        profileImage.setDimensions(width: 48, height: 48)
        profileImage.anchor(top: imageCaptionStack.topAnchor, left: imageCaptionStack.leftAnchor)
    }
}

// MARK: - Actions
extension UploadTweetController {
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
     @objc func handleUploadTweet() {
         guard let caption = captionTextview.text else { return }
         TweetService.shared.uploadTweet(caption: caption, type: config) { error, ref in
             if let error {
                 print("DEBUG: failed to upload tweet with error: \(error.localizedDescription)")
                 return
             }
             // if reply == config
             // if we are in a reply configuration and we have access to the tweet
             if case .reply(let tweet) = self.config {
                 NotificationService.shared.uploadNotification(type: .reply, tweet: tweet)
             }
             
             self.dismiss(animated: true)
         }
    }
    
}
