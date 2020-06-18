//
//  CategoryViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/23.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoryViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    let sectionTitle = ["教科", "問題集", "タグ"]
    
    var categoryViewModel: CategoryViewModel!
    let disposeBag = DisposeBag()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        
        scrollView.showsVerticalScrollIndicator = false
        
        let subject = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        subject.setup(sectionTitle: sectionTitle[0])
        addChild(subject)
        stackView.addArrangedSubview(subject.view)
        
        let workbook = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        workbook.setup(sectionTitle: sectionTitle[1])
        addChild(workbook)
        stackView.addArrangedSubview(workbook.view)
        
        
        let tag = SubjectViewController.init(nibName: "SubjectViewController", bundle: nil)
        tag.setup(sectionTitle: sectionTitle[2])
        addChild(tag)
        stackView.addArrangedSubview(tag.view)

        // Do any additional setup after loading the view.
    }
    func initializeViewModel() {
        categoryViewModel = CategoryViewModel(
            with: SubjectModel(),
            and: CategoryNavigator(with: self)
        )
    }
}
