//
//  LoginViewModel.swift
//  Combine_Practice
//
//  Created by 이수민 on 5/10/24.
//

import Foundation
import Combine
import CombineCocoa

class LoginViewModel {
    
    struct Input {
        let idTextField: AnyPublisher<String?, Never>
        let passwordTextField: AnyPublisher<String?, Never>
        let passwordConfirmTextField: AnyPublisher<String?, Never>
    }
  
    struct ConfirmPasswordOutput {
        let isValidPassword: AnyPublisher<Bool, Never>
    }
    
    func confirmPassword(from input: Input) -> ConfirmPasswordOutput {
        let passwordPublisher = input.passwordTextField
        let passwordConfirmPublisher = input.passwordConfirmTextField
        
        let confirmPasswordPublisher : AnyPublisher<Bool, Never> = Publishers
            .CombineLatest(passwordPublisher, passwordConfirmPublisher)
            .map({(password: String?, passwordConfirm : String?) in
                if password == "" || passwordConfirm == ""{
                    return false
                }
                if password == passwordConfirm{
                    return true
                }
                else{
                    return false
                }
            })
            .eraseToAnyPublisher()

        return ConfirmPasswordOutput(isValidPassword : confirmPasswordPublisher)
    }
    
    struct LoginInfoOutput {
        let loginInfo: AnyPublisher<LoginInfo, Never>
    }
    
    func sendLoginInfo(from input: Input) -> LoginInfoOutput {
        let idPublisher = input.idTextField
        let passwordPublisher = input.passwordTextField
        
        let loginInfoPublisher: AnyPublisher<LoginInfo, Never> = Publishers
            .CombineLatest(idPublisher, passwordPublisher)
            .map { id, password in
                if let id = id, let password = password {
                    return LoginInfo(id: id, password: password)
                } else {
                    return LoginInfo(id: "no id", password: "no pw")
                }
            }
            .eraseToAnyPublisher()

        return LoginInfoOutput(loginInfo: loginInfoPublisher)
    }
}
