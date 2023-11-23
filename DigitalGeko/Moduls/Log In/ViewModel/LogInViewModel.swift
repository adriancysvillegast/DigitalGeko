//
//  LogInViewModel.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 22/11/23.
//

import Foundation


protocol LogInViewModelDelegate: AnyObject {
    func activeButton()
    func inactiveButton()
    func showEmailLabel(show: Bool)
    func showPasswordLabel(show: Bool)
    func startLoadView()
    func stopLoadView()
    func goToWelcome()
    func showAlertError()
}

class LogInViewModel {
    // MARK: - Properties
    var emailValidate: Bool = false
    var passwordValidate: Bool = false
    
    var validateManager: ValidationManager
    weak var delegate: LogInViewModelDelegate?
    
    init(validateManager: ValidationManager = ValidationManager() ) {
        self.validateManager = validateManager
    }
    
    
    // MARK: - Methods
    
    func validateEmail(emailUser: String?) {
        //Just for show a label -> Please type your email address. example@digitalgeko.com
        guard let email = emailUser else {
            emailValidate = false
            self.delegate?.showEmailLabel(show: emailValidate)
            return
        }
        
        if validateManager.validateEmail(emailUser: email) {
            emailValidate = true
            self.delegate?.showEmailLabel(show: emailValidate)
        }else {
            emailValidate = false
            self.delegate?.showEmailLabel(show: emailValidate)
        }
        
        buttonActivation()
    }
    
    func validatePassword(password: String?) {
        //Just for show a label -> Complete your Password
        guard let value = password else {
            passwordValidate = false
            self.delegate?.showPasswordLabel(show: passwordValidate)
            return
        }
        
        if value.count>1
//            validateManager.validatePassword(passwordUser: value)
        {
            passwordValidate = true
            self.delegate?.showPasswordLabel(show: passwordValidate)
        }else {
            passwordValidate = false
            self.delegate?.showPasswordLabel(show: passwordValidate)
        }
        buttonActivation()
    }
    
    func buttonActivation() {
        if emailValidate && passwordValidate {
            self.delegate?.activeButton()
        }else {
            self.delegate?.inactiveButton()
        }
    }
    
    func logIn(email: String?, password: String?) {
        self.delegate?.startLoadView()
        guard let email = email, let password = password else { return }
        
        AuthManager.shared.logIn(email: email, password: password) { success in
            if success {
//                show vc
                self.delegate?.stopLoadView()
                self.delegate?.goToWelcome()
            }else {
//                showError
                self.delegate?.stopLoadView()
                self.delegate?.showAlertError()
            }
        }
                
    }
    
}
