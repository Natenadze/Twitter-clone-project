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
    private let loginButton = UIButton(type: .system)
    
    /*
     Private let didn't work and there was an warning message about self (in target func)
     lazy var was the solution
     https://stackoverflow.com/questions/71560311/xcode-13-3-warning-self-refers-to-the-method-object-self-which-may-be-u
     // The reason is self is not ready yet in phase 1 of object initialisation. Phase 1 is to set all stored properties, and only in phase 2, is possible access to self.
     */
    private lazy var dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", "  Sign up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
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
        stackView.spacing = 20
        
        // email
        let emailImage = UIImage(named: "ic_mail_outline_white_2x-1")!
        emailContainerView = Utilities().inputContainerView(withImage: emailImage, textField: emailTextField)
        
        // password View
        let passwordImage = UIImage(named: "ic_lock_outline_white_2x")!
        passwordContainerView = Utilities().inputContainerView(withImage: passwordImage, textField: passwordTextField)
        
        // login Button
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.twitterBlue, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.layer.cornerRadius = 5
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        
    }
    
    func layout() {
        view.addSubview(logoImageView)
        
        stackView.addArrangedSubview(emailContainerView)
        stackView.addArrangedSubview(passwordContainerView)
        stackView.addArrangedSubview(loginButton)
        view.addSubview(stackView)
        view.addSubview(dontHaveAccountButton)
        
        
        // Logo
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        // StackView
        stackView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        // loginButton
        loginButton.heightAnchor.constraint(equalToConstant: 47).isActive = true
        
        // dontHaveAccountButton
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)

    }
}

// MARK: - Actions

extension LoginController {
    
    @objc func handleLogin() {
        guard let email    = emailTextField.text    else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(email, password) { result, error in
            if let error {
                print("DEBUG: Error logging in \(error.localizedDescription)")
                return
            }
            
            // to dismiss this screen and call ConfigureUI function in MainTabController
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }

            guard let tab = window.rootViewController as? MainTabController else { return }
            
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true)
            //
        }
    }
    
    @objc func handleShowSignUp() {
        let controller  = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
