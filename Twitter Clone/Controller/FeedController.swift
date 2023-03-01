//
//  FeedController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//


import UIKit
import SDWebImage


class FeedController: UIViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    let iconImageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    let profileImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}



// MARK: - Style & Layout

extension FeedController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        // profile Image
        profileImageView.layer.cornerRadius = 16
        profileImageView.layer.masksToBounds = true
        
        // iconImageView 
        iconImageView.contentMode = .scaleAspectFit
        
    }
    
    func layout() {
        
        iconImageView.setDimensions(width: 44, height: 44)  // explicit size to keep it bar centered
        navigationItem.titleView = iconImageView
        
        // profile Image
        profileImageView.setDimensions(width: 32, height: 32)
       
    }
}



extension FeedController {
    func configureLeftBarButton() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

// MARK: - Actions
