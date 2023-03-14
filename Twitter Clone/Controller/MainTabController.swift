//
//  MainTabController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//

import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    var user: User? {
        // didSet guarantees that feed.user gets value right after this user gets its value
        didSet {
            // feed controller is embed in NavigationController itself
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    let actionButton = UIButton(type: .system)
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        logUserOut()
        view.backgroundColor = .twitterBlue // prevent black screen visibility at the start
        authenticateUserAndConfigureUI()
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
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
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
        nav.setStatusBar(withColor: .white)
        return nav
    }
    
}

// MARK: - API
extension MainTabController {
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .overFullScreen
                self.present(nav, animated: true)
            }
        }else {
            style()
            layout()
            configureViewControllers()
            fetchUser()
        }
    }
    
    func logUserOut() {
        try? Auth.auth().signOut()
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


// MARK: - Actions
extension MainTabController {
    
    @objc func actionButtonTapped() {
        guard let user else { return }
        let controller = UploadTweetController(user: user, config: .tweet)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        nav.setStatusBar(withColor: .white)
        present(nav, animated: true)
    }
}




