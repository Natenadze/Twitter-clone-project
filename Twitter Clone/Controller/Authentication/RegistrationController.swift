//
//  RegistrationController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 23.02.23.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: - Properties
    private let imagePicker = UIImagePickerController()
    let plusPhotoButton = UIButton(type: .system)
    let stackView = UIStackView()
    // Text stuff
    private lazy var emailContainerView = UIView()
    private lazy var passwordContainerView = UIView()
    private lazy var fullNameContainerView = UIView()
    private lazy var userNameContainerView = UIView()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    private var fullNameTextField = UITextField()
    private var userNameTextField = UITextField()
    // Buttons
    private let signUpButton = UIButton(type: .system)
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", "  Login")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        style()
        layout()
    }
}

// MARK: - Style

extension RegistrationController {
    
    func style() {
        view.backgroundColor = .twitterBlue
        
        // imagePicker
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        // plusPhotoButton
        plusPhotoButton.setImage(UIImage(named: "plus_photo"), for: .normal)
        plusPhotoButton.tintColor = .white
        plusPhotoButton.layer.cornerRadius = 128/2
        plusPhotoButton.layer.masksToBounds = true  // choosen image is circle too
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        
        // email textField
        emailTextField = Utilities().textField(withPlaceholder: "Email")
        
        // password TextField
        passwordTextField = Utilities().textField(withPlaceholder: "Password")
        passwordTextField.isSecureTextEntry = true
        
        // fullNameTextField
        fullNameTextField = Utilities().textField(withPlaceholder: "Full Name")
        
        // userNameTextField
        userNameTextField = Utilities().textField(withPlaceholder: "Username")
        
        
        // StackView
        stackView.axis = .vertical
        stackView.spacing = 17
        
        // email
        let emailImage = UIImage(named: "ic_mail_outline_white_2x-1")!
        emailContainerView = Utilities().inputContainerView(withImage: emailImage, textField: emailTextField)
        
        // password View
        let passwordImage = UIImage(named: "ic_lock_outline_white_2x")!
        passwordContainerView = Utilities().inputContainerView(withImage: passwordImage, textField: passwordTextField)
        
        // password View
        let fullNameImage = UIImage(named: "ic_person_outline_white_2x")!
        fullNameContainerView = Utilities().inputContainerView(withImage: fullNameImage, textField: fullNameTextField)
        
        // password View
        let userNameImage = UIImage(named: "ic_person_outline_white_2x")!
        userNameContainerView = Utilities().inputContainerView(withImage: userNameImage, textField: userNameTextField)
        
        // signUp Button
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.twitterBlue, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 5
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        
    }
    
    // MARK: - Layout
    
    func layout() {
        
        view.addSubview(plusPhotoButton)
        stackView.addArrangedSubview(emailContainerView)
        stackView.addArrangedSubview(passwordContainerView)
        stackView.addArrangedSubview(fullNameContainerView)
        stackView.addArrangedSubview(userNameContainerView)
        stackView.addArrangedSubview(signUpButton)
        view.addSubview(stackView)
        view.addSubview(alreadyHaveAccountButton)
        
        
        // plusPhotoButton
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        // StackView
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        // loginButton
        signUpButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        // dontHaveAccountButton
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
}

// MARK: - delegate Extrension
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // it needs to know which image we want. In this case it's edited image
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
    }
}


// MARK: - Actions

extension RegistrationController {
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true)
    }
    
    @objc func handleRegistration() {
        print("handle SignUp here")
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
}


