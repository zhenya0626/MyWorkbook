//
//  CheckCollectionViewCell.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/12.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class CheckCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func setUpCell(text: String) {
        textLabel.text = text
        print("textLabel", textLabel.text)
        textLabel.sizeToFit()

    }

}
