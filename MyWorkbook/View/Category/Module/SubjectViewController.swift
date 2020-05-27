//
//  SubjectViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/26.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    var height: CGFloat = 0

    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewHeight.constant = height
        // Do any additional setup after loading the view.
    }
    func setUp(height: CGFloat, color: UIColor) {
        self.height = height
        self.view.backgroundColor = color

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
