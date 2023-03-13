//
//  EditProfileController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 13.03.23.
//


import UIKit

class EditProfileController: UITableViewController {
    
    // MARK: - Properties
    private let user: User
    // lazy var, because it needs to wait for user to be initialized
    private lazy var headerView = EditProfileHeader(user: user)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.delegate = self
        style()
        layout()
        
        
    }
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
}

// MARK: - Style & Layout

extension EditProfileController {
    
    func style() {
        navigationItem.title = "Edit Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        // tableView
        tableView.tableHeaderView = headerView
        
        
    }
    
    func layout() {
        
        // tableView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - Actions

extension EditProfileController {
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        dismiss(animated: true)
    }
}

// MARK: - Delegate Conformance

extension EditProfileController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        print("change photo")
    }
    
    
}
