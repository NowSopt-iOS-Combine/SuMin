//
//  LoginViewController.swift
//  Combine_Practice
//
//  Created by 이수민 on 5/10/24.
//

import UIKit

import Combine

final class CarrotLoginViewController: UIViewController {
    
    private let rootView = LoginView()
    
    private let loginViewModel : LoginViewModel
    private var mySubscriptions = Set<AnyCancellable>()
    
    init(viewModel: LoginViewModel) {
        self.loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
        rootView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        passwordConfirm()
    }
    
    private func passwordConfirm() {
        let input = LoginViewModel.Input(
            idTextField: rootView.idTextField.textPublisher,
            passwordTextField: rootView.passwordTextField.textPublisher,
            passwordConfirmTextField: rootView.passwordConfirmTextField.textPublisher
        )
        
        let output = loginViewModel.confirmPassword(from: input)
        
        output.isValidPassword
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: rootView.loginButton)
            .store(in: &mySubscriptions)
    }
    
    @objc
    func loginButtonTapped() {
        let welcomeViewController = WelcomeViewController()
        self.navigationController?.pushViewController(welcomeViewController, animated: true)
    }
    
    
    /*
    private func dataBind() {
        let input = LoginViewModel.Input(
            idTextField: rootView.idTextField.textPublisher,
            passwordTextField: rootView.passwordTextField.textPublisher,
            passwordConfirmTextField: rootView.passwordConfirmTextField.textPublisher
        )
        
        let output = loginViewModel.sendLoginInfo(from: input)
        
        output.loginInfo
            .receive(on: RunLoop.main)
         
    }
     */
     
    
}

extension UIButton{
    var isValid: Bool{
        get{
            backgroundColor == .yellow
        }
        set{
            backgroundColor = newValue ? .yellow : .lightGray
            isEnabled = newValue
            setTitleColor(newValue ? .blue : .white, for: .normal)
        }
    }
    
}
