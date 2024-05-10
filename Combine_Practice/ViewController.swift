//
//  ViewController.swift
//  Combine_Practice
//
//  Created by 이수민 on 5/3/24.
//

import UIKit
import SnapKit
import Combine

class ViewController: UIViewController {

    var viewModel : MyViewModel!
    private var mySubscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        setLayout()
        
        viewModel = MyViewModel()
        //텍스트필드의 이벤트 -> 뷰모델의 프로퍼티가 구독
        passwordTextField.myTextPublisher
            .receive(on: RunLoop.main) // + DispatchQueue.main: 메인 스레드에서
            .assign(to: \.passwordInput, on: viewModel) //viewModel의 passwordInput이 구독, 이벤트 전달받음
            .store(in: &mySubscriptions)
        
        passwordConfirmTextField.myTextPublisher
            .receive(on: RunLoop.main) //메인 스레드에서
            .assign(to: \.passwordConfirmInput, on: viewModel) //viewModel의 passwordInput이 구독, 이벤트 전달받음
            .store(in: &mySubscriptions)
        
        //뷰모델의 퍼블리셔 -> 뷰컨의 버튼이 구독
        viewModel.isMatchPasswordInput
            .receive(on : RunLoop.main)
            .assign(to: \.isValid, on: loginButton)
            .store(in: &mySubscriptions)
    }
    
    func setLayout(){
        [passwordTextField, passwordConfirmTextField, loginButton].forEach{
            view.addSubview($0)
        }
        passwordTextField.snp.makeConstraints{
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
        passwordConfirmTextField.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
        loginButton.snp.makeConstraints{
            $0.top.equalTo(passwordConfirmTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
        }
    }

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = .systemMint
        
        return textField
    }()

    private let passwordConfirmTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        textField.backgroundColor = .systemMint
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("로그인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        //button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
}

extension UITextField{
    //NotificationCenter -> UITextField (UITextField extension이니까..) 속성 변경 시 알림
    //여기서는 for: textDidChangeNotification 선택 -> text 변경 시 알림
    var myTextPublisher : AnyPublisher<String, Never>{
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
           .compactMap { notification in
               return (notification.object as? UITextField)?.text //UITextField text 가져오기
           }
           .eraseToAnyPublisher() //text 둘러싼 거 unwrap - AnyPublisher로 변경
    } //myTextPublisher : 자료형이 AnyPublisher인 클로저
}

/*
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
*/
