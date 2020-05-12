//
//  UIApplication+.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/11.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
