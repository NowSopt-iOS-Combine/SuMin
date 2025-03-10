//
//  NicknameViewController.swift
//  2nd-Assignment
//
//  Created by 이수민 on 4/13/24.
//

import UIKit

import SnapKit
import Combine
import CombineCocoa

class NicknameViewController: UIViewController, UITextFieldDelegate{
    var nicknamePublisher = PassthroughSubject<String?, Never>()
    // Publisher 선언 / PassthroughSubject : 값을 실시간으로 방송 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        nicknameTextField.delegate = self
    }


    private func setupLayout(){
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(finishButton)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            //$0.left.equalToSuperview().offset(20)
            $0.left.equalTo(nicknameTextField)
            //$0.width.equalTo(200)
            $0.height.equalTo(27)
        }
        nicknameTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(98)
            //$0.left.equalTo(titleLabel.snp.left)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(52)
        }
        finishButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(320)
            //$0.left.equalTo(titleLabel.snp.left)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(52)
        }
        
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해주세요"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Medium", size: 23)
        return label
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Pretendard-SemiBold", size: 14)!,
            .foregroundColor: UIColor(named: "gray4") ?? .systemGray
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: attributes)
        textField.backgroundColor = UIColor(named: "gray2")
        textField.clearButtonMode = .always
        textField.addLeftPadding(padding: 24.64)
        return textField
    }()
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        let isValid = text.range(of: "^[가-힣]{1,10}$", options: .regularExpression) != nil
        finishButton.isEnabled = isValid
        finishButton.backgroundColor = isValid ? UIColor(named: "BrandColor") : .white
        finishButton.layer.borderWidth = isValid ? 0 : 1
        nicknamePublisher.send(text) //텍스트가 바뀔 때마다 (textFieldDidChangeSelection) Publisher을 통해 text를 보낸다
    }
    
    lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .disabled)
        button.addTarget(self, action: #selector(finishButtonTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "gray4")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc func finishButtonTapped(){
        nicknamePublisher.send(completion: .finished)
        // 저장 버튼 누르면 전송 종료
        self.dismiss(animated: true)
    }
}


