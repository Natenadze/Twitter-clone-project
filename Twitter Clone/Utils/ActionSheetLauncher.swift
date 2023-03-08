//
//  ActionSheetLauncher.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 08.03.23.
//

import UIKit

private let reuseIdentifier = "ActionSheetCell"

class ActionSheetLauncher: NSObject  {
    
    
    // MARK: - Properties
    
    private let user: User
    private let tableView = UITableView()
    private var window: UIWindow?  // for backdrop of tableview
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5) //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    // MARK: - Init
    
     init(user: User) {
         
        self.user = user
         super.init()
         
         configureTableView()
         
    }
    
    // MARK: - Helpers
    
    func show() {
        // MARK: - DEPRECATED
//        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        
        self.window = window
        window.addSubview(blackView)
        window.addSubview(tableView)
        
        // tableview layout
        blackView.frame = window.frame
        
        tableView.frame = CGRect(x: 0, y: window.frame.height,
                                 width: window.frame.width, height: 300)
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
            self.tableView.frame.origin.y -= 300  // slide effect from bottom
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.fillerRowHeight = 60
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}


extension ActionSheetLauncher: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
    
}

// MARK: - Actions


extension ActionSheetLauncher {
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += 300
        }
    }
}
