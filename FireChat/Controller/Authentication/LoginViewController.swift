//
//  LoginViewController.swift
//  FireChat
//
//  Created by Aaron Cleveland on 3/8/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    let iconImageHeight: CGFloat = 120
    let standardPadding: CGFloat = 20
    let componentHeight: CGFloat = 50
    
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "bubble.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var emailContainerView = InputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
    private lazy var passwordContainerView = InputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
    private let emailTextField = CustomTextField(placeholder: "Email")
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemTeal
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 16
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign Up",
                                                  attributes: [.font: UIFont.boldSystemFont(ofSize: 16),
                                                               .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Functions -
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }
    
    private func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                           constant: standardPadding),
            iconImage.heightAnchor.constraint(equalToConstant: iconImageHeight),
            iconImage.widthAnchor.constraint(equalToConstant: iconImageHeight)
        ])
        
        vStack.addArrangedSubview(emailContainerView)
        vStack.addArrangedSubview(passwordContainerView)
        vStack.addArrangedSubview(loginButton)
        view.addSubview(vStack)
        NSLayoutConstraint.activate([
            emailContainerView.heightAnchor.constraint(equalToConstant: componentHeight),
            passwordContainerView.heightAnchor.constraint(equalToConstant: componentHeight),
            loginButton.heightAnchor.constraint(equalToConstant: componentHeight),

            vStack.topAnchor.constraint(equalTo: iconImage.bottomAnchor,
                                        constant: standardPadding),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                            constant: standardPadding),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                             constant: -standardPadding)
        ])
        
        view.addSubview(dontHaveAccountButton)
        NSLayoutConstraint.activate([
            dontHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                           constant: standardPadding),
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                          constant: -standardPadding),
            dontHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                            constant: -standardPadding)
        ])
        
        emailTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    // MARK: - Actions -
    @objc func handleShowSignUp() {
        let registerController = RegisterViewController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    @objc func textChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    @objc func handleLogin() {
        print("Cant")
    }

}
