//
//  ExploreController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//

import UIKit

private let reuseIdentifier = "UserCell"

enum SearchControllerConfig {
    case messages
    case userSearch
}

class SearchController: UITableViewController {
    
    // Properties
    
    private let config: SearchControllerConfig
    
    private var users = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var filteredUsers = [User]() {
        didSet { tableView.reloadData() }
    }
    
    private var isSearchMode: Bool {
        // if user is typing smth or not
        // if we ar in a search mode
        searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
     
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        fetchUsers()
    }
    
    // viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // to keep navigation bar showing, when coming back from profile page
        navigationController?.navigationBar.isHidden = false
    }
    
    init(config: SearchControllerConfig) {
        self.config = config
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    func fetchUsers() {
        UserService.shared.fetchUser { users in
            self.users = users
        }
    }
    
    // MARK: - Helpers
    
    func setup () {
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        if config == .messages {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        }
    }
  
}

// MARK: - Style & Layout

extension SearchController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        navigationItem.title = config == .messages ? "New Message" : "Explore"
        
        // SearchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for user"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = false
        
        // tableView
        tableView.separatorStyle = .none
        
        
        
    }
    
    func layout() {
        
        tableView.rowHeight = 60
    }
}

// MARK: - TableView Delegate

extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - TableView DataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if user uses filter
        isSearchMode ? filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        // populate cell from custom cell and not from here
        let user = isSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        cell.user = user
        
        return cell
    }
}

// MARK: - Update Search results
extension SearchController: UISearchResultsUpdating {
    
    // to filter after searchController
    // this gets called on every letter written//deleted in searchBar
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        filteredUsers = users.filter({ $0.username.contains(searchText) })
    }
    
    
}

// MARK: - Actions

extension SearchController {
    @objc func handleDismissal() {
        dismiss(animated: true)
    }
}
