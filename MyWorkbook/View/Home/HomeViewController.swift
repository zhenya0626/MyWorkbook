//
//  HomeViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let tmpArray1 = ["数学Ⅰ", "数学Ⅱ", "物理", "化学演習", "英語"]
    let tmpArray2 = ["〇〇問題集", "数学ⅠA問題集", "〇〇式", "化学演習", "物理演習", "数学B問題集"]
    let tmpArray3 = ["2年前期 定期テスト", "苦手問題", "テストに出る！", "重要", "重要", "重要"]
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    
    @IBOutlet weak var workbookColectionView: UICollectionView!
    
    @IBOutlet weak var tagCollectionVIew: UICollectionView!
    
    @IBOutlet weak var topStackView: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        
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


}

extension HomeViewController: UICollectionViewDataSource {
    // セクションあたりのCellの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return tmpArray1.count
        case 1:
            return tmpArray2.count
        case 2:
            return tmpArray3.count
        default:
            return 0
        }
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckCollectionViewCell", for: indexPath) as! CheckCollectionViewCell

        switch collectionView.tag {
        case 0:
            cell.setUpCell(text: tmpArray1[indexPath.item])
        case 1:
            cell.setUpCell(text: tmpArray2[indexPath.item])
        case 2:
            cell.setUpCell(text: tmpArray3[indexPath.item])
        default:
            cell.setUpCell(text: tmpArray1[indexPath.item])
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

