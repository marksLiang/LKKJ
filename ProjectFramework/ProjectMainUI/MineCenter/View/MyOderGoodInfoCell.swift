//
//  MyOderGoodInfoCell.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/8.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class MyOderGoodInfoCell: UITableViewCell {

    @IBOutlet weak var goodsImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
