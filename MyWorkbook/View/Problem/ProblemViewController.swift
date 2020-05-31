//
//  ProblemViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class ProblemViewController: UIViewController {
    
    let subjectList = ["数学", "物理", "英語"]
    private var subjectSelectedLabel:UILabel!
    let workBookList = ["数学の問題集", "物理の問題集", "英語の問題集"]
    
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var workBookTextField: UITextField!
    
    var subjectPickerView: UIPickerView = UIPickerView()
    var workBookPickerView: UIPickerView = UIPickerView()
    
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
        
        
        subjectPickerView.delegate = self
        subjectPickerView.dataSource = self
        subjectPickerView.showsSelectionIndicator = true
        subjectPickerView.tag = 0
        
        workBookPickerView.delegate = self
        workBookPickerView.dataSource = self
        workBookPickerView.showsSelectionIndicator = true
        workBookPickerView.tag = 1
        

        let toolbar1 = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done1))
        let cancelItem1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel1))
        toolbar1.setItems([cancelItem1, doneItem1], animated: true)

        self.subjectTextField.inputView = subjectPickerView
        self.subjectTextField.inputAccessoryView = toolbar1
        
        
        let toolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done2))
        let cancelItem2 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancel2))
        toolbar2.setItems([cancelItem2, doneItem2], animated: true)
        
        self.workBookTextField.inputView = workBookPickerView
        self.workBookTextField.inputAccessoryView = toolbar2
        
        subjectPickerView.backgroundColor = .white
        subjectPickerView.showsSelectionIndicator = false
        
    }
    @objc func cancel1() {
        self.subjectTextField.text = ""
        self.subjectTextField.endEditing(true)
    }

    @objc func done1() {
        self.subjectTextField.endEditing(true)
    }
    @objc func cancel2() {
        self.workBookTextField.text = ""
        self.workBookTextField.endEditing(true)
    }

    @objc func done2() {
        self.workBookTextField.endEditing(true)
    }
    
    @IBAction func addQuestionImage(_ sender: Any) {
        let picker = UIImagePickerController() //アルバムを開く処理を呼び出す
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.view.tag = 0
        present(picker, animated: true)
        self.present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func addAnswerImage(_ sender: Any) {
        let picker = UIImagePickerController() //アルバムを開く処理を呼び出す
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.view.tag = 1
        present(picker, animated: true)
        self.present(picker, animated: true, completion: nil)
    }
    
    

}
extension ProblemViewController: UIPickerViewDelegate {
    
}
extension ProblemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return subjectList.count
        } else {
            return workBookList.count
        }
    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView.tag == 0 {
//            return subjectList[row]
//        } else {
//            return workBookList[row]
//        }
//
//
//    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            self.subjectTextField.text = subjectList[row]
        } else {
            self.workBookTextField.text = workBookList[row]
        }
        
    }
    // pickerに表示するUIViewを返す
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        let titleData = subjectList[row] as! String
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "HiraKakuProN-W3", size: 20.0)!,NSAttributedString.Key.foregroundColor:UIColor.gray])

        // fontサイズ、テキスト
        pickerLabel.attributedText = myTitle
        // 中央寄せ ※これを指定しないとセンターにならない
        pickerLabel.textAlignment = NSTextAlignment.center
        pickerLabel.frame = pickerView.frame
        // ラベルを角丸に
        pickerLabel.layer.masksToBounds = true
        pickerLabel.layer.cornerRadius = 5.0
        pickerLabel.backgroundColor = .mintgreen
        pickerLabel.textColor = .white

//               //  既存ラベル、選択状態のラベルが存在している
//        if let lb = pickerView.view(forRow: row, forComponent: component) as? UILabel,
//                    let selected = self.subjectSelectedLabel {
//                    // 設定
//                    self.subjectSelectedLabel = lb
//            self.subjectSelectedLabel.backgroundColor = UIColor.orange
//            self.subjectSelectedLabel.textColor = UIColor.white
//                }

                return pickerLabel
    }
    // pickerが選択された際に呼ばれる
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row: \(row)")
        print("value: \(subjectList[row])")

        // 選択状態のラベルを代入
        self.subjectSelectedLabel = pickerView.view(forRow: row, forComponent: component) as! UILabel
        // ピッカーのリロードでviewForRowが呼ばれる
        pickerView.reloadComponent(component)
    }
    

    
    
}

extension ProblemViewController: UIImagePickerControllerDelegate{
    // 画像が選択された時に呼ばれる
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
          if let selectedImage = info[.originalImage] as? UIImage {
            if picker.view?.tag == 0 {
                questionImage.image = selectedImage
            } else {
                answerImage.image = selectedImage
            }
            //imageViewにカメラロールから選んだ画像を表示する
          }
          self.dismiss(animated: true)  //画像をImageViewに表示したらアルバムを閉じる
      }
      
      // 画像選択がキャンセルされた時に呼ばれる
      func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          self.dismiss(animated: true, completion: nil)
      }
}
extension ProblemViewController: UINavigationControllerDelegate{
    
}

