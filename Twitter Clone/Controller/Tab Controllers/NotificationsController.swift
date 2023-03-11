//
//  NotificationsController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//

import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationsController: UITableViewController {
    
  // MARK: - Properties
    
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - API
    func fetchNotifications() {
        NotificationService.shared.fetchNotifications { notif in
            self.notifications = notif
        }
    }
    
  
}

// MARK: - Style & Layout

extension NotificationsController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        navigationItem.title = "Notifications"
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
    
    }
    
    func layout() {
        tableView.rowHeight = 60
    }
}

// MARK: - DataSource

extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        cell.notification = notifications[indexPath.row]
        cell.delegate = self
        return cell
    }
    
   
}

// MARK: - TableView Delegate

extension NotificationsController  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notif = notifications[indexPath.row]
        guard let tweetID = notif.tweetID else { return }
        
        // fetch and go to selected tweet
        TweetService.shared.fetchSingleTweet(withTweetID: tweetID) { tweet in
            let controller = TweetController(tweet: tweet)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

// MARK: - NotificationCellDelegate

extension NotificationsController: NotificationCellDelegate {
    
    func didTapProfileImage(_ cell: NotificationCell) {
        guard let user = cell.notification?.user else { return }
        
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
