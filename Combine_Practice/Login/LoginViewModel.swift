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
  
    struct Output {
        let isValidPassword: AnyPublisher<Bool, Never>
    }
    
    func confirmPassword(from input: Input) -> Output {
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

        return Output(isValidPassword: confirmPasswordPublisher)
    }
}
