//
//  GoodsDetailInfoCell.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsDetailInfoCell: UITableViewCell {

    @IBOutlet weak var titlLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var soldOutLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    override func awakeFromNib() {
        
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
