//
//  ProfileController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 02.03.23.
//

import UIKit

private let reuseIdentifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.barStyle = UIBarStyle.default
//        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//            return .lightContent
//        }
    
    
    
    func setup() {
//        navigationController?.navigationBar.isHidden = true
        
        
        // makes sure that header color goes over safe area
        collectionView.contentInsetAdjustmentBehavior = .never
        // register collection View
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // register header
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)

    }
    
    
}

// MARK: - Style & Layout

extension ProfileController {
    
    func style() {
        
    }
    
    func layout() {
        
        
    }
}

// MARK: -  UICollectionView dataSource

extension ProfileController {
    
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        return header
    }
    // Cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        
        return cell
    }
}


// MARK: -  UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 100)
    }
}
