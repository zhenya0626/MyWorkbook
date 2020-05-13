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
    @objc func toCategoryVC(sender: UIButton) {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
//        self.present(categoryVC, animated: true, completion: nil)
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
            print("0", tmpArray1[indexPath.item])
            print(cell)
            cell.setUpCell(text: tmpArray1[indexPath.item])
        case 1:
            print("1", tmpArray2[indexPath.item])
            print(cell)
            cell.setUpCell(text: tmpArray2[indexPath.item])
        case 2:
            print("2", tmpArray3[indexPath.item])
            print(cell)
            cell.setUpCell(text: tmpArray3[indexPath.item])
        default:
            cell.setUpCell(text: tmpArray1[indexPath.item])
        }
        return cell
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = view.frame.size.width/5
        return CGSize(width: 500, height: cellSize)
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

