//
//  ActionSheetCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 10.03.23.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    // MARK: - Properties
    private let optionImageView = UIImageView()
    private let titleLabel = UILabel()
    var option: ActionSheetOptions? {
        didSet{configure() }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        style1()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configure() {
        titleLabel.text = option?.description
    }
    
    
}

// MARK: - Style & Layout

extension ActionSheetCell {
    
    func style1() {
        // optionImage
        optionImageView.contentMode = .scaleAspectFit
        optionImageView.clipsToBounds = true
        optionImageView.image = UIImage(named: "twitter_logo_blue")
        
        // titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = " Test option"
    }
    
    func layout() {
        
        addSubview(optionImageView)
        addSubview(titleLabel)
        
        // optionImage
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left: leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(width: 36, height: 36)
        
        // titleLabel
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: optionImageView.rightAnchor, paddingLeft: 12)
        
        
    }
}
