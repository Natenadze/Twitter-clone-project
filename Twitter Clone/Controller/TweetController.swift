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
        
        didSet {
            print("replies count is: \(replies.count)")
            collectionView.reloadData()
            
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchReplies()
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
    
}


// MARK: - Header

extension TweetController {
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! TweetHeader
        header.tweet = tweet
        
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
