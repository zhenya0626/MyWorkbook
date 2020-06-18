//
//  HomeViewModel.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/09.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelType {

    let subjectArray = ["数学Ⅰ", "数学Ⅱ", "物理", "化学演習", "英語"]
    let workbookArray = ["〇〇問題集", "数学ⅠA問題集", "〇〇式", "化学演習", "物理演習", "数学B問題集"]
    let tagArray = ["2年前期 定期テスト", "苦手問題", "テストに出る！", "重要", "重要", "重要"]
    let questionArray = ["微分", "積分", "確率", "単振動", "有機化学", "文法"]
    
    struct Input {
        let postTrigger: Driver<Void>
        let content: Driver<String>
    }
    
    struct Output {
        let post: Driver<Void>
        let defaultPost: Driver<Subject?>
        let error: Driver<Error>
    }
    
    struct State {
        let error = ErrorTracker()
    }
    
    private let selectedPost: Subject?
    private let postModel: SubjectModel
    private let navigator: HomeNavigator
    
    init(with postModel: SubjectModel, and navigator: HomeNavigator, and selectedPost: Subject? = nil) {
        self.postModel = postModel
        self.navigator = navigator
        self.selectedPost = selectedPost
    }
    
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output {
        let state = State()
        let post = input.postTrigger
            .withLatestFrom(input.content)
            .flatMapLatest { [unowned self] content -> Driver<Void> in
                if let sP = self.selectedPost {
                    return self.postModel.update(
                        Subject(id: sP.id,
                                   user: sP.user,
                                   content: content,
                                   date: Date()))
                        .do(onNext: { [unowned self] _ in
                            self.navigator.toList()
                        })
                        .trackError(state.error)
                        .asDriver(onErrorJustReturn: ())
                } else {
                    return self.postModel.create(with: content)
                        .do(onNext: { [unowned self] _ in
                            self.navigator.toList()
                        })
                        .trackError(state.error)
                        .asDriver(onErrorJustReturn: ())
                }
        }

        return HomeViewModel.Output(
            post: post,
            defaultPost: Driver.just(selectedPost),
            error: state.error.asDriver()
        )
    }
}

