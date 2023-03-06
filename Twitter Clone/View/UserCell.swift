//
//  UserCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 06.03.23.
//

import UIKit

class UserCell: UITableViewCell {
    
    // Properties
    var user: User? {
        didSet { configure() }
    }
    
    let profileImageView = UIImageView()
    private let stackView = UIStackView()
    let userNameLabel = UILabel()
    let fullNameLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        style1()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        userNameLabel.text = user.username
        fullNameLabel.text = user.fullname
    }
    
}


extension UserCell {
    
    func style1() {
        // profile Image
        profileImageView.contentMode = .scaleToFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 40/2
        profileImageView.backgroundColor = .twitterBlue
        
        // stackView
        stackView.axis = .vertical
        stackView.spacing = 2
        
        // userName
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        userNameLabel.text = "Username"
        
        // fullNameLabel
        fullNameLabel.font = UIFont.systemFont(ofSize: 14)
        fullNameLabel.text = "Fullname"
    }
     
    func layout() {
        addSubview(profileImageView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(fullNameLabel)
        addSubview(stackView)
        
        // Image View
        profileImageView.setDimensions(width: 40, height: 40)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        // stackView
        stackView.centerY(inView: self, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12  )
    }
    
}
