//
//  PickerModalViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/31.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class PickerModalViewController: UIViewController {
    var delegate: PickerModalViewDelegate? = nil
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.transitioningDelegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PickerModalTableViewCell", bundle: nil), forCellReuseIdentifier: "PickerModalTableViewCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        //右上と左下を角丸にする設定
        titleLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 15
        titleLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

protocol PickerModalViewDelegate {
    var list: [String] { get }
    var selectedIndex: Int { get set }
    
}
extension PickerModalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedIndex = indexPath.item
        self.dismiss(animated: true, completion: nil)
    }
}

extension PickerModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerModalTableViewCell", for: indexPath) as! PickerModalTableViewCell
        cell.setUpCell(text: delegate?.list[indexPath.item] ?? "default value")
        cell.selectionStyle = .none
        return cell 
    }

}
//extension PickerModalViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return HorizontalAnimator(scrollDirection: .left)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return HorizontalAnimator(scrollDirection: .right)
//    }
//}


