//
//  SubjectViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/23.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {


    @IBOutlet weak var addButton: UIButton!
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 20
        addButton.backgroundColor = .mintgreen
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitleColor(.mintgreen, for: .highlighted)
        addButton.layer.cornerRadius = 10
        addButton.layer.shadowColor = UIColor.gray.cgColor
        addButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        addButton.layer.shadowOpacity = 1
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.separatorStyle = .none
    }
     override func viewDidAppear(_ animated: Bool) {
        tableHeight.constant = tableView.contentSize.height
    }
    func setup() {
        self.view.backgroundColor = .whitegray
        self.view.layer.masksToBounds = false
        self.view.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowRadius = 4
        
    }

}

extension SubjectViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.setUpCell(text: "あああ")
        return cell
    }
    
    
}
