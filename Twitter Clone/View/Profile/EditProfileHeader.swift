//
//  EditProfileHeader.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 13.03.23.
//

import UIKit

protocol EditProfileHeaderDelegate: AnyObject {
    func didTapChangeProfilePhoto()
}

class EditProfileHeader: UIView {
    
    // MARK: - Properties
    private let user: User
    
    let profileImageView = UIImageView()
    private let changePhotoButton = UIButton()
    
    weak var delegate: EditProfileHeaderDelegate?
    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension EditProfileHeader {

    func style() {
        backgroundColor = .twitterBlue
        
        // profileImageView
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        // changePhotoButton
        changePhotoButton.setTitle("Change Profile Photo", for: .normal)
        changePhotoButton.addTarget(self, action: #selector(handlePhotoChange), for: .touchUpInside)
        changePhotoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        changePhotoButton.setTitleColor(.white, for: .normal)
    }

    func layout() {
        addSubview(profileImageView)
        addSubview(changePhotoButton)
        
        // imageView
        profileImageView.center(inView: self, yConstant: -16)
        profileImageView.setDimensions(width: 100, height: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        
        // change button
        changePhotoButton.centerX(inView: self, topAnchor: profileImageView.bottomAnchor, paddingTop: 8)

    }
}

// MARK: - Actions

extension EditProfileHeader {
    @objc func handlePhotoChange() {
        delegate?.didTapChangeProfilePhoto()
    }
}
