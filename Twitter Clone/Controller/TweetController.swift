//
//  TweetController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 07.03.23.
//

import UIKit

private let headerIdentifier = "TweetController"
private let cellReuseIdentifier = "TweetCell"

class TweetController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let tweet: Tweet
    private var replies = [Tweet]() {
        didSet { collectionView.reloadData() }
    }
    
    private var actionSheetLauncher: ActionSheetLauncher!
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchReplies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Init
    init(tweet: Tweet) {
        self.tweet = tweet
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    // MARK: - Setup
    func setup() {
        collectionView.register(TweetHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    
    // MARK: - API
    func fetchReplies() {
        TweetService.shared.fetchReplies(forTweet: tweet) { replies in
            self.replies = replies
        }
    }
    
    // MARK: - Helpers
    
    // MARK: - N E W
    // selection -> rightClick -> refactor -> Extract to Method
    fileprivate func showActionSheet(forUser user: User) {
        actionSheetLauncher = ActionSheetLauncher(user: user)
        actionSheetLauncher.delegate = self
        actionSheetLauncher.show()
    }
    
}


// MARK: - Header

extension TweetController {
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TweetHeader
        header.tweet = tweet
        header.delegate = self
        return header
    }
}

// MARK: - DataSource

extension TweetController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        replies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! TweetCell
        
        cell.tweet = replies[indexPath.row]
        return cell
    }
}

// MARK: - DelegateFlowLayout

extension TweetController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let viewModel = TweetViewModel(tweet: tweet)
        let captionHeight = viewModel.size(forWidth: view.frame.width).height
        
      return  CGSize(width: view.frame.width, height: captionHeight + 260)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 100)
    }
  
}

extension TweetController: TweetHeaderDelegate {
    
    func showActionSheet() {
        if tweet.user.isCurrentUser {
            showActionSheet(forUser: tweet.user)
        } else {
            UserService.shared.checkIfUserIsFollowed(uid: tweet.user.uid) { isFollowed in
                // didn't change tweet let to var and had to make this lines
                var user = self.tweet.user
                user.isFollowed = isFollowed
                self.showActionSheet(forUser: user)
                
            }
        }
    }
}


extension TweetController: ActionSheetLauncherDelegate {
    func didSelect(with option: ActionSheetOptions) {
        
        switch option {
        case .follow(let user):
            UserService.shared.followUser(uid: user.uid) { err, ref in
                print("follow user: \(user.username)")
            }
        case .unfollow(let user):
            UserService.shared.unfollowUser(uid: user.uid) { err, ref in
                print("unfollow user: \(user.username)")
        }
        case .report:
            print("asdas")
        case .delete:
            print("asdas")
        }
    }
    
    
}
