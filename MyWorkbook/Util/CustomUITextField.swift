//
//  CustomUITextField.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/15.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField, UITextFieldDelegate  {
    
    var bottomLine: CALayer = CALayer()
    override func awakeFromNib() {
        self.delegate = self
        // 初期スタイルを指定
        self.borderStyle = .none
        self.backgroundColor = .clear
        self.textAlignment = .center
        self.returnKeyType = .done
        self.addBottomBorder()
    }
    func addBottomBorder(){
        bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 5, y: self.frame.size.height - 1, width: self.frame.size.width - 9, height: 1.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    func changeBottomBorder(uiColor: UIColor) {
        bottomLine.backgroundColor = uiColor.cgColor
    }
    /// テキストフィールド入力状態後
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // スタイルを編集中のものに変更
//        self.borderStyle = .roundedRect
//        self.borderInactiveColor = UIColor.ultramarine
        self.backgroundColor = .white
        changeBottomBorder(uiColor: .mintgreen)
        print("aaaa")
        
    }

    /// リターンキー入力時
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }

    /// フォーカスが外れる前
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // 入力チェック
        if(self.text == ""){
            changeBottomBorder(uiColor: .red)
            return false
        }
        else{
            return true
        }
    }

    /// フォーカスが外れた後
    func textFieldDidEndEditing(_ textField: UITextField) {
        // スタイルを元に戻す
        self.borderStyle = .none
        self.backgroundColor = .clear
        changeBottomBorder(uiColor: .lightGray)
    }

}

