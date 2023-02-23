//
//  MainTabController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//

import UIKit

class MainTabController: UITabBarController {
    
    let actionButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        style()
        layout()
    }
    
    // MARK: - Making tab bar visible (stackoverflow solution)
    //    func uiTabBarSetting() {
    //        if #available(iOS 15.0, *){
    //            let appearance = UITabBarAppearance()
    //            appearance.configureWithOpaqueBackground()
    //            appearance.backgroundColor = .systemGray5
    //            tabBar.standardAppearance = appearance
    //            tabBar.scrollEdgeAppearance = appearance
    //        }
    //    }
    
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let explore = ExploreController()
        let notifications = NotificationsController()
        let conversations = ConversationsController()
        
        
        // Images
        let feedImage = UIImage(named: "home_unselected")
        let exploreImage = UIImage(named: "search_unselected")
        let notificationsImage = UIImage(named: "like_unselected")
        let conversationsImage = UIImage(named: "ic_mail_outline_white_2x-1")
        
        // Embed in NavigationBar
        let feedNC = templateNavController(image: feedImage, rootVC: feed)
        let exploreNC = templateNavController(image: exploreImage, rootVC: explore)
        let notificationsNC = templateNavController(image: notificationsImage, rootVC: notifications)
        let conversationsNC = templateNavController(image: conversationsImage, rootVC: conversations)
        
        let tabBarList = [feedNC, exploreNC, notificationsNC, conversationsNC]
        viewControllers = tabBarList
    }
    
    // Function for embedding in Nav Bar
    func templateNavController(image: UIImage?, rootVC: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = image
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        return nav
    }
    
    
}

// MARK: - Actions
extension MainTabController {
    
    @objc func actionButtonTapped() {
        print("xXx")
    }
}




// MARK: - Style & Layout

extension MainTabController {
    
    func style() {
        tabBar.backgroundColor = .systemGray5
        
        // ActionButton
        actionButton.translatesAutoresizingMaskIntoConstraints = false // Activates programmatic autoLayout
        actionButton.tintColor = .white
        actionButton.backgroundColor = .twitterBlue  // from extension
        actionButton.layer.cornerRadius = 56/2
        actionButton.setImage(UIImage(named: "new_tweet"), for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    func layout() {
        view.addSubview(actionButton)
        
        // using helper extension function
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 64, paddingRight: 16,
                            width: 56, height: 56)
        
        
    }
}
