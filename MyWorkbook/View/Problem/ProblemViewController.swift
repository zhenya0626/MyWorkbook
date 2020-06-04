//
//  ProblemViewController.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/10.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class ProblemViewController: UIViewController {
    
    let subjectList = ["数学", "物理", "英語", "化学"]
    var subjectSelectedIndex = 0
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
        // ナビゲーションバーの self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのタイトル指定
        self.navigationItem.title = "問題追加"
        // ナビゲーションバーのタイトル色指定
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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

//        self.subjectTextField.inputView = pickerModalVC.view
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
    
    @IBAction func tappedSubjectTextField(_ sender: Any) {
        let pickerModalVC = PickerModalViewController()
        pickerModalVC.modalPresentationStyle = .custom
        pickerModalVC.transitioningDelegate = self
        pickerModalVC.delegate = self
        self.present(pickerModalVC, animated: true, completion: nil)
    }
    @IBAction func toPracticeButtonAction(_ sender: Any) {
        let practiceVC = PracticeViewController()
        self.navigationController?.pushViewController(practiceVC, animated: true)
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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return subjectList[row]
        } else {
            return workBookList[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            self.subjectTextField.text = subjectList[row]
        } else {
            self.workBookTextField.text = workBookList[row]
        }
        
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

extension ProblemViewController: UIImagePickerControllerDelegate {
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

extension ProblemViewController: PickerModalViewDelegate {
    var selectedIndex: Int {
        get {
            subjectSelectedIndex
        }
        set {
            subjectSelectedIndex = newValue
            self.subjectTextField.text = subjectList[newValue]
        }
    }
    
    var list: [String] {
        get {
            self.subjectList
        }
    }
    
}

extension ProblemViewController:  UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PickerModalAnimator(isPresentingDrawer: false)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PickerModalAnimator(isPresentingDrawer: true)
    }
}
class PickerModalAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let isPresentingDrawer: Bool
    let dimmingView = UIView()
    init(isPresentingDrawer: Bool) {
        self.isPresentingDrawer = isPresentingDrawer
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Retrieve the view controllers participating in the current transition from the context.
        let fromView = transitionContext.viewController(forKey: .from)!.view!
        let toView = transitionContext.viewController(forKey: .to)!.view!

        // If the view to transition from is this controller's view, the drawer is being presented.
//        let isPresentingDrawer = fromView == view
        
        let drawerView = isPresentingDrawer ? toView : fromView

        if isPresentingDrawer {
            // Any presented views must be part of the container view's hierarchy
            
            transitionContext.containerView.addSubview(dimmingView)
            dimmingView.frame = transitionContext.containerView.bounds
            dimmingView.alpha = 0.0
            dimmingView.backgroundColor = .black
            transitionContext.containerView.addSubview(drawerView)
        }
        

        /***** Animation *****/
        
        
        
        let drawerSize = CGSize(
            width: UIScreen.main.bounds.size.width * 0.8,
            height: UIScreen.main.bounds.size.height / 2)
        
        // Determine the drawer frame for both on and off screen positions.
        let offScreenDrawerFrame = CGRect(origin: CGPoint(x: transitionContext.containerView.bounds.width / 2, y:transitionContext.containerView.bounds.height / 2), size: CGSize(width: 0, height: 0))
        let onScreenDrawerFrame = CGRect(origin: CGPoint(x: transitionContext.containerView.bounds.width / 2 - drawerSize.width / 2, y: drawerSize.height / 2), size: drawerSize)
        
        let offScreenDrawerAlpha = 0.0
        let onScreenDrawerAlpha = 1.0
        
        let offScreenDrawerCorner = 15
        let onScreenDrawerCorner = 15
        
        // 遷移前の状態
        drawerView.frame = isPresentingDrawer ? onScreenDrawerFrame : onScreenDrawerFrame
        drawerView.alpha = CGFloat(isPresentingDrawer ? offScreenDrawerAlpha : onScreenDrawerAlpha)
        drawerView.layer.cornerRadius = CGFloat(isPresentingDrawer ? offScreenDrawerCorner : onScreenDrawerCorner)
        dimmingView.alpha = isPresentingDrawer ? 0.0 : 0.5
        let animationDuration = transitionDuration(using: transitionContext)
        
        // Animate the drawer sliding in and out.
        UIView.animate(withDuration: animationDuration, animations: {
            // 遷移後の状態
            drawerView.frame = self.isPresentingDrawer ? onScreenDrawerFrame : onScreenDrawerFrame
            drawerView.alpha = CGFloat(self.isPresentingDrawer ? onScreenDrawerAlpha : offScreenDrawerAlpha)
            drawerView.layer.cornerRadius = CGFloat(self.isPresentingDrawer ? onScreenDrawerCorner : offScreenDrawerCorner)
            self.dimmingView.alpha = self.isPresentingDrawer ? 0.5 : 0.0
            
        }, completion: { (success) in
            // Cleanup view hierarchy
            if !self.isPresentingDrawer {
                drawerView.removeFromSuperview()
            }
            
            // IMPORTANT: Notify UIKit that the transition is complete.
            transitionContext.completeTransition(success)
        })
    }
}

