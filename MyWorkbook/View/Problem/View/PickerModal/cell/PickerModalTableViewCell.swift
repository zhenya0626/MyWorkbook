//
//  PickerModalTableViewCell.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/31.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class PickerModalTableViewCell: UITableViewCell {

//    @IBOutlet weak var cellContentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(text: String) {
        titleLabel.text = text
        // 枠線の色
        titleLabel.layer.borderColor = UIColor.mintgreen.cgColor
        // 枠線の太さ
        titleLabel.layer.borderWidth = 1
        // 角丸
        titleLabel.layer.cornerRadius = 15
    }
    
}
