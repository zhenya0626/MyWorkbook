//
//  ViewModelType.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/11.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    associatedtype State
    
    func transform(input: Input) -> Output
}
