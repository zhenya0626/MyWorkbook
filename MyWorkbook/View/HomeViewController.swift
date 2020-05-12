//
//  HomeViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var subjectCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
//        subjectCollectionView.delegate = self
        subjectCollectionView.dataSource = self
        subjectCollectionView.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubjectCollectionViewCell")

        // セルの大きさを設定
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: subjectCollectionView.frame.width, height: 100)
        layout.scrollDirection = .horizontal
        subjectCollectionView.collectionViewLayout = layout

    }
    @objc func toCategoryVC(sender: UIButton) {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
        self.present(categoryVC, animated: true, completion: nil)
    }
    func setUpNav(){
        // ステータスバーのタイトル色指定
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        // ステータスバーの背景色指定
//        if #available(iOS 11.0, *) {
//            let statusBarBackground = UIView(frame: CGRect(x: 0.0, y: 0.0,
//              width: UIApplication.shared.statusBarFrame.size.width,
//              height: UIApplication.shared.statusBarFrame.size.height))
//            statusBarBackground.backgroundColor = UIColor.ultromarine_dark25
//            self.view.addSubview(statusBarBackground)
//        } else {
//            UIApplication.shared.statusBarView?.backgroundColor = UIColor.ultramarine
//        }
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension HomeViewController: UICollectionViewDelegate {
//
//}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = subjectCollectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCell", for: indexPath) as! SubjectCollectionViewCell
//        cell.setUpCell(text: "ああああああああああああ")
        return cell
    }
    
    
}

