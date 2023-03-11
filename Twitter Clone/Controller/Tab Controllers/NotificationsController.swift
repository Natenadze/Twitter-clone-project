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


extension NotificationsController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        
        cell.notification = notifications[indexPath.row]
        return cell
    }
}
