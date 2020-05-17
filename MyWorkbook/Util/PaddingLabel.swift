//
//  CustomUILabel.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/15.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

// 内部に余白を持ったUILabel
public class PaddingLabel: UILabel {
    // 余白のサイズ
    public var padding: UIEdgeInsets = .zero
    

    // テキストの描画範囲を余白のInsetを加えたものにする
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    // Intrinsic Content Sizeを余白のInset加えたものにする
    public override var intrinsicContentSize: CGSize {
        var intrinsicContentSize = super.intrinsicContentSize
        intrinsicContentSize.height += padding.top + padding.bottom
        intrinsicContentSize.width += padding.left + padding.right
        return intrinsicContentSize
    }
}
