//
//  ProblemViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class ProblemViewController: UIViewController {

    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionImageHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var answerImageHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        let img1 = UIImage(named: "biseki")
        let w1 = img1?.size.width ?? 0
        let h1 = img1?.size.height ?? 1
        questionImageHeight.constant = questionImage.frame.width / w1 * h1
        
        let img2 = UIImage(named: "biseki")
        let w2 = img2?.size.width ?? 0
        let h2 = img2?.size.height ?? 1
        answerImageHeight.constant = questionImage.frame.width / w2 * h2
        
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
