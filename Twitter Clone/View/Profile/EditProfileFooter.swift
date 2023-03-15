//
//  EditProfileFooter.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 15.03.23.
//


import UIKit

protocol EditProfileFooterDelegate: AnyObject {
    func handleLogout()
}
 
class EditProfileFooter: UIView {
    
    // MARK: - Properties
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: EditProfileFooterDelegate?
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    
    func layout() {
        addSubview(logoutButton)
        
        // button frame  = viewFrame
        logoutButton.anchor(left: leftAnchor, right: rightAnchor,
                            paddingLeft: 16, paddingRight: 16, height: 50)
        
    }
    
    
  // MARK: - Action
    
    @objc func handleLogout() {
        delegate?.handleLogout()
    }
    
    
}


