//
//  MyViewModel.swift
//  Combine_Practice
//
//  Created by 이수민 on 5/3/24.
//

import Foundation
import Combine

class MyViewModel{
    
    @Published var passwordInput : String = ""
    @Published var passwordConfirmInput : String = ""
    
    // @Published = 게시자 -> 값 변경 시 새 값 전송/게시
    
    
    lazy var isMatchPasswordInput : AnyPublisher<Bool, Never> = Publishers
        .CombineLatest($passwordInput, $passwordConfirmInput)
        //publisher들의 최신값 - publisher이니 $ 붙여서 가져옴
        .map({(password: String, passwordConfirm : String) in
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
    
    //들어온 Publisher 2개의 값 일치 여부 리턴하는 Publisher (Bool)
}
