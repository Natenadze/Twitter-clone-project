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
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        style1()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

// MARK: - Style & Layout

extension NotificationCell {
    
    func style1() {
        // profile Image
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 48/2
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
        stackView.alignment = .leading
    }
    
    func layout() {
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(notificationLabel)
        addSubview(stackView)
        
        
        // image
        profileImageView.setDimensions(width: 48, height: 48)
        
        // label
        notificationLabel.centerY(inView: self)
        
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
