//
//  UIViewController+Utils.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 01.03.23.
//

import UIKit

extension UIViewController {
    
    func setStatusBar(withColor color: UIColor) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
//        navBarAppearance.configureWithTransparentBackground() // to hide Navigation Bar Line
        navBarAppearance.backgroundColor = color
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = .white

    }
    
    // ??
//    func setStatusBar2() {
//
//
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
//        navigationController?.navigationBar.isTranslucent = false
//    }
    
        
}
