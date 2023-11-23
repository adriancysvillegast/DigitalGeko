//
//  MainViewController.swift
//  DigitalGeko
//
//  Created by Adriancys Jesus Villegas Toro on 21/11/23.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Properties
    
    private var logInVC = LogInViewController()
    private var signUpVC = SignUpViewController()
    
    private lazy var buttonsView: ButtonsView = {
        let view = ButtonsView()
        view.delegate = self
        return view
    }()
    
    private lazy var aScrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.isPagingEnabled = false
        scroll.delegate = self
        scroll.contentSize = CGSize(width: view.frame.width*2 , height: scroll.frame.height)
        return scroll
    }()
    
    // MARK: - LifeCicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpChildVC()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        aScrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.frame.width,
            height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 55
        )
        
        buttonsView.frame = CGRect(
            x: view.center.x/2,
            y: view.safeAreaInsets.top,
            width: 200,
            height: 55
        )
    }
    
    // MARK: - SetUpView
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(aScrollView)
        view.addSubview(buttonsView)
    }

    private func setUpChildVC() {
        addChild(logInVC)
        addChild(signUpVC)
        
        [logInVC.view, signUpVC.view].forEach { aScrollView.addSubview($0) }
        
        logInVC.view.frame = CGRect(x: 0,
                                    y: 0,
                                    width: aScrollView.frame.width,
                                    height: aScrollView.frame.height)
        
        signUpVC.view.frame = CGRect(x: view.frame.width,
                                     y: 0,
                                     width: aScrollView.frame.width,
                                     height: aScrollView.frame.height)
        
        logInVC.didMove(toParent: self)
        signUpVC.didMove(toParent: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.frame.width-150) {
            buttonsView.didTapButton(option: .signUp)
        }else {
            buttonsView.didTapButton(option: .logIn)
        }
    }
    
    

}
// MARK: - OptionsToggleDelegate
extension MainViewController: OptionsToggleDelegate  {
    
    func didTapLogIn(_ opToggleView: ButtonsView) {
        aScrollView.setContentOffset(.zero, animated: true)
//        buttonsView.didTapButton(option: .logIn)
    }
    
    func didTapSignUp(_ opToggleView: ButtonsView) {
        let view = CGPoint(x: view.frame.width, y: 0)
        aScrollView.setContentOffset(view, animated: true)
//        buttonsView.didTapButton(option: .signUp)
    }
}
