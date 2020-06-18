//
//  LoginNavigator.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/13.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

class LoginNavigator {
    private weak var viewController: LoginViewController?
    
    init(with viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    func toHome() {
        // 戻るボタンを表示しない
        let homeVC = HomeViewController(nib: R.nib.homeViewController)
        homeVC.navigationItem.hidesBackButton = true
        viewController?.navigationController?.pushViewController(homeVC, animated: true)
        
    }
}

