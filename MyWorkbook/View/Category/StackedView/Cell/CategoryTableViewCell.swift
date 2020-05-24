//
//  CategoryTableViewCell.swift
//  MyWorkbook
//
//  Created by abi01373 on 2020/05/23.
//  Copyright © 2020 zhenya. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(text: String) {
        myLabel.text = text
        cellView.layer.cornerRadius = 10
    }
    
}
