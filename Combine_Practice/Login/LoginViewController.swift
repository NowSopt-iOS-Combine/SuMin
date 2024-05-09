//
//  LoginViewController.swift
//  Combine_Practice
//
//  Created by 이수민 on 5/10/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let rootView = LoginView()

    override func loadView() {
        self.view = rootView
    }
}
