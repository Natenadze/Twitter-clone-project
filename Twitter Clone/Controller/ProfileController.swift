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
    
    // MARK: - Properties
    
    
    private var user: User
    
    private var tweets = [Tweet]() {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Override funcs
    
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
        //        navigationController?.navigationBar.tintColor = UIColor.black
    }
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //    return .lightContent
    //    }
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setup() {
        
        // makes sure that header color goes over safe area
        collectionView.contentInsetAdjustmentBehavior = .never
        // register collection View
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        // register header
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        fetchTweets()
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    // MARK: - API
    
    func fetchTweets() {
        TweetService.shared.fetchTweets(forUser: user) { tweets in
            self.tweets = tweets
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
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
        
        header.user = user
        header.delegate = self
        return header
    }
    // Cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}


// MARK: -  UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 100)
    }
}



// MARK: - Actions

extension ProfileController: ProfileHeaderDelegate {
    func HandleEditProfileFollow(_ header: ProfileHeader) {
        
        if user.isCurrentUser {
            // show edit profile controller
            return
        }
        
        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user.uid) { error, ref in
                self.user.isFollowed = false
                self.collectionView.reloadData()
//                header.editProfileFollowButton.setTitle("Follow", for: .normal)
            }
        }else {
            UserService.shared.followUser(uid: user.uid) { ref, error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
