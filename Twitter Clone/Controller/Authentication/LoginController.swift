//
//  LoginController.swift
//  Twitter Clone
//
//  Created by Davit Natenadze on 23.02.23.
//


import UIKit

class LoginController: UIViewController {
    
    private let logoImageView = UIImageView()
    let stackView = UIStackView()
    
    private lazy var emailContainerView = UIView()
    private lazy var passwordContainerView = UIView()
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

// MARK: - Style & Layout

extension LoginController {
    
    func style() {
        view.backgroundColor = .twitterBlue
        
        // ----------------------------------------------------------------------
        navigationController?.navigationBar.barStyle = .black  // bar items color change to white
        // use preferredStatusBarStyle for VC s
        /*
         override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
         }
         */
        // ----------------------------------------------------------------------
        
        // LOGO Image
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.clipsToBounds = true
        logoImageView.image = UIImage(named: "TwitterLogo")
        
        // email textField
        emailTextField = Utilities().textField(withPlaceholder: "Email")
        
        
        // password TextField
        passwordTextField = Utilities().textField(withPlaceholder: "Password")
        passwordTextField.isSecureTextEntry = true
        
        // StackView
        stackView.axis = .vertical
        stackView.spacing = 7
        
        // email
        let emailImage = UIImage(named: "ic_mail_outline_white_2x-1")!
        emailContainerView = Utilities().inputContainerView(withImage: emailImage, textField: emailTextField)
        
        // password View
        let passwordImage = UIImage(named: "ic_lock_outline_white_2x")!
        passwordContainerView = Utilities().inputContainerView(withImage: passwordImage, textField: passwordTextField)
        
    }
    
    func layout() {
        view.addSubview(logoImageView)
        
        stackView.addArrangedSubview(emailContainerView)
        stackView.addArrangedSubview(passwordContainerView)
        view.addSubview(stackView)
        
        // Logo
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        // StackView
        stackView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
    }
}
