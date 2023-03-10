//
//  SceneDelegate.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
//        window?.rootViewController = UINavigationController(rootViewController: LoginController())
//        window?.rootViewController = UINavigationController(rootViewController: RegistrationController())
        window?.rootViewController = MainTabController()
        window?.makeKeyAndVisible()
        
    }
    

}

