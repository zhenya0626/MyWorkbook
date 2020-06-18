//
//  HomeNavigator.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/18.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

class HomeNavigator {
    private weak var viewController: HomeViewController?
    
    init(with viewController: HomeViewController) {
        self.viewController = viewController
    }
    
    func toList() {
//        viewController?.dismiss(animated: true)
    }
}
