//
//  HomeViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let tmpArray = ["ああああああああああああ", "あ", "ああ", "あああ", "ああああ", "ああああああああ"]
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
//        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self
        subjectCollectionView.register(UINib(nibName: "CheckCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CheckCollectionViewCell")
        subjectCollectionView.showsHorizontalScrollIndicator = false

    }
    @objc func toCategoryVC(sender: UIButton) {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
        self.present(categoryVC, animated: true, completion: nil)
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tmpArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subjectCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckCollectionViewCell", for: indexPath) as! CheckCollectionViewCell
        cell.setUpCell(text: tmpArray[indexPath.item])
        return cell
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = view.frame.size.width/5
        return CGSize(width: 0, height: cellSize)
    }
    

    
}

