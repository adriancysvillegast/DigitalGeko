//
//  SignUpViewController.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 21/11/23.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewModel: SignUpViewModel = {
        let viewModel = SignUpViewModel()
        viewModel.delegate = self 
        return viewModel
    }()
    
    private lazy var emailTextField: UITextField = {
       let view = UITextField()
        view.textContentType = .emailAddress
        view.placeholder = "Email".uppercased()
        view.borderStyle = .roundedRect
        view.tintColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(emailValidate), for: .editingChanged)
        view.delegate = self
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Please type an email address. example@digitalgeko.com"
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor.gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
       let view = UITextField()
        view.textContentType = .name
        view.placeholder = "Name".uppercased()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(nameValidate), for: .editingChanged)
        view.delegate = self
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "The name must have more than 1 character. Example: Juan"
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor.gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
       let view = UITextField()
        view.isSecureTextEntry = true
        view.textContentType = .newPassword
        view.autocorrectionType = .no
        view.placeholder = "Password".uppercased()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(passwordValidate), for: .editingChanged)
        view.delegate = self
        return view
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Add at least an uppercase, lowercase, digits and special characters."
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor.gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contactNumberTextField: UITextField = {
       let view = UITextField()
        view.textContentType = .telephoneNumber
        view.placeholder = "Contact Number".uppercased()
        view.borderStyle = .roundedRect
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(contactValidate), for: .editingChanged)
        view.delegate = self
        return view
    }()
    
    private lazy var contactNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "add just 10-digit phone numbers"
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor.gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonSignUp: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account".uppercased(), for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private var spinnerLoading: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.color = .systemRed
        spinner.isHidden = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    // MARK: - SetUpView

    private func setUpView() {
        
        [nameTextField, emailTextField ,passwordTextField, contactNumberTextField,
         emailLabel, nameLabel, passwordLabel, contactNumberLabel, buttonSignUp, spinnerLoading
        ].forEach { view.addSubview($0) }
        
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            nameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 280),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),

            emailLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.widthAnchor.constraint(equalToConstant: 280),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),

            passwordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordLabel.widthAnchor.constraint(equalToConstant: 280),

            contactNumberTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            contactNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contactNumberTextField.widthAnchor.constraint(equalToConstant: 300),

            contactNumberLabel.topAnchor.constraint(equalTo: contactNumberTextField.bottomAnchor, constant: 5),
            contactNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contactNumberLabel.widthAnchor.constraint(equalToConstant: 280),

            buttonSignUp.topAnchor.constraint(equalTo: contactNumberTextField.bottomAnchor, constant: 50),
            buttonSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonSignUp.widthAnchor.constraint(equalToConstant: 180),
            
            spinnerLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
    }
    
    
   // MARK: - Methods
    
    @objc func nameValidate() {
        viewModel.nameValidate(nameUser: nameTextField.text)
    }

    @objc func emailValidate() {
        viewModel.emailValidate(emailUser: emailTextField.text)
    }
    
    @objc func passwordValidate() {
        viewModel.passwordValidate(password: passwordTextField.text)
    }
    
    @objc func contactValidate() {
        viewModel.contactNumberValidate(number: contactNumberTextField.text)
    }
    
    @objc func buttonTapped() {
        viewModel.signUp(email: emailTextField.text,
                            password: passwordTextField.text,
                            userName: nameTextField.text,
                            phoneNumber: contactNumberTextField.text)
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
}

// MARK: - SignUpViewModelDelegate
extension SignUpViewController: SignUpViewModelDelegate {
    
    func startLoadView() {
        DispatchQueue.main.async {
            self.spinnerLoading.isHidden = false
            self.spinnerLoading.startAnimating()
        }
    }
    
    func stopLoadView() {
        DispatchQueue.main.async {
            self.spinnerLoading.isHidden = true
            self.spinnerLoading.stopAnimating()
        }
    }
    
    func didSuccessSignUp() {
        let vc = LoginWelcomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func didErrorSignUp() {
        let alert = UIAlertController(title: "Sign Up Error", message: "We got an error trying to Sign up", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
            self.nameTextField.text = ""
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
            self.contactNumberTextField.text = ""
        }))
        present(alert, animated: true)
    }
    
    func showPasswordLabel(show: Bool) {
        self.passwordLabel.isHidden = show
        
    }
    
    func showContactNumberLabel(show: Bool) {
        self.contactNumberLabel.isHidden = show
    }
    
    
    func showNameLabel(show: Bool) {
        self.nameLabel.isHidden = show
    }
    
    func showEmailLabel(show: Bool) {
        self.emailLabel.isHidden = show
    }
    
    func activeButton() {
        DispatchQueue.main.async {
            self.buttonSignUp.backgroundColor = .green
            self.buttonSignUp.isEnabled = true
        }
    }
    
    func inactiveButton() {
        DispatchQueue.main.async {
            self.buttonSignUp.backgroundColor = .gray
            self.buttonSignUp.isEnabled = false
        }
    }
    
    
}
