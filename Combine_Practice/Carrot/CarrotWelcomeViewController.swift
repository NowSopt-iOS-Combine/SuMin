//
//  WelcomeViewController.swift
//  Combine_Practice
//
//  Created by 이수민 on 5/10/24.
//

import UIKit

import Combine

final class CarrotWelcomeViewController: UIViewController {
    
    private let rootView = WelcomeView()
    
    override func loadView() {
        self.view = rootView
    }

}
