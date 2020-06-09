//
//  PracticeViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

enum PracticeStatus {
    case ready
    case solve
    case check
    case enter
}

class PracticeViewController: UIViewController {
    var addTimer = Timer()
    var timerCount = 0
    var practiceStatus: PracticeStatus = .ready
    
    @IBOutlet weak var changeStatusButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // ナビゲーションバーのタイトル指定
               self.navigationItem.title = "出題"
               // ナビゲーションバーのタイトル色指定
               self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        timerLabel.text = "0"

        // Do any additional setup after loading the view.
    }
    // タイマーで呼び出されるメソッド
    @objc func timerCall() {

        timerCount += 1
        timerLabel.text = "\(timerCount)"

    }

    @IBAction func changeStatusButtonAction(_ sender: Any) {
        switch practiceStatus {
        case .ready:
            // タイマーの設定（5秒間隔でメソッド「timerCall」を呼び出す）
            addTimer =  Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCall), userInfo: nil, repeats: true)
            practiceStatus = .solve
            changeStatusButton.setTitle("解答終了", for: .normal)
            
        case .solve:
            // タイマーを無効にする
            addTimer.invalidate()
            practiceStatus = .check
            changeStatusButton.setTitle("採点終了", for: .normal)
            
        case .check:
            print("a")
            practiceStatus = .enter
            
        case .enter:
            print("b")
        }
        
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
extension PracticeViewController: UITextViewDelegate {
    
}
