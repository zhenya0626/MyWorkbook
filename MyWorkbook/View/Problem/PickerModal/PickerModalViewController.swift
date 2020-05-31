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
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
        contentView.layer.cornerRadius = 15
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PickerModalTableViewCell", bundle: nil), forCellReuseIdentifier: "PickerModalTableViewCell")
        tableView.separatorStyle = .none
        
        
        
        // Do any additional setup after loading the view.
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
        return cell 
    }

    
    
    
}
extension PickerModalViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HorizontalAnimator(scrollDirection: .left)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HorizontalAnimator(scrollDirection: .right)
    }
}


