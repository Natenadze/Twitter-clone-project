//
//  FeedController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//


import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"


class FeedController: UICollectionViewController {
    
    // MARK: - Properties
    var user: User? {
        didSet {
            configureLeftBarButton()
        }
    }
    
    private var tweets = [Tweet]() {
        didSet { collectionView.reloadData() }
    }
    
    let iconImageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
    let profileImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setupCollectionView()
        fetchTweets()
    }
    
    
    // MARK: - setup functions
    
    func setupCollectionView() {
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // API
    func fetchTweets() {
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets
        }
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

// MARK: - Collection View
extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: 100)
    }
}



// MARK: - Actions
extension FeedController {
    

}


