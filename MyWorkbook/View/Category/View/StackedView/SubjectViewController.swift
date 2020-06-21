//
//  SubjectViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/23.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    var sectionTitle = ""
    
    var tmpData = ["ああああ","いいいいいい"]
    
    @IBOutlet weak var addButton: UIButton!
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textField: UITextField!
    
    var subjectViewModel: SubjectViewModel!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        bindViewModel()
        
        sectionTitleLabel.text = sectionTitle
        self.view.layer.cornerRadius = 20
        addButton.backgroundColor = .mintgreen
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitleColor(.mintgreen, for: .highlighted)
        addButton.layer.cornerRadius = 10
        addButton.layer.shadowColor = UIColor.gray.cgColor
        addButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        addButton.layer.shadowOpacity = 1
//        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
     override func viewDidAppear(_ animated: Bool) {
        tableHeight.constant = tableView.contentSize.height
    }
    func setup(sectionTitle: String) {
        self.sectionTitle = sectionTitle
        self.view.backgroundColor = .whitegray
        self.view.layer.masksToBounds = false
        self.view.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowRadius = 4
        self.tableView.backgroundColor = .whitegray
        
    }
    @objc func keyboardWillBeShown(notification: Notification) {
        
    }
    @objc func keyboardDidHide(notification: Notification) {
        
    }
    @IBAction func addButtonAction(_ sender: Any) {
        guard let text = textField.text, text != "" else { return }
        tmpData.append(text)
        updateTableView()
        textField.text = ""
        
    }
    func updateTableView() {
       UIView.animate(withDuration: 0.3, animations: {
           self.tableView.reloadData()
       }) { (finished) in
           self.tableView.layoutIfNeeded()
        self.tableHeight.constant = self.tableView.contentSize.height
       }
    }
    
//    /// ViewModelを初期化
    func initializeViewModel() {
        subjectViewModel = SubjectViewModel(
            with: SubjectModel(),
            and: SubjectNavigator(with: self)
        )
    }
    /// ViewModelをバインド
    func bindViewModel() {
        let input = SubjectViewModel.Input(trigger: Driver.just(()),
                                           insertpostTrigger: addButton.rx.tap.asDriver(),
//                                           selectTrigger: textField.rx.text
//                                            .map { if let t = $0 { return t } else { return "" } }
//                                            .asDriver(onErrorJustReturn: ""),
                                           deleteTrigger: tableView.rx.itemSelected.asDriver().map { $0.row },
                                           content: tableView.rx.itemDeleted.asDriver().map { $0.row })
        let output = subjectViewModel.transform(input: input)

        output.posts
            .drive(tableView.rx.items(cellIdentifier: R.reuseIdentifier.categoryTableViewCell.identifier, cellType: CategoryTableViewCell.self)) { (row, element, cell) in
                cell.setUpCell(text: element.content)
            }
            .disposed(by: disposeBag)
        output.load.drive().disposed(by: disposeBag)
        output.select.drive().disposed(by: disposeBag)
        output.delete.drive().disposed(by: disposeBag)
        output.toPost.drive().disposed(by: disposeBag)
    }
//
}
//
//extension SubjectViewController: UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tmpData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
//        cell.setUpCell(text: tmpData[indexPath.item])
//        cell.selectionStyle = .none
//        return cell
//    }
//    //セルの編集許可
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    //スワイプしたセルを削除　※arrayNameは変数名に変更してください
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            tmpData.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
//            updateTableView()
//        }
//    }
//
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//    }
//    // 並び替えのみ有効
////    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
////        return .none
////    }
//
//}
//extension SubjectViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//        // 削除のアクションを設定する
//        let deleteAction = UIContextualAction(style: .destructive, title:"delete") {
//            (ctxAction, view, completionHandler) in
//            self.tmpData.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            completionHandler(true)
//            self.updateTableView()
//        }
//        // 削除ボタンのデザインを設定する
////        let trashImage = UIImage(systemName: "trash.fill")?.withTintColor(UIColor.white , renderingMode: .alwaysTemplate)
////        deleteAction.image = trashImage
//        deleteAction.backgroundColor = .whitegray
//        deleteAction.title = "削除"
//        deleteAction.image =  UIImage(named: "trash")
//
//        // スワイプでの削除を無効化して設定する
//        let swipeAction = UISwipeActionsConfiguration(actions:[deleteAction])
//        swipeAction.performsFirstActionWithFullSwipe = true
//
//        return swipeAction
//
//    }
//}
