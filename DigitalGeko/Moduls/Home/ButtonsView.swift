//
//  ButtonsView.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 21/11/23.
//

import UIKit

// MARK: - OptionsToggleDelegate
protocol OptionsToggleDelegate: AnyObject {
    func didTapLogIn(_ opToggleView: ButtonsView)
    func didTapSignUp(_ opToggleView: ButtonsView)
}

class ButtonsView: UIView {

    // MARK: - Properties
    
    enum ButtonOptions {
        case logIn
        case signUp
    }

    weak var delegate: OptionsToggleDelegate?
    
    private var optionTapped: ButtonOptions = .logIn
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("LogIn".uppercased(), for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 6
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignUp".uppercased(), for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var indicatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .blue
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [logInButton, signUpButton, indicatorView].forEach { addSubview($0)
        }
        
        logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUpView
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        logInButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        signUpButton.frame = CGRect(x: logInButton.frame.width, y: 0, width: 100, height: 40)
        
        lightButtonTapped()
    }
    
    private func lightButtonTapped() {
        switch optionTapped {
        case .logIn:
            indicatorView.frame = CGRect(x: 0,
                                         y: logInButton.frame.height,
                                         width: 100,
                                         height: 3)
        case .signUp:
            indicatorView.frame = CGRect(x: logInButton.frame.width,
                                         y: logInButton.frame.height,
                                         width: 100,
                                         height: 3)
        }
    }
    
    
    // MARK: - Targets
    
    @objc func didTapSignUp() {
        optionTapped = .signUp
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            self.lightButtonTapped()
            self.logInButton.backgroundColor = nil
            self.signUpButton.backgroundColor = .green
        }
        delegate?.didTapSignUp(self)
    }
    
    @objc func didTapLogIn() {
        optionTapped = .logIn
        UIView.animate(withDuration: 0.2, delay: 0.1) {
            self.lightButtonTapped()
            self.signUpButton.backgroundColor = nil
            self.logInButton.backgroundColor = .green
        }
        delegate?.didTapLogIn(self)
    }
    
    // MARK: - Update Button
    
    func didTapButton(option: ButtonOptions) {
        self.optionTapped = option
        UIView.animate(withDuration: 0.2) {
            self.lightButtonTapped()
            self.updateButton()
        }
    }
    
    func updateButton() {
        if optionTapped == .logIn {
            self.signUpButton.backgroundColor = nil
            self.logInButton.backgroundColor = .green
        }else {
            self.signUpButton.backgroundColor = .green
            self.logInButton.backgroundColor = nil
        }
    }
    
}
