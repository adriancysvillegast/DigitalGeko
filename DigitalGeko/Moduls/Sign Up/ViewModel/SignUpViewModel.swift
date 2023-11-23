//
//  SignUpViewModel.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 22/11/23.
//

import Foundation

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
    func activeButton()
    func inactiveButton()
    func showNameLabel(show: Bool)
    func showEmailLabel(show: Bool)
    func showPasswordLabel(show: Bool)
    func showContactNumberLabel(show: Bool)
    func didSuccessSignUp()
    func didErrorSignUp()
    
    func startLoadView()
    func stopLoadView()
}

class SignUpViewModel {
    
    // MARK: - Properties
    
    var emailValidate: Bool = false
    var nameValidate: Bool = false
    var passwordValidate: Bool = false
    var numberValidate: Bool = false
    var activateButton: Bool = false
    
    weak var delegate: SignUpViewModelDelegate?
    
    var validationManager: ValidationManager
    
    // MARK: - Init
    
    init(manager: ValidationManager = ValidationManager()) {
        self.validationManager = manager
    }
    
    
    // MARK: - Methods
    
    func nameValidate(nameUser: String?) {
        guard let name = nameUser else {
            nameValidate = false
            self.delegate?.showNameLabel(show: nameValidate)
            return
        }
        if validationManager.validateName(nameUser: name) {
            nameValidate = true
            self.delegate?.showNameLabel(show: nameValidate)
        }else {
            nameValidate = false
            self.delegate?.showNameLabel(show: nameValidate)
        }
        
        buttonActivation()
    }
    
    func emailValidate(emailUser: String?) {
        guard let email = emailUser else {
            emailValidate = false
            self.delegate?.showEmailLabel(show: emailValidate)
            return
        }
        
        if !validationManager.validateEmail(emailUser: email)  {
            emailValidate = false
            self.delegate?.showEmailLabel(show: emailValidate)
        }else {
            emailValidate = true
            self.delegate?.showEmailLabel(show: emailValidate)
        }
        buttonActivation()
    }
    
    func passwordValidate(password: String?) {
        guard let value = password else {
            passwordValidate = false
            self.delegate?.showPasswordLabel(show: passwordValidate)
            return
        }
        if validationManager.validatePassword(passwordUser: value){
            passwordValidate = true
            self.delegate?.showPasswordLabel(show: passwordValidate)
        } else {
            passwordValidate = false
            self.delegate?.showPasswordLabel(show: passwordValidate)
        }
        buttonActivation()
    }
    
    func contactNumberValidate(number: String?) {
        guard let value = number else {
            numberValidate = false
            self.delegate?.showContactNumberLabel(show: numberValidate)
            return
        }
        
        if validationManager.validateNumber(numberUser: value) {
            numberValidate = true
            self.delegate?.showContactNumberLabel(show: numberValidate)
        }else {
            numberValidate = false
            self.delegate?.showContactNumberLabel(show: numberValidate)
        }
        buttonActivation()
    }
    
    
    func buttonActivation() {
        if nameValidate && emailValidate &&
            passwordValidate && numberValidate {
            self.delegate?.activeButton()
        }else {
            self.delegate?.inactiveButton()
        }
    }
    
    func signUp(email: String?,
                password: String?,
                userName: String?,
                phoneNumber: String?
    ) {
        guard let email = email,
              let password = password,
              let userName = userName,
              let number = phoneNumber else {
            return
        }
        AuthManager.shared.createNewUser(email: email, password: password, userName: userName, phoneNumber: number) { success in
            if success {
                self.delegate?.didSuccessSignUp()
            }else {
                self.delegate?.didErrorSignUp()
            }
        }
    }
    
    
}
