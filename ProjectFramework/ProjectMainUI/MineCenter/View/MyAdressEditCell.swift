//
//  MyAdressEditCell.swift
//  LKKJ
//
//  Created by 恋康科技 on 2017/10/16.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyAdressEditCell: UITableViewCell {

    @IBOutlet weak var littleImage: UIImageView!
    @IBOutlet weak var keyName: UILabel!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var rightText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
