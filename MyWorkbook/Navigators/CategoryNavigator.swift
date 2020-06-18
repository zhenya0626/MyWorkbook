//
//  CategoryNavigator.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/18.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

class CategoryNavigator {
    private weak var viewController: CategoryViewController?
    
    init(with viewController: CategoryViewController) {
        self.viewController = viewController
    }
    
    func toList() {
//        viewController?.dismiss(animated: true)
    }
}
