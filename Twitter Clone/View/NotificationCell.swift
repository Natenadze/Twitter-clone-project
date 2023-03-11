//
//  NotificationCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 11.03.23.
//

import UIKit



class NotificationCell: UITableViewCell {
    
    // MARK: - Properties
    private let profileImageView = UIImageView()
    private let notificationLabel = UILabel()
    private let stackView = UIStackView()
    
    var notification: Notification? {
        didSet { configure() }
    }
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        style1()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let notification else { return }
        
        let viewModel = NotificationViewModel(notification: notification)
        
        // update properties
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        notificationLabel.attributedText = viewModel.notifText
        
    }
    
}

// MARK: - Style & Layout

extension NotificationCell {
    
    func style1() {
        // profile Image
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40/2
        profileImageView.backgroundColor = .twitterBlue
        // gesture recognizer code
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true // by default interaction is not enabled
        
        // notif label
        notificationLabel.numberOfLines = 2
        notificationLabel.font = UIFont.systemFont(ofSize: 14)
        notificationLabel.text = "Some test notification message"
        
        // stackView
        stackView.spacing = 8
        stackView.alignment = .center  // no need of: notificationLabel.centerY(inView: self)
    }
    
    func layout() {
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(notificationLabel)
        addSubview(stackView)
        
        
        // image
        profileImageView.setDimensions(width: 40, height: 40)
        
        // stackView
        stackView.centerY(inView: self)
        stackView.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 12)
    }
}


// MARK: - Actions
extension NotificationCell {
    @objc func handleProfileImageTapped() {
        
    }
}
