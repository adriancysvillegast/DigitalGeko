//
//  LogInViewController.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 21/11/23.
//

import UIKit

class LogInViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewModel: LogInViewModel = {
        let viewModel = LogInViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private lazy var emailTextField: UITextField = {
       let view = UITextField()
        view.textContentType = .emailAddress
        view.placeholder = "Email".uppercased()
        view.borderStyle = .roundedRect
        view.tintColor = .red
        view.text = "Nancy@gmail.com"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(emailValidate), for: .editingChanged)
        view.delegate = self
        return view
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Please type your email address. example@digitalgeko.com"
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
        label.text = "Complete your Password"
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.textColor = UIColor.gray
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private lazy var buttonSignUp: UIButton = {
        let button = UIButton()
        button.setTitle("sign in".uppercased(), for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
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
        
        [emailTextField ,passwordTextField,
         emailLabel, passwordLabel, buttonSignUp, spinnerLoading
        ].forEach { view.addSubview($0) }
        
        
        NSLayoutConstraint.activate([

            emailTextField.topAnchor.constraint(equalTo: view.topAnchor , constant: 40),
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

            buttonSignUp.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            buttonSignUp.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonSignUp.widthAnchor.constraint(equalToConstant: 180),
            
            spinnerLoading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerLoading.centerYAnchor.constraint(equalTo: view.centerYAnchor)

        ])
    }
    
    
   // MARK: - Methods
    
    @objc func emailValidate() {
        viewModel.validateEmail(emailUser: emailTextField.text)
    }
    
    @objc func passwordValidate() {
        viewModel.validatePassword(password: passwordTextField.text)
    }
    
    @objc func logInTapped() {
        viewModel.logIn(email: emailTextField.text, password: passwordTextField.text)
    }

}
// MARK: - UITextFieldDelegate
extension LogInViewController: UITextFieldDelegate {
    
}

// MARK: - LogInViewModelDelegate
extension LogInViewController: LogInViewModelDelegate {
    func goToWelcome() {
        let vc = LoginWelcomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func startLoadView() {
        DispatchQueue.main.async {
            [self.emailTextField ,self.passwordTextField,
             self.emailLabel, self.passwordLabel, self.buttonSignUp].forEach { $0.isHidden = true }
            
            self.spinnerLoading.isHidden = false
            self.spinnerLoading.startAnimating()
            
        }
    }
    
    func stopLoadView() {
        DispatchQueue.main.async {
            [self.emailTextField ,self.passwordTextField,
             self.emailLabel, self.passwordLabel, self.buttonSignUp].forEach { $0.isHidden = false }
            
            self.spinnerLoading.isHidden = true
            self.spinnerLoading.stopAnimating()
        }
    }
    
    
    func showEmailLabel(show: Bool) {
        emailLabel.isHidden = show
    }
    
    func showPasswordLabel(show: Bool) {
        passwordLabel.isHidden = show
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
    
    func showAlertError() {
        let alert = UIAlertController(title: "Log In Error", message: "We got an error trying to Log In", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in

            self.emailTextField.text = ""
            self.passwordTextField.text = ""
        }))
        present(alert, animated: true)
    }
    
}
