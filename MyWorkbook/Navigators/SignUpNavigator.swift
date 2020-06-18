//
//  SignUpNavigator.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/11.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

class SignUpNavigator {
    private weak var viewController: SignUpViewController?
    
    init(with viewController: SignUpViewController) {
        self.viewController = viewController
    }
    
    func toLogin() {
        let loginVC = LoginViewController(nib: R.nib.loginViewController)
        viewController?.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func toHome() {
        let homeVC = HomeViewController(nib: R.nib.homeViewController)
        // 戻るボタンを表示しない
        homeVC.navigationItem.hidesBackButton = true
        viewController?.navigationController?.pushViewController(homeVC, animated: true)
    }
}
