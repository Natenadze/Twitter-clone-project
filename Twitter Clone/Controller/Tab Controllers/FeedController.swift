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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // to keep navigation bar showing, when coming back from profile page
        navigationController?.navigationBar.isHidden = false
    }
    
    
    // MARK: - setup functions
    
    func configureLeftBarButton() {
        guard let user else { return }
        profileImageView.sd_setImage(with: user.profileImageUrl)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    func setupCollectionView() {
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // API
    func fetchTweets() {
        collectionView.refreshControl?.beginRefreshing()
        TweetService.shared.fetchTweets { tweets in
            self.tweets = tweets.sorted(by: { $0.timestamp > $1.timestamp })
            self.checkIfUserLikesTweets()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
    
    // API Helper
    func checkIfUserLikesTweets() {
        self.tweets.forEach { tweet in
            TweetService.shared.checkIfUserLikesTweet(tweet) { didLike in
                guard didLike == true else { return }
                
                if let index = self.tweets.firstIndex(where: {$0.tweetID == tweet.tweetID}) {
                    self.tweets[index].didLike = true
                }
            }
        }
    }
    
}


// MARK: - Style & Layout

extension FeedController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
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

// MARK: - CollectionView Delegate

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Go to tweet VC
        let controller = TweetController(tweet: tweets[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - CollectionView DataSource
extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let viewModel = TweetViewModel(tweet: tweets[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height
        
        return CGSize(width: view.frame.width, height: height + 88)
    }
}



// MARK: - Actions

extension FeedController: TweetCellDelegate {
    // go to user when tapping on mention
    func handleFetchUser(withUsername username: String) {
        UserService.shared.fetchUser(withUsername: username) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func handleLikeTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        
        TweetService.shared.likeTweet(tweet: tweet) { err, ref in
            cell.tweet?.didLike.toggle()
            let likes = tweet.didLike ? tweet.likes - 1 : tweet.likes + 1
            cell.tweet?.likes = likes
            
            // upload Notification
            // only when its like notif ( not unlike )
            guard !tweet.didLike else { return }
            NotificationService.shared.uploadNotification(type: .like, tweet: tweet)
        }
    }
    
    func handleReplyTapped(_ cell: TweetCell) {
        guard let tweet = cell.tweet else { return }
        let controller = UploadTweetController(user: tweet.user, config: .reply(tweet))

        let nav  = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    
    func handleProfileImageTapped(_ cell: TweetCell) {
        // Transition to Collection View
        guard let user = cell.tweet?.user else { return }
        let vc = ProfileController(user: user)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func handleRefresh() {
        fetchTweets()
    }
    
}
