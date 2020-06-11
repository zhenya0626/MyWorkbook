//
//  Exception.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/11.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

enum Exception: Error {
    case network
    case auth
    case server
    case generic(message: String)
    case unknown
}
