//
//  SubjectViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/23.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    
    var tmpData = ["ああああ","いいいいいい"]

    @IBOutlet weak var addButton: UIButton!
   
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var textField: UITextField!
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
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
       UIView.animate(withDuration: 0.0, animations: {
           self.tableView.reloadData()
       }) { (finished) in
           self.tableView.layoutIfNeeded()
        self.tableHeight.constant = self.tableView.contentSize.height
       }
    }
    
}

extension SubjectViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tmpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
        cell.setUpCell(text: tmpData[indexPath.item])
        return cell
    }

}
