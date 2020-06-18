//
//  ArrayTracker.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/18.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation


import Foundation
import RxSwift
import RxCocoa

final class ArrayTracker<T>: SharedSequenceConvertibleType {
    typealias SharingStrategy = DriverSharingStrategy
    private let _array = Variable<[T]>([])
    
    var array: [T] {
        return _array.value
    }
    
    func trackArray<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> where O.Element == [T] {
        return source.asObservable().do(onNext: onNext)
    }
    
    func asSharedSequence() -> SharedSequence<SharingStrategy, [T]> {
        return _array.asObservable().asDriver(onErrorJustReturn: [])
    }
    
    func asObservable() -> Observable<[T]> {
        return _array.asObservable()
    }
    
    private func onNext(_ array: [T]) {
        _array.value = array
    }
    
    deinit {
        _array.value = []
    }
}

extension ObservableConvertibleType {
    func trackArray<T>(_ arrayTracker: ArrayTracker<T>) -> Observable<Element> where Element == [T] {
        return arrayTracker.trackArray(from: self)
    }
}

