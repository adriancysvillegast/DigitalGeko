//
//  LoginWelcomeViewController.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 22/11/23.
//

import UIKit

class LoginWelcomeViewController: UIViewController, LoginWelcomeViewModelDelegate {


    

    // MARK: - Properties
    
    private lazy var viewModel: LoginWelcomeViewModel = {
        let viewModel = LoginWelcomeViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private lazy var nameUser: UILabel = {
        let label = UILabel()
        label.text = "add just 10-digit phone numbers"
        label.numberOfLines = 2
//        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.black
//        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailUser: UILabel = {
        let label = UILabel()
        label.text = "add just 10-digit phone numbers"
        label.numberOfLines = 2
//        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.black
//        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contactNumber: UILabel = {
        let label = UILabel()
//        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor.black
//        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonLogOut: UIButton = {
        let button = UIButton()
        button.setTitle("sign out".uppercased(), for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 12
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = .systemBackground
        setUpView()
        getInfo()
    }
    
    private func setUpView() {
        [nameUser, emailUser, contactNumber, buttonLogOut].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            nameUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameUser.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            nameUser.widthAnchor.constraint(equalToConstant: 300),
            
            emailUser.topAnchor.constraint(equalTo: nameUser.bottomAnchor, constant: 20),
            emailUser.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            emailUser.widthAnchor.constraint(equalToConstant: 300),
            
            contactNumber.topAnchor.constraint(equalTo: emailUser.bottomAnchor, constant: 20),
            contactNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            contactNumber.widthAnchor.constraint(equalToConstant: 300),
            
            buttonLogOut.topAnchor.constraint(equalTo: contactNumber.bottomAnchor, constant: 50),
            buttonLogOut.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonLogOut.widthAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
    @objc func logOut() {
        viewModel.logOut()
    }
    
    func getInfo() {
        viewModel.getInfo()
    }
    
    // MARK: - LoginWelcomeViewModelDelegate
    
    func updateView(name: String, email: String, number: String) {
        DispatchQueue.main.async {
            self.nameUser.text = name
            self.emailUser.text = email
            self.contactNumber.text = number
        }
    }
    
    func goBack() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlertError() {
        let alert = UIAlertController(title: "Sign out Error", message: "We got an error trying to Sign out", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
}


