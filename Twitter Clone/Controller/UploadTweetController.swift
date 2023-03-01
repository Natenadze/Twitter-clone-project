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
    private let profileImage = UIImageView()
    private let postLabel = UILabel()
    private let user: User
    
    let stackview = UIStackView()
    private let captionTextview = CaptionTextView()
    
    
    // MARK: - ViewDidLoad -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
    }
    
    init(user: User) {
        self.user = user
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



// MARK: - Style & Layout

extension UploadTweetController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground

        //ActionButton
        actionButton.backgroundColor = .twitterBlue
        actionButton.setTitle("Tweet", for: .normal)
        actionButton.titleLabel?.textAlignment =  .center
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 32 / 2
        actionButton.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        // stackView
        stackview.axis = .horizontal
        stackview.spacing = 12

        
        // Profile image
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 48/2
        profileImage.sd_setImage(with: user.profileImageUrl)
        
        
    }
    
    func layout() {
        stackview.addArrangedSubview(profileImage)
        stackview.addArrangedSubview(captionTextview)
        view.addSubview(stackview)
        
        // Action button
        actionButton.setDimensions(width: 64, height: 32)
        
        // stackView
        stackview.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        // Profile image
        profileImage.setDimensions(width: 48, height: 48)
        profileImage.anchor(top: stackview.topAnchor, left: stackview.leftAnchor)
    }
}

// MARK: - Actions
extension UploadTweetController {
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
     @objc func handleUploadTweet() {
         guard let caption = captionTextview.text else { return }
         TweetService.shared.uploadTweet(caption: caption) { error, ref in
             if let error {
                 print("DEBUG: failed to upload tweet with error: \(error.localizedDescription)")
                 return
             }
             self.dismiss(animated: true)
             
         }
    }
    
}
