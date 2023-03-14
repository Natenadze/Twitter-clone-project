//
//  EditProfileCell.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 14.03.23.
//

import UIKit

protocol EditProfileCellDelegate: AnyObject {
    func updateUserInfo(_ cell: EditProfileCell)
}


class EditProfileCell: UITableViewCell {
    
    // MARK: - Properties
    
    var viewModel: EditProfileVM? {  // ? because we dont initialize it in INIT
        didSet { configure() }
    }
    
    weak var delegate: EditProfileCellDelegate?
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var infoTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textAlignment = .left
        tf.textColor = .twitterBlue
        tf.text = "asdasdasdasd asdasd"
        tf.addTarget(self, action: #selector(handleUpdateUserInfo), for: .editingDidEnd)
        return tf
    }()
    
    let bioTextView: InputTextView = {
       let tv = InputTextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        tv.textColor = .twitterBlue
        tv.placeholderLabel.text = "Bio"
        return tv
    }()
    
    
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        selectionStyle = .none  // prevent cell selection
        
        // MARK: - NEW
        // Observer
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateUserInfo), name: UITextView.textDidEndEditingNotification, object: nil)
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let viewModel else { return }
        
        
        infoTextField.isHidden = viewModel.shouldHideTextField
        bioTextView.isHidden = viewModel.shouldHideTextView
        
        titleLabel.text = viewModel.titleText
        infoTextField.text = viewModel.optionValue
        bioTextView.text = viewModel.optionValue
    }
    
}

// MARK: - Layout

extension EditProfileCell {
    
    func layout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoTextField)
        contentView.addSubview(bioTextView)
        
        
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: leftAnchor,
                          paddingLeft: 16, width: 100)
        
        infoTextField.centerY(inView: self)
        infoTextField.anchor(left: titleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 8)
        
        bioTextView.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingRight: 8)
    }
}

// MARK: - Actions
extension EditProfileCell {
    
    @objc func handleUpdateUserInfo() {
        delegate?.updateUserInfo(self)
    }
}
