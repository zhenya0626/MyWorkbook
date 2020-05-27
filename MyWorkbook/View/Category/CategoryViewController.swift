//
//  CategoryViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/24.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    
    @IBOutlet weak var stackView: UIStackView!
    let sectionTitle = ["教科", "問題集", "タグ"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        scrollView.showsVerticalScrollIndicator = false
        
        let subject = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        subject.setUp(height: 500, color: .blue)
        addChild(subject)
        stackView.addArrangedSubview(subject.view)
        
        let workbook = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
//        workbook.setup(sectionTitle: sectionTitle[1])
        workbook.setUp(height: 300, color: .green)
        addChild(workbook)
        stackView.addArrangedSubview(workbook.view)
        
        
        let tag = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
//        tag.setup(sectionTitle: sectionTitle[2])
        tag.setUp(height: 800, color: .red)
        addChild(tag)
        stackView.addArrangedSubview(tag.view)

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
