//
//  EditProfileController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 13.03.23.
//


import UIKit

private let reuseIdentifier = "EditProfileCell"

protocol EditProfileControllerDelegate: AnyObject {
    func controller(_ controller: EditProfileController, wantsToUpdate user: User)
}


class EditProfileController: UITableViewController {
    
    // MARK: - Properties
    private var user: User
    // lazy var, because it needs to wait for user to be initialized
    private lazy var headerView = EditProfileHeader(user: user)
    
    private let imagePicker = UIImagePickerController()
    private var selectedImage: UIImage? {
        didSet { headerView.profileImageView.image = selectedImage }
    }
    
    private var userInfoChanged = false
    weak var delegate: EditProfileControllerDelegate?
    
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
   
    // MARK: - API
    
    func updateUserData() {
        UserService.shared.saveUserData(user: user) { err, ref in
            self.delegate?.controller(self, wantsToUpdate: self.user)
        }
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
        tableView.register(EditProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        // imagepicker
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
    }
    
    func layout() {
        
        // tableView
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 180)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - TableView Delegate / Datasource

extension EditProfileController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EditProfileOptions.allCases.count  // 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EditProfileCell
        cell.delegate = self
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return cell }
        cell.viewModel = EditProfileVM(user: user, option: option)
        
        return cell
    }
    
    // Row Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let option = EditProfileOptions(rawValue: indexPath.row) else { return 0 }

        // giving different height to cells
        return option == .bio ? 100 : 48
    }
}

// MARK: - Actions

extension EditProfileController {
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleDone() {
        updateUserData()
    }
}

// MARK: - Delegate Conformance

extension EditProfileController: EditProfileHeaderDelegate {
    func didTapChangeProfilePhoto() {
        present(imagePicker, animated: true)
    }
    
}

extension EditProfileController: EditProfileCellDelegate {
    func updateUserInfo(_ cell: EditProfileCell) {
        guard let viewModel = cell.viewModel else { return }
        userInfoChanged = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        switch viewModel.option {
            
        case .fullname:
            guard let fullName = cell.infoTextField.text else { return }
            user.fullname = fullName
        case .username:
            guard let userName = cell.infoTextField.text else { return }
            user.fullname = userName
        case .bio:
            user.bio = cell.bioTextView.text
        }
    }
}

// MARK: - Image Picker Delegate

extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        self.selectedImage = image
        dismiss(animated: true)
    }
}
