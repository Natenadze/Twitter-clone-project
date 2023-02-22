//
//  ExploreController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 22.02.23.
//

import UIKit

class ExploreController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    // MARK: - Helpers
    
    func configureUI () {
  
    }
}

// MARK: - Style & Layout

extension ExploreController {
    
    func style() {
        view.backgroundColor = .secondarySystemBackground
        
        navigationItem.title = "Explore"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func layout() {
        
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
