//
//  PickerModalTableViewCell.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/31.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class PickerModalTableViewCell: UITableViewCell {

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
        self.layer.cornerRadius = 15
        self.backgroundColor = .white
        titleLabel.textColor = .mintgreen
    }
    
}
