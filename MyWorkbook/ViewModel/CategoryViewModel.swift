//
//  CategoryViewModel.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/06/18.
//  Copyright © 2020 zhenya. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoryViewModel: ViewModelType {

    let subjectArray = ["数学Ⅰ", "数学Ⅱ", "物理", "化学演習", "英語"]
    let workbookArray = ["〇〇問題集", "数学ⅠA問題集", "〇〇式", "化学演習", "物理演習", "数学B問題集"]
    let tagArray = ["2年前期 定期テスト", "苦手問題", "テストに出る！", "重要", "重要", "重要"]
    let questionArray = ["微分", "積分", "確率", "単振動", "有機化学", "文法"]
    
    struct Input {
      let trigger: Driver<Void>
      let postTrigger: Driver<Void>
      let selectTrigger: Driver<Int>
      let deleteTrigger: Driver<Int>
    }

    struct Output {
      let load: Driver<Void>
      let posts: Driver<[Subject]>
      let select: Driver<Void>
      let delete: Driver<Void>
      let toPost: Driver<Void>
      let isLoading: Driver<Bool>
      let error: Driver<Error>
    }

    struct State {
      let contentArray = ArrayTracker<Subject>()
      let isLoading = ActivityIndicator()
      let error = ErrorTracker()
    }

    private let subjectModel: SubjectModel
    private let navigator: CategoryNavigator

    init(with postModel: SubjectModel, and navigator: CategoryNavigator) {
      self.subjectModel = postModel
      self.navigator = navigator
    }

    func transform(input: CategoryViewModel.Input) -> CategoryViewModel.Output {
      let state = State()
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
                                                date: item["date"] as! Date)
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
      let select = input.selectTrigger
          .withLatestFrom(state.contentArray) { [unowned self] (index: Int, posts: [Subject]) in
//              self.navigator.toList()(with: posts[index])
            self.navigator.toList()
      }
      let delete = input.deleteTrigger
          .flatMapLatest { [unowned self] index in
              return self.subjectModel.delete(state.contentArray.array[index].id)
                  .asDriver(onErrorJustReturn: ())
      }
      let toPost = input.postTrigger
          .do(onNext: { [unowned self] _ in
            let test:Observable<Void> = self.subjectModel.create(with: "数学")
            print(test)
              self.navigator.toList()
          })
      return CategoryViewModel.Output(load: load,
                                  posts: state.contentArray.asDriver(),
                                  select: select,
                                  delete: delete,
                                  toPost: toPost,
                                  isLoading: state.isLoading.asDriver(),
                                  error: state.error.asDriver())
    }
}


