//
//  QuestionTableViewCell.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/19.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell() {
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.layer.masksToBounds = true
        cellBackgroundView.layer.masksToBounds = false
        cellBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cellBackgroundView.layer.shadowColor = UIColor.black.cgColor
        cellBackgroundView.layer.shadowOpacity = 0.23
        cellBackgroundView.layer.shadowRadius = 4
    }
    func changeColor(color: UIColor) {
        cellBackgroundView.backgroundColor = color
    }
    
    
}
