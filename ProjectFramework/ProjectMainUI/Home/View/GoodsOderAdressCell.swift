//
//  GoodsOderAdressCell.swift
//  LKKJ
//
//  Created by Jinjun liang on 2017/11/7.
//  Copyright © 2017年 HCY. All rights reserved.
//

import UIKit

class GoodsOderAdressCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class GoodsOderCell: UITableViewCell {
    
    @IBOutlet weak var goodsImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountsLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
}
