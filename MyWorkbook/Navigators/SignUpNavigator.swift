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
//        viewController?.performSegue(withIdentifier: R.segue.signUpViewController.toLogin, sender: nil)
    }
    
    func toList() {
        let homeVC = HomeViewController(nib: R.nib.homeViewController)
        viewController?.present(homeVC, animated: true, completion: nil)
    }
}
