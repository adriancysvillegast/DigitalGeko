//
//  LoginWelcomeViewModel.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 23/11/23.
//

import Foundation

protocol LoginWelcomeViewModelDelegate: AnyObject {
    func updateView(name: String, email: String, number: String)
    func goBack()
    func showAlertError()
}

class LoginWelcomeViewModel {
    
    
    // MARK: - Properties
    weak var delegate: LoginWelcomeViewModelDelegate?
    
    // MARK: - Methods
    
    func getInfo() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        
        var nameUser: String?
        var numberUser: String?
        var emailUser: String?
        
        
        AuthManager.shared.getUserName { name in
            defer {
                group.leave()
            }
            
            if let name = name {
                nameUser = name
            }
        }
        
        
        AuthManager.shared.getUserNumber { number in
            defer {
                group.leave()
            }
            if let number = number {
                numberUser = number
            }
        }
        
        
        AuthManager.shared.getEmail { email in
            defer {
                group.leave()
            }
            
            if let email = email {
                emailUser = email
            }
        }
        
        group.notify(queue: .main) {
            
            guard let name = nameUser, let email = emailUser, let number = numberUser else { return }
            self.delegate?.updateView(name: name, email: email, number: number)
        }
    }
    
    
    
    func logOut() {
        if AuthManager.shared.logOut() {
            self.delegate?.goBack()
        }else{
//            showAler
            self.delegate?.showAlertError()
        }
    }
}
