//
//  CategoryViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/23.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsVerticalScrollIndicator = false
        
        let subject = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        subject.setup()
        addChild(subject)
        stackView.addArrangedSubview(subject.view)
        
        let workbook = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        workbook.setup()
        addChild(workbook)
        stackView.addArrangedSubview(workbook.view)
        
        
        let tag = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        tag.setup()
        addChild(tag)
        stackView.addArrangedSubview(tag.view)

        // Do any additional setup after loading the view.
    }
}
