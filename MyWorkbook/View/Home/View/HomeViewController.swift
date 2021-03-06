//
//  HomeViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    
    @IBOutlet weak var workbookColectionView: UICollectionView!
    
    @IBOutlet weak var tagCollectionVIew: UICollectionView!
    
    @IBOutlet weak var questionTableView: UITableView!
    
    @IBOutlet weak var topStackView: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var toggleSearchCriteriaButton: UIButton!
    
    var isOpen = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        initializeViewModel()
        
        // 教科 コレクションビュー Tag 0
        subjectCollectionView.dataSource = self
        subjectCollectionView.register(UINib(nibName: "CheckCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CheckCollectionViewCell")
        subjectCollectionView.showsHorizontalScrollIndicator = false

        // 問題集 コレクションビュー Tag 1
        workbookColectionView.dataSource = self
        workbookColectionView.register(UINib(nibName: "CheckCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CheckCollectionViewCell")
        workbookColectionView.showsHorizontalScrollIndicator = false
        
        // タグ コレクションビュー Tag 2
        tagCollectionVIew.dataSource = self
        tagCollectionVIew.register(UINib(nibName: "CheckCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CheckCollectionViewCell")
        tagCollectionVIew.showsHorizontalScrollIndicator = false
        
        
        // 問題 テーブルビュー
        // ① カスタムセルを登録
        questionTableView.register(UINib(nibName: "QuestionTableViewCell", bundle: nil), forCellReuseIdentifier: "QuestionTableViewCell")

        // ②-1 データソースを実装する - dataSourceにselfを設定
        questionTableView.dataSource = self
        
        // デリゲートも追加
        questionTableView.delegate = self

        // ③-1 セルとセルの間の線を消す
        questionTableView.separatorStyle = .none

        // ③-2 スクロールバーを非表示にする
        questionTableView.showsVerticalScrollIndicator = false
        
        
        topStackView.constant = -350
        toggleSearchCriteriaButton.setTitle("検索条件を変更する", for: .normal)
        toggleSearchCriteriaButton.setTitleColor(.gray, for: .normal)
        self.view.layoutIfNeeded()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //キーボードが表示されるタイミングで呼び出される。
        NotificationCenter.default.addObserver(self,
        selector: #selector(keyboardWillBeShown(notification:)),
        name: UIResponder.keyboardWillShowNotification,
        object: nil)
        
        // キーボードが消えるタイミングで呼び出される。
        NotificationCenter.default.addObserver(self,
        selector: #selector(keyboardWillBeHidden(notification:)),
        name: UIResponder.keyboardWillHideNotification,
        object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func initializeViewModel() {
        viewModel = HomeViewModel(with: SubjectModel() , and: HomeNavigator(with: self))
    }

    @objc func keyboardWillBeShown(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        topStackView.constant = view.bounds.height - (50 + 20)  - stackViewHeight.constant - keyboardFrame.height 
        self.view.layoutIfNeeded()
    }
    @objc func keyboardWillBeHidden(notification: Notification) {
        topStackView.constant = 0
        self.view.layoutIfNeeded()
    }
    
    @objc func toCategoryVC(sender: UIButton) {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
         self.navigationController?.pushViewController(categoryVC, animated: true)
    }
    
@IBAction func toggleSearchAction(_ sender: Any) {
    if isOpen {
        topStackView.constant = -350
        isOpen = false
        toggleSearchCriteriaButton.setTitle("検索条件を変更する", for: .normal)
        
    } else {
        topStackView.constant = 0
        isOpen = true
        toggleSearchCriteriaButton.setTitle("閉じる", for: .normal)
    }
    UIView.animate(
        withDuration: 0.3,
         delay: 0,
         options:UIView.AnimationOptions.curveEaseOut,
         animations: {() -> Void in
             // これが大事!
             self.view.layoutIfNeeded()
         },
         completion: nil
     )
}
    func setUpNav(){
        // ステータスバーのタイトル色指定
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        // ナビゲーションバーのタイトル指定
        self.navigationItem.title = "HOME"
        // ナビゲーションバーのタイトル色指定
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        // ナビゲーションバーの背景色指定
        self.navigationController?.navigationBar.barTintColor = UIColor.ultramarine
        // ナビゲーションバーの右のアイテム
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.toCategoryVC(sender:)))
        // ナビゲーションバーの右のアイテムの色指定
        rightBarButton.tintColor = UIColor.white
        // ナビゲーションアイテムを右に配置
        self.navigationItem.setRightBarButton(rightBarButton, animated: true)
    }
    
    @IBAction func addQuestionButton(_ sender: Any) {
        let probremVC = ProblemViewController()
//        probremVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(probremVC, animated: true)
    }
    


}

extension HomeViewController: UICollectionViewDataSource {
    // セクションあたりのCellの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return viewModel.subjectArray.count
        case 1:
            return viewModel.workbookArray.count
        case 2:
            return viewModel.tagArray.count
        default:
            return 0
        }
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckCollectionViewCell", for: indexPath) as! CheckCollectionViewCell

        switch collectionView.tag {
        case 0:
            cell.setUpCell(text: viewModel.subjectArray[indexPath.item])
        case 1:
            cell.setUpCell(text: viewModel.workbookArray[indexPath.item])
        case 2:
            cell.setUpCell(text: viewModel.tagArray[indexPath.item])
        default:
            cell.setUpCell(text: viewModel.subjectArray[indexPath.item])
        }
        return cell
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.cellForItem(at: indexPath) as! CheckCollectionViewCell
        let cellSize = cell.textLabel.intrinsicContentSize
        return collectionView.intrinsicContentSize
    }
    //縦の間隔を決定する
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    //横の間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
extension UICollectionView {
    override open var intrinsicContentSize: CGSize {
        return contentSize
    }
}

extension HomeViewController: UITableViewDelegate {
    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionTableViewCell
        cell.changeColor(color: .white)
        //これを追加すれば解決
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let detailVC = DetailViewController()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
// ②-2 データソースを実装する - UITableViewDataSourceを実装する
extension HomeViewController: UITableViewDataSource {
    // ②-3 データソースを実装する - セクションごとの行数を返します。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questionArray.count    }
    // ②-4 データソースを実装する - 各セルを返します。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell", for: indexPath) as! QuestionTableViewCell
        cell.setUpCell(text: viewModel.questionArray[indexPath.item])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
   
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! QuestionTableViewCell
        cell.changeColor(color: .whitegray)
    }
}


