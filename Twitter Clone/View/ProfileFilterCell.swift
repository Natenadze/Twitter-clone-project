//
//  ProfileFilterCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 03.03.23.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    
    let titleLabel = UILabel()
    
    var option: ProfileFilterOptions! {
        didSet {
            titleLabel.text = option.desctiption
        }
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
}

// MARK: - Style & Layout

extension ProfileFilterCell {
    
    func style() {
        backgroundColor = .white
        
        titleLabel.textColor = .lightGray
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = "muraba"
    }
    
    func layout() {
        addSubview(titleLabel)
        
        titleLabel.center(inView: self)
    }
}
