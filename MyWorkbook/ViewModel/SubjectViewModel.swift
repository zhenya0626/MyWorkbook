//
//  SubjectViewModel.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/20.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SubjectViewModel: ViewModelType {
    let subjectArray = ["数学Ⅰ", "数学Ⅱ", "物理", "化学演習", "英語"]
    
    struct Input {      
        let trigger: Driver<Void>
        let insertTrigger: Driver<Void>
////        let selectTrigger: Driver<Int>
//        let deleteTrigger: Driver<Int>
        let content: Driver<String>
    }
    
    struct Output {
        let load: Driver<Void>
        let insert: Driver<Void>
        let posts: Driver<[Subject]>
//        let select: Driver<Void>
//        let delete: Driver<Void>
//        let isLoading: Driver<Bool>
//        let error: Driver<Error>
    }
    
    struct State {
        let contentArray = ArrayTracker<Subject>()
        let isLoading = ActivityIndicator()
        let error = ErrorTracker()
    }
    
    private let subjectModel: SubjectModel
    private let navigator: SubjectNavigator
    
    init(with postModel: SubjectModel, and navigator: SubjectNavigator) {
        self.subjectModel = postModel
        self.navigator = navigator
    }
    
    func transform(input: SubjectViewModel.Input) -> SubjectViewModel.Output {
        let state = State()
        let insert = input.insertTrigger
            .withLatestFrom(input.content)
            .flatMapLatest { [unowned self] content -> Driver<Void> in
                return self.subjectModel.create(with: content)
                    .do(onNext: { [unowned self] _ in
                        self.navigator.toList()
                    })
                    .trackError(state.error)
                    .asDriver(onErrorJustReturn: ())
        }
        let load = input.trigger
            .flatMap { [unowned self] _ in
                return self.subjectModel.read()
                    .map { snap in
                        var posts: [Subject] = []
                        if !snap.isEmpty {
                            for item in snap.documents {
                                posts.append(Subject(id: item.documentID,
                                                     user: item["user"] as! String,
                                                     content: item["content"] as! String,
                                                     date: item["date"] as? Date ?? Date())
                                )
                            }
                        }
                        return posts
                }
                .trackArray(state.contentArray)
                .trackError(state.error)
                .trackActivity(state.isLoading)
                .mapToVoid()
                .asDriverOnErrorJustComplete()
        }
//        let select = input.selectTrigger
//            .withLatestFrom(state.contentArray) { [unowned self] (index: Int, posts: [Subject]) in
//                //              self.navigator.toList()(with: posts[index])
//                self.navigator.toList()
//        }
//        let delete = input.deleteTrigger
//            .flatMapLatest { [unowned self] index in
//                return self.subjectModel.delete(state.contentArray.array[index].id)
//                    .asDriver(onErrorJustReturn: ())
//        }
        return SubjectViewModel.Output(
            load: load,
                                       insert: insert,
                                       posts: state.contentArray.asDriver()
//                                       select: select,
//                                       delete: delete,
//                                       isLoading: state.isLoading.asDriver()
)
    }
}


