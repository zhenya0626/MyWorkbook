//
//  SubjectNavigator.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/20.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

class SubjectNavigator {
    private weak var viewController: SubjectViewController?
    
    init(with viewController: SubjectViewController) {
        self.viewController = viewController
    }
    
    func toList() {
//        viewController?.dismiss(animated: true)
    }
}


