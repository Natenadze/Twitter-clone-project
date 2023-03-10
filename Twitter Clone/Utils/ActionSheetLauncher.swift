//
//  ActionSheetLauncher.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 08.03.23.
//

import UIKit

private let reuseIdentifier = "ActionSheetCell"

protocol ActionSheetLauncherDelegate: AnyObject {
    func didSelect(with option: ActionSheetOptions)
}

class ActionSheetLauncher: NSObject  {
    
    
    // MARK: - Properties
    
    private let user: User
    private let tableView = UITableView()
    private var window: UIWindow?  // for backdrop of tableview
    private lazy var viewModel = ActionSheetViewModel(user: user)
    private var tableViewHeight: CGFloat!
    
    weak var delegate: ActionSheetLauncherDelegate?
    
    private lazy var blackView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.5) //
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.anchor(left: view.leftAnchor, right: view.rightAnchor,
                            paddingLeft: 12, paddingRight: 12)
        cancelButton.centerY(inView: view)
        cancelButton.layer.cornerRadius = 50 / 2
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
     init(user: User) {
         
        self.user = user
         super.init()
         
         configureTableView()
         
    }
    
    // MARK: - Helpers
    
    func showTableView(_ shouldShow: Bool) {
        guard let window else { return }
        let y = shouldShow ? window.frame.height - tableViewHeight : window.frame.height
        tableView.frame.origin.y = y
    }
    
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
        self.tableViewHeight = CGFloat(viewModel.options.count * 50) + 100 // row height is 60
        
        tableView.frame = CGRect(x: 0, y: window.frame.height,
                                 width: window.frame.width, height: tableViewHeight )
        
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 1
//            self.tableView.frame.origin.y -= self.tableViewHeight   // slide effect from bottom
            self.showTableView(true)  // slide effect from bottom
        }
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 5
        tableView.isScrollEnabled = false
        
        tableView.register(ActionSheetCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}


// MARK: - TableView Delegate / DataSource

extension ActionSheetLauncher: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ActionSheetCell
        cell.option = viewModel.options[indexPath.row]
        return cell
    }
    
    // Footer height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
    }
    
    // return view for footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = viewModel.options[indexPath.row]
        
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            self.showTableView(false)  // slide effect from bottom
        } completion: { _ in
            self.delegate?.didSelect(with: option) // when action sheet dismiss animation completes
        }
    }
    
}

// MARK: - Actions


extension ActionSheetLauncher {
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.3) {
            self.blackView.alpha = 0
            self.tableView.frame.origin.y += 300
        }
    }
}
